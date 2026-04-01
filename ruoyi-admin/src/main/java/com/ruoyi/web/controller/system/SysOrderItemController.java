package com.ruoyi.web.controller.system;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.system.domain.SysOrderItem;
import com.ruoyi.system.service.ISysOrderItemService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 子订单Controller
 * 
 * @author ruoyi
 * @date 2024-02-02
 */
@RestController
@RequestMapping("/system/item")
public class SysOrderItemController extends BaseController
{
    @Autowired
    private ISysOrderItemService sysOrderItemService;

    /**
     * 查询子订单列表
     */
    @PreAuthorize("@ss.hasPermi('system:item:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysOrderItem sysOrderItem)
    {
        startPage();
        List<SysOrderItem> list = sysOrderItemService.selectSysOrderItemList(sysOrderItem);
        return getDataTable(list);
    }

    /**
     * 导出子订单列表
     */
    @PreAuthorize("@ss.hasPermi('system:item:export')")
    @Log(title = "子订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysOrderItem sysOrderItem)
    {
        List<SysOrderItem> list = sysOrderItemService.selectSysOrderItemList(sysOrderItem);
        ExcelUtil<SysOrderItem> util = new ExcelUtil<SysOrderItem>(SysOrderItem.class);
        util.exportExcel(response, list, "子订单数据");
    }

    /**
     * 获取子订单详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:item:query')")
    @GetMapping(value = "/{orderItemId}")
    public AjaxResult getInfo(@PathVariable("orderItemId") Long orderItemId)
    {
        return success(sysOrderItemService.selectSysOrderItemByOrderItemId(orderItemId));
    }

    /**
     * 新增子订单
     */
    @PreAuthorize("@ss.hasPermi('system:item:add')")
    @Log(title = "子订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysOrderItem sysOrderItem)
    {
        return toAjax(sysOrderItemService.insertSysOrderItem(sysOrderItem));
    }

    /**
     * 修改子订单
     */
    @PreAuthorize("@ss.hasPermi('system:item:edit')")
    @Log(title = "子订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysOrderItem sysOrderItem)
    {
        return toAjax(sysOrderItemService.updateSysOrderItem(sysOrderItem));
    }

    /**
     * 删除子订单
     */
    @PreAuthorize("@ss.hasPermi('system:item:remove')")
    @Log(title = "子订单", businessType = BusinessType.DELETE)
	@DeleteMapping("/{orderItemIds}")
    public AjaxResult remove(@PathVariable Long[] orderItemIds)
    {
        return toAjax(sysOrderItemService.deleteSysOrderItemByOrderItemIds(orderItemIds));
    }
}
