package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SysComment;

/**
 * 评价Mapper接口
 * 
 * @date 2024-01-29
 */
public interface SysCommentMapper 
{
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

    /**
     * 修改评价
     * 
     * @param sysComment 评价
     * @return 结果
     */
    public int updateSysComment(SysComment sysComment);

    /**
     * 删除评价
     * 
     * @param commentId 评价主键
     * @return 结果
     */
    public int deleteSysCommentByCommentId(Long commentId);

    /**
     * 批量删除评价
     * 
     * @param commentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysCommentByCommentIds(Long[] commentIds);
}
