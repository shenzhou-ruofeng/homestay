package com.ruoyi.web.controller.tenant;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.SysComment;
import com.ruoyi.system.domain.vo.SysCommentVo;
import com.ruoyi.system.service.ISysCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 评价Controller
 *
 * @date 2024-01-29
 */
@RestController
@RequestMapping("/tenant/comment")
public class TenantCommentController extends BaseController {
    @Autowired
    private ISysCommentService sysCommentService;

    /**
     * 新增评价
     */
    @PostMapping
    public AjaxResult add(@RequestBody SysCommentVo sysComment) {
        return toAjax(sysCommentService.insertSysCommentVo(sysComment));
    }

    /**
     * 获取评价详细信息
     */
    @GetMapping(value = "/{orderItemId}")
    public AjaxResult getInfo(@PathVariable("orderItemId") Long orderItemId) {
        return success(sysCommentService.selectSysCommentByOrderItemId(orderItemId));
    }

    /**
     * 修改评价
     */
    @PutMapping
    public AjaxResult edit(@RequestBody SysComment sysComment) {
        return toAjax(sysCommentService.updateSysComment(sysComment));
    }

}
