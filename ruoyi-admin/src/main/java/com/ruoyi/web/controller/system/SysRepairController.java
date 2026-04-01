package com.ruoyi.web.controller.system;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.utils.SecurityUtils;
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
import com.ruoyi.system.domain.SysRepair;
import com.ruoyi.system.service.ISysRepairService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 报修Controller
 *
 * @date 2024-02-05
 */
@RestController
@RequestMapping("/system/repair")
public class SysRepairController extends BaseController {
    @Autowired
    private ISysRepairService sysRepairService;

    /**
     * 查询报修列表
     */
    @PreAuthorize("@ss.hasPermi('system:repair:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysRepair sysRepair) {
        startPage();
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房东身份，仅查自己的
            sysRepair.setLandlordUserId(getUserId());
        }
        List<SysRepair> list = sysRepairService.selectSysRepairList(sysRepair);
        return getDataTable(list);
    }

    /**
     * 导出报修列表
     */
    @PreAuthorize("@ss.hasPermi('system:repair:export')")
    @Log(title = "报修", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysRepair sysRepair) {
        List<SysRepair> list = sysRepairService.selectSysRepairList(sysRepair);
        ExcelUtil<SysRepair> util = new ExcelUtil<SysRepair>(SysRepair.class);
        util.exportExcel(response, list, "报修数据");
    }

    /**
     * 获取报修详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:repair:query')")
    @GetMapping(value = "/{repairId}")
    public AjaxResult getInfo(@PathVariable("repairId") Long repairId) {
        return success(sysRepairService.selectSysRepairByRepairId(repairId));
    }

    /**
     * 新增报修
     */
    @PreAuthorize("@ss.hasPermi('system:repair:add')")
    @Log(title = "报修", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysRepair sysRepair) {
        return toAjax(sysRepairService.insertSysRepair(sysRepair));
    }

    /**
     * 修改报修
     */
    @PreAuthorize("@ss.hasPermi('system:repair:edit')")
    @Log(title = "报修", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysRepair sysRepair) {
        return toAjax(sysRepairService.updateSysRepair(sysRepair));
    }

    /**
     * 删除报修
     */
    @PreAuthorize("@ss.hasPermi('system:repair:remove')")
    @Log(title = "报修", businessType = BusinessType.DELETE)
    @DeleteMapping("/{repairIds}")
    public AjaxResult remove(@PathVariable Long[] repairIds) {
        return toAjax(sysRepairService.deleteSysRepairByRepairIds(repairIds));
    }
}
