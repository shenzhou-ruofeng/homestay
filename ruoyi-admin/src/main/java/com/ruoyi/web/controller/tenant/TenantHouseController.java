package com.ruoyi.web.controller.tenant;

import com.alibaba.fastjson2.JSONObject;
import com.github.pagehelper.PageInfo;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.SysComment;
import com.ruoyi.system.domain.SysHouse;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.domain.SysService;
import com.ruoyi.system.domain.vo.SysCommentVo;
import com.ruoyi.system.domain.vo.SysHouseVo;
import com.ruoyi.system.domain.vo.SysOrderVo;
import com.ruoyi.system.service.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 房源Controller
 *
 * @date 2024-01-25
 */
@RestController
@RequestMapping("/tenant/house")
public class TenantHouseController extends BaseController {
    @Autowired
    private ISysHouseService sysHouseService;
    @Autowired
    private ISysOrderService sysOrderService;
    @Autowired
    private ISysServiceService sysServiceService;
    @Autowired
    private ISysCommentService sysCommentService;
    @Autowired
    private ISysUserService sysUserService;

    /**
     * 模糊查询可供租房源列表
     */
    @GetMapping("/list")
    public TableDataInfo list(SysHouseVo sysHouseVo) {
        startPage();
        List<SysHouse> list = sysHouseService.selectRentableSysHouseList(sysHouseVo);
        //图片拼接上地址
        for (SysHouse house : list) {
            List<String> url = new ArrayList<>();
            for (String fileName : house.getImageUrl().split(",")) {
                url.add(RuoYiConfig.getImageUrl() + fileName);
            }
            house.setImageUrl(String.join(",", url));
        }
        //若有开始结束日期条件，
        // 则查询（入住日期>=开始日期&&入住日期<结束日期）||（离开日期>开始日期&&离开日期<=结束日期）
        // 的进行中订单涉及的房源，房源列表排除掉这些房源即可供租
        if (sysHouseVo.getStartDate() != null && sysHouseVo.getEndDate() != null) {
            SysOrderVo sysOrderVo = new SysOrderVo();
            sysOrderVo.setStartDate(sysHouseVo.getStartDate());
            sysOrderVo.setEndDate(sysHouseVo.getEndDate());
            sysOrderVo.setStatusList(new Integer[]{0, 1, 3});
            List<Long> houseIds = sysOrderService.selectSysOrderListByOrderVo(sysOrderVo).stream()
                    .map(SysOrder::getHouseId).collect(Collectors.toList());
            //排除掉在时间范围内已有订单的房源
            list = list.stream().filter(obj -> !houseIds.contains(obj.getHouseId())).collect(Collectors.toList());
        }
        return getDataTable(list);
    }

    @GetMapping("/listAll")
    public AjaxResult listAll(SysHouse sysHouse) {
        //查询用户订单中涉及的房源
        SysOrder sysOrder = new SysOrder();
        sysOrder.setUserId(getUserId());
        List<SysOrder> sysOrders = sysOrderService.selectSysOrderList(sysOrder);
        List<Long> houseIdList = sysOrders.stream().map(SysOrder::getHouseId).collect(Collectors.toList());
        List<SysHouse> list = sysHouseService.selectSysHouseList(sysHouse).stream()
                .filter(obj -> houseIdList.contains(obj.getHouseId()))
                .collect(Collectors.toList());
        return AjaxResult.success(list);
    }

    /**
     * 获取房源详细信息
     */
    @GetMapping(value = "/{houseId}")
    public AjaxResult getInfo(@PathVariable("houseId") Long houseId) {
        SysHouse house = sysHouseService.selectSysHouseByHouseId(houseId);
        List<String> url = new ArrayList<>();
        for (String fileName : house.getImageUrl().split(",")) {
            url.add(RuoYiConfig.getImageUrl() + fileName);
        }
        house.setImageUrl(String.join(",", url));
        SysService sysService = new SysService();
        sysService.setHouseId(houseId);
        List<SysService> sysServices = sysServiceService.selectSysServiceList(sysService);
        //获取该房源的进行中订单，获取已占用日期[入住时间,离店时间)
        SysOrderVo sysOrderVo = new SysOrderVo();
        sysOrderVo.setHouseId(houseId);
        sysOrderVo.setStatusList(new Integer[]{0, 1, 3});
        List<SysOrder> sysOrders = sysOrderService.selectSysOrderListByOrderVo(sysOrderVo);
        List<String> dateList = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        for (SysOrder sysOrder : sysOrders) {
            Date arrivalDate = sysOrder.getArrivalDate();
            Date departureDate = sysOrder.getDepartureDate();
            //计算到达和离开的天数
            LocalDate arrival = arrivalDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate departure = departureDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            long between = ChronoUnit.DAYS.between(arrival, departure);
            for (int i = 0; i < between; i++) {
                dateList.add(formatter.format(arrival.plusDays(i)));
            }
        }
        //查询房源评价和特色服务评价
        SysComment sysComment = new SysComment();
        sysComment.setHouseId(houseId);
        List<SysComment> sysComments = sysCommentService.selectSysCommentList(sysComment);
        JSONObject object = JSONObject.parseObject(JSONObject.toJSONString(house));
        object.put("services", sysServices);
        object.put("disableDates", dateList);
        object.put("houseComments", sysComments.stream().filter(obj -> obj.getType() == 1).collect(Collectors.toList()));
        List<SysComment> serviceComments = sysComments.stream().filter(obj -> obj.getType() == 2).collect(Collectors.toList());
        //组装评论所需要的服务名称、用户头像和用户账号
        List<SysUser> tenants = sysUserService.selectUserListByRole("tenant");
        List<SysCommentVo> sysCommentVoList = new ArrayList<>();
        for (SysComment serviceComment : serviceComments) {
            SysCommentVo sysCommentVo = new SysCommentVo();
            BeanUtils.copyProperties(serviceComment, sysCommentVo);
            Optional<SysUser> optional = tenants.stream().filter(item -> item.getUserId().equals(serviceComment.getUserId())).findFirst();
            if (optional.isPresent()) {
                sysCommentVo.setNickName(optional.get().getNickName());
                sysCommentVo.setAvatar(optional.get().getAvatar());
            } else {
                sysCommentVo.setNickName("用户已注销");
            }
            Optional<SysService> serviceOptional = sysServices.stream().filter(obj -> obj.getServiceId().equals(serviceComment.getServiceId())).findFirst();
            if (serviceOptional.isPresent()) {
                sysCommentVo.setServiceName(serviceOptional.get().getName());
            } else {
                continue;
            }
            sysCommentVoList.add(sysCommentVo);
        }
        object.put("serviceComments", sysCommentVoList);
        return success(object);
    }

}
