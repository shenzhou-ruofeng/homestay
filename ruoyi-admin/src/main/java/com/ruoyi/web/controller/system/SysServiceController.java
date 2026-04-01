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
import com.ruoyi.system.domain.SysService;
import com.ruoyi.system.service.ISysServiceService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 特色服务Controller
 * 
 * @date 2024-01-29
 */
@RestController
@RequestMapping("/system/service")
public class SysServiceController extends BaseController
{
    @Autowired
    private ISysServiceService sysServiceService;

    /**
     * 查询特色服务列表
     */
    @PreAuthorize("@ss.hasPermi('system:service:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysService sysService)
    {
        startPage();
        if (SecurityUtils.hasRole("landlord") && !SecurityUtils.isAdmin(getUserId())) {
            //房东身份，仅查自己的
            sysService.setUserId(getUserId());
        }
        List<SysService> list = sysServiceService.selectSysServiceList(sysService);
        return getDataTable(list);
    }

    /**
     * 导出特色服务列表
     */
    @PreAuthorize("@ss.hasPermi('system:service:export')")
    @Log(title = "特色服务", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysService sysService)
    {
        List<SysService> list = sysServiceService.selectSysServiceList(sysService);
        ExcelUtil<SysService> util = new ExcelUtil<SysService>(SysService.class);
        util.exportExcel(response, list, "特色服务数据");
    }

    /**
     * 获取特色服务详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:service:query')")
    @GetMapping(value = "/{serviceId}")
    public AjaxResult getInfo(@PathVariable("serviceId") Long serviceId)
    {
        return success(sysServiceService.selectSysServiceByServiceId(serviceId));
    }

    /**
     * 新增特色服务
     */
    @PreAuthorize("@ss.hasPermi('system:service:add')")
    @Log(title = "特色服务", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysService sysService)
    {
        return toAjax(sysServiceService.insertSysService(sysService));
    }

    /**
     * 修改特色服务
     */
    @PreAuthorize("@ss.hasPermi('system:service:edit')")
    @Log(title = "特色服务", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysService sysService)
    {
        return toAjax(sysServiceService.updateSysService(sysService));
    }

    /**
     * 删除特色服务
     */
    @PreAuthorize("@ss.hasPermi('system:service:remove')")
    @Log(title = "特色服务", businessType = BusinessType.DELETE)
	@DeleteMapping("/{serviceIds}")
    public AjaxResult remove(@PathVariable Long[] serviceIds)
    {
        return toAjax(sysServiceService.deleteSysServiceByServiceIds(serviceIds));
    }
}
