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
import com.ruoyi.system.domain.SysComment;
import com.ruoyi.system.service.ISysCommentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 评价Controller
 * 
 * @date 2024-01-29
 */
@RestController
@RequestMapping("/system/comment")
public class SysCommentController extends BaseController
{
    @Autowired
    private ISysCommentService sysCommentService;

    /**
     * 查询评价列表
     */
    @PreAuthorize("@ss.hasPermi('system:comment:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysComment sysComment)
    {
        startPage();
        List<SysComment> list = sysCommentService.selectSysCommentList(sysComment);
        return getDataTable(list);
    }

    /**
     * 导出评价列表
     */
    @PreAuthorize("@ss.hasPermi('system:comment:export')")
    @Log(title = "评价", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysComment sysComment)
    {
        List<SysComment> list = sysCommentService.selectSysCommentList(sysComment);
        ExcelUtil<SysComment> util = new ExcelUtil<SysComment>(SysComment.class);
        util.exportExcel(response, list, "评价数据");
    }

    /**
     * 获取评价详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:comment:query')")
    @GetMapping(value = "/{commentId}")
    public AjaxResult getInfo(@PathVariable("commentId") Long commentId)
    {
        return success(sysCommentService.selectSysCommentByCommentId(commentId));
    }

    /**
     * 新增评价
     */
    @PreAuthorize("@ss.hasPermi('system:comment:add')")
    @Log(title = "评价", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysComment sysComment)
    {
        return toAjax(sysCommentService.insertSysComment(sysComment));
    }

    /**
     * 修改评价
     */
    @PreAuthorize("@ss.hasPermi('system:comment:edit')")
    @Log(title = "评价", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysComment sysComment)
    {
        return toAjax(sysCommentService.updateSysComment(sysComment));
    }

    /**
     * 删除评价
     */
    @PreAuthorize("@ss.hasPermi('system:comment:remove')")
    @Log(title = "评价", businessType = BusinessType.DELETE)
	@DeleteMapping("/{commentIds}")
    public AjaxResult remove(@PathVariable Long[] commentIds)
    {
        return toAjax(sysCommentService.deleteSysCommentByCommentIds(commentIds));
    }
}
