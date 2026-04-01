package com.ruoyi.web.controller.tenant;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.SysRepair;
import com.ruoyi.system.service.ISysRepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 报修Controller
 *
 * @date 2024-02-05
 */
@RestController
@RequestMapping("/tenant/repair")
public class TenantRepairController extends BaseController {
    @Autowired
    private ISysRepairService sysRepairService;

    /**
     * 查询报修列表
     */
    @GetMapping("/list")
    public TableDataInfo list(SysRepair sysRepair) {
        startPage();
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房客身份，仅查自己的
            sysRepair.setUserId(getUserId());
        }
        List<SysRepair> list = sysRepairService.selectSysRepairList(sysRepair);
        return getDataTable(list);
    }

    /**
     * 获取报修详细信息
     */
    @GetMapping(value = "/{repairId}")
    public AjaxResult getInfo(@PathVariable("repairId") Long repairId) {
        return success(sysRepairService.selectSysRepairByRepairId(repairId));
    }

    /**
     * 新增报修
     */
    @PostMapping
    public AjaxResult add(@RequestBody SysRepair sysRepair) {
        return toAjax(sysRepairService.insertSysRepair(sysRepair));
    }

    /**
     * 修改报修
     */
    @PutMapping
    public AjaxResult edit(@RequestBody SysRepair sysRepair) {
        return toAjax(sysRepairService.updateSysRepair(sysRepair));
    }

    /**
     * 删除报修
     */
    @DeleteMapping("/{repairIds}")
    public AjaxResult remove(@PathVariable Long[] repairIds) {
        return toAjax(sysRepairService.deleteSysRepairByRepairIds(repairIds));
    }
}
