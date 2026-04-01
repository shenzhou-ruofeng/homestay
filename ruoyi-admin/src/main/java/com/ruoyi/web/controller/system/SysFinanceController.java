package com.ruoyi.web.controller.system;

import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysDictData;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.SysOrderItem;
import com.ruoyi.system.domain.vo.SysOrderItemVo;
import com.ruoyi.system.service.ISysDictDataService;
import com.ruoyi.system.service.ISysOrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

/**
 * 财务Controller
 *
 * @author ruoyi
 * @date 2024-02-02
 */
@RestController
@RequestMapping("/system/finance")
public class SysFinanceController extends BaseController {
    @Autowired
    private ISysOrderItemService sysOrderItemService;
    @Autowired
    private ISysDictDataService sysDictDataService;

    /**
     * 查询所有房源总盈利、所有特色服务总盈利、所有子订单列表的盈利
     */
    @PreAuthorize("@ss.hasPermi('system:finance:list')")
    @GetMapping("/list")
    public AjaxResult list() {
        startPage();
        //获取平台的手续费比例
        SysDictData sysDictData = new SysDictData();
        sysDictData.setDictLabel("feeRatio");
        SysDictData dictData = sysDictDataService.selectDictDataList(sysDictData).get(0);
        BigDecimal feeRatio = new BigDecimal(Integer.parseInt(dictData.getDictValue())).divide(new BigDecimal(100), 2, RoundingMode.HALF_UP);
        //房东仅查询自己的订单
        SysOrderItemVo sysOrderItem = new SysOrderItemVo();
        sysOrderItem.setStatusList(new Integer[]{0, 1, 2, 3});
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房东身份，仅查自己的
            sysOrderItem.setLandlordUserId(getUserId());
        }
        List<SysOrderItemVo> orderItemList = sysOrderItemService.selectSysOrderItemVoListByVo(sysOrderItem);
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房东的利润=订单金额*（1-手续费）-成本
            for (SysOrderItemVo sysOrderItemVo : orderItemList) {
                BigDecimal subtract = new BigDecimal(1).subtract(feeRatio);
                sysOrderItemVo.setCost(sysOrderItemVo.getCost()==null?new BigDecimal(0):sysOrderItemVo.getCost());
                sysOrderItemVo.setProfit(sysOrderItemVo.getTotal().multiply(subtract).subtract(sysOrderItemVo.getCost()));
            }
        } else {
            //管理员，平台的利润=订单金额*手续费
            for (SysOrderItemVo sysOrderItemVo : orderItemList) {
                sysOrderItemVo.setProfit(sysOrderItemVo.getTotal().multiply(feeRatio));
            }
        }
        BigDecimal houseProfit = orderItemList.stream()
                .filter(obj -> obj.getType() == 1)
                .map(SysOrderItemVo::getProfit)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal serviceProfit = orderItemList.stream()
                .filter(obj -> obj.getType() == 2)
                .map(SysOrderItemVo::getProfit)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        JSONObject object = new JSONObject();
        object.put("houseProfit", houseProfit);
        object.put("serviceProfit", serviceProfit);
        TableDataInfo dataTable = getDataTable(orderItemList);
        object.put("rows", dataTable.getRows());
        object.put("total", dataTable.getTotal());
        object.put("feeRatio", dictData.getDictValue());
        return AjaxResult.success(object);
    }


}
