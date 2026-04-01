package com.ruoyi.web.controller.system;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.SysOrderItem;
import com.ruoyi.system.domain.vo.SysOrderItemVo;
import com.ruoyi.system.domain.vo.SysOrderVo;
import com.ruoyi.system.service.ISysOrderItemService;
import org.springframework.beans.BeanUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.service.ISysOrderService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 主订单Controller
 *
 * @date 2024-02-02
 */
@RestController
@RequestMapping("/system/order")
public class SysOrderController extends BaseController {
    @Autowired
    private ISysOrderService sysOrderService;
    @Autowired
    private ISysOrderItemService sysOrderItemService;

    /**
     * 查询主订单列表
     */
    @PreAuthorize("@ss.hasPermi('system:order:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysOrder sysOrder) {
        startPage();
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房东身份，仅查自己的
            sysOrder.setLandlordUserId(getUserId());
        }
        //查询的订单状态为子订单状态，故查询主订单需把状态置为null
        Integer status = sysOrder.getStatus();
        if (status != null) {
            sysOrder.setStatus(null);
        }
        List<SysOrder> list = sysOrderService.selectSysOrderList(sysOrder);
        SysOrderItem sysOrderItem = new SysOrderItem();
        sysOrderItem.setUserId(sysOrder.getUserId());
        List<SysOrderItemVo> orderItemList = sysOrderItemService.selectSysOrderItemVoList(sysOrderItem);
        List<SysOrderVo> result = new ArrayList<>();
        for (SysOrder order : list) {
            SysOrderVo sysOrderVo = new SysOrderVo();
            BeanUtils.copyProperties(order, sysOrderVo);
            List<SysOrderItemVo> collect = orderItemList.stream()
                    .filter(obj -> obj.getOrderId().equals(order.getOrderId()))
                    .collect(Collectors.toList());
            //判断子订单是否有相符的状态，有则存入结果数组，没有则跳过
            if (status != null) {
                long count = collect.stream().filter(obj -> status.equals(obj.getStatus())).count();
                if (count == 0) {
                    continue;
                }
            }
            sysOrderVo.setOrderItems(collect);
            result.add(sysOrderVo);
        }
        return getDataTable(result);
    }

    /**
     * 导出主订单列表
     */
    @PreAuthorize("@ss.hasPermi('system:order:export')")
    @Log(title = "主订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysOrder sysOrder) {
        List<SysOrder> list = sysOrderService.selectSysOrderList(sysOrder);
        ExcelUtil<SysOrder> util = new ExcelUtil<SysOrder>(SysOrder.class);
        util.exportExcel(response, list, "主订单数据");
    }

    /**
     * 获取主订单详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:order:query')")
    @GetMapping(value = "/{orderId}")
    public AjaxResult getInfo(@PathVariable("orderId") Long orderId) {
        return success(sysOrderService.selectSysOrderByOrderId(orderId));
    }

    /**
     * 新增主订单
     */
    @PreAuthorize("@ss.hasPermi('system:order:add')")
    @Log(title = "主订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysOrder sysOrder) {
        return toAjax(sysOrderService.insertSysOrder(sysOrder));
    }

    /**
     * 修改主订单
     */
    @PreAuthorize("@ss.hasPermi('system:order:edit')")
    @Log(title = "主订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysOrder sysOrder) {
        return toAjax(sysOrderService.updateSysOrder(sysOrder));
    }

    /**
     * 删除主订单
     */
    @PreAuthorize("@ss.hasPermi('system:order:remove')")
    @Log(title = "主订单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{orderIds}")
    public AjaxResult remove(@PathVariable Long[] orderIds) {
        return toAjax(sysOrderService.deleteSysOrderByOrderIds(orderIds));
    }
}
