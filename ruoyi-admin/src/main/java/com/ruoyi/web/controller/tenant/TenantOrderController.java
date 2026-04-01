package com.ruoyi.web.controller.tenant;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.domain.SysOrderItem;
import com.ruoyi.system.domain.vo.SysOrderItemVo;
import com.ruoyi.system.domain.vo.SysOrderVo;
import com.ruoyi.system.service.ISysHouseService;
import com.ruoyi.system.service.ISysOrderItemService;
import com.ruoyi.system.service.ISysOrderService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 订单Controller
 *
 * @date 2024-02-02
 */
@RestController
@RequestMapping("/tenant/order")
public class TenantOrderController extends BaseController {
    @Autowired
    private ISysOrderService sysOrderService;
    @Autowired
    private ISysOrderItemService sysOrderItemService;

    /**
     * 新增主订单
     */
    @PostMapping
    public AjaxResult add(@RequestBody SysOrderVo sysOrderVo) {
        //判断订单预订的日期是否已被占用
        SysOrderVo exist = new SysOrderVo();
        exist.setStartDate(sysOrderVo.getArrivalDate());
        exist.setEndDate(sysOrderVo.getDepartureDate());
        exist.setStatusList(new Integer[]{0, 1, 3});
        List<SysOrder> sysOrders = sysOrderService.selectSysOrderListByOrderVo(exist);
        if (sysOrders.size() > 0) {
            return AjaxResult.error("该民宿预订日期已排满");
        }
        //新增订单
        sysOrderVo.setUserId(getUserId());
        boolean result = sysOrderService.insertOrder(sysOrderVo);
        return result ? AjaxResult.success("保存订单成功") : AjaxResult.error("保存订单失败");
    }


    /**
     * 查询订单列表
     */
    @GetMapping("/list")
    public TableDataInfo list(SysOrderVo sysOrderVo) {
        startPage();
        sysOrderVo.setUserId(getUserId());
        List<SysOrder> list = sysOrderService.selectSysOrderListByOrderVo(sysOrderVo);
        SysOrderItem sysOrderItem = new SysOrderItem();
        sysOrderItem.setUserId(getUserId());
        List<SysOrderItemVo> sysOrderItems = sysOrderItemService.selectSysOrderItemVoList(sysOrderItem);
        List<SysOrderVo> result = new ArrayList<>();
        for (SysOrder order : list) {
            SysOrderVo orderVo = new SysOrderVo();
            BeanUtils.copyProperties(order, orderVo);
            List<SysOrderItemVo> collect = sysOrderItems.stream().filter(obj -> obj.getOrderId().equals(order.getOrderId())).collect(Collectors.toList());
            orderVo.setOrderItems(collect);
            orderVo.setImageUrl(RuoYiConfig.getImageUrl() + collect.stream().filter(item -> item.getType() == 1).findFirst().get().getImageUrl().split(",")[0]);
            result.add(orderVo);
        }
        return getDataTable(result);
    }

    /**
     * 修改主订单
     */
    @PutMapping
    public AjaxResult edit(@RequestBody SysOrder sysOrder) {
        return toAjax(sysOrderService.updateSysOrder(sysOrder));
    }

    /**
     * 修改子订单
     */
    @PutMapping("/item")
    public AjaxResult editOrderItem(@RequestBody SysOrderItem sysOrderItem) {
        return toAjax(sysOrderItemService.updateSysOrderItem(sysOrderItem));
    }

    /**
     * 删除主订单
     */
    @DeleteMapping("/{orderIds}")
    public AjaxResult remove(@PathVariable Long[] orderIds) {
        return toAjax(sysOrderService.deleteSysOrderByOrderIds(orderIds));
    }
}
