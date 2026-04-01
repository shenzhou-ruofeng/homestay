package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.SysComment;
import com.ruoyi.system.domain.vo.SysCommentVo;

/**
 * 评价Service接口
 *
 * @author ruoyi
 * @date 2024-01-29
 */
public interface ISysCommentService {
    /**
     * 查询评价
     *
     * @param commentId 评价主键
     * @return 评价
     */
    public SysComment selectSysCommentByCommentId(Long commentId);

    public SysComment selectSysCommentByOrderItemId(Long orderItemId);

    /**
     * 查询评价列表
     *
     * @param sysComment 评价
     * @return 评价集合
     */
    public List<SysComment> selectSysCommentList(SysComment sysComment);

    /**
     * 新增评价
     *
     * @param sysComment 评价
     * @return 结果
     */
    public int insertSysComment(SysComment sysComment);

    public int insertSysCommentVo(SysCommentVo sysComment);

    /**
     * 修改评价
     *
     * @param sysComment 评价
     * @return 结果
     */
    public int updateSysComment(SysComment sysComment);

    /**
     * 批量删除评价
     *
     * @param commentIds 需要删除的评价主键集合
     * @return 结果
     */
    public int deleteSysCommentByCommentIds(Long[] commentIds);

    /**
     * 删除评价信息
     *
     * @param commentId 评价主键
     * @return 结果
     */
    public int deleteSysCommentByCommentId(Long commentId);
}
