package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.List;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.SysOrderItem;
import com.ruoyi.system.domain.vo.SysCommentVo;
import com.ruoyi.system.mapper.SysOrderItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysCommentMapper;
import com.ruoyi.system.domain.SysComment;
import com.ruoyi.system.service.ISysCommentService;
import org.springframework.transaction.annotation.Transactional;

/**
 * 评价Service业务层处理
 *
 * @date 2024-01-29
 */
@Service
public class SysCommentServiceImpl implements ISysCommentService {
    @Autowired
    private SysCommentMapper sysCommentMapper;
    @Autowired
    private SysOrderItemMapper sysOrderItemMapper;

    /**
     * 查询评价
     *
     * @param commentId 评价主键
     * @return 评价
     */
    @Override
    public SysComment selectSysCommentByCommentId(Long commentId) {
        return sysCommentMapper.selectSysCommentByCommentId(commentId);
    }

    @Override
    public SysComment selectSysCommentByOrderItemId(Long orderItemId) {
        return sysCommentMapper.selectSysCommentByOrderItemId(orderItemId);
    }

    /**
     * 查询评价列表
     *
     * @param sysComment 评价
     * @return 评价
     */
    @Override
    public List<SysComment> selectSysCommentList(SysComment sysComment) {
        return sysCommentMapper.selectSysCommentList(sysComment);
    }

    /**
     * 新增评价
     *
     * @param sysComment 评价
     * @return 结果
     */
    @Override
    public int insertSysComment(SysComment sysComment) {
        sysComment.setCreateTime(DateUtils.getNowDate());
        return sysCommentMapper.insertSysComment(sysComment);
    }

    @Override
    @Transactional(rollbackFor = Throwable.class)
    public int insertSysCommentVo(SysCommentVo sysComment) {
        sysComment.setCreateTime(DateUtils.getNowDate());
        //修改子订单状态为完成
        if (sysComment.getOrderItemId() == null) {
            return 0;
        }
        SysOrderItem sysOrderItem = sysOrderItemMapper.selectSysOrderItemByOrderItemId(sysComment.getOrderItemId());
        if (sysOrderItem == null) {
            return 0;
        }
        sysOrderItem.setStatus(3);
        sysOrderItem.setUpdateTime(new Date());
        sysOrderItemMapper.updateSysOrderItem(sysOrderItem);
        return sysCommentMapper.insertSysComment(sysComment);
    }

    /**
     * 修改评价
     *
     * @param sysComment 评价
     * @return 结果
     */
    @Override
    public int updateSysComment(SysComment sysComment) {
        sysComment.setUpdateTime(DateUtils.getNowDate());
        return sysCommentMapper.updateSysComment(sysComment);
    }

    /**
     * 批量删除评价
     *
     * @param commentIds 需要删除的评价主键
     * @return 结果
     */
    @Override
    public int deleteSysCommentByCommentIds(Long[] commentIds) {
        return sysCommentMapper.deleteSysCommentByCommentIds(commentIds);
    }

    /**
     * 删除评价信息
     *
     * @param commentId 评价主键
     * @return 结果
     */
    @Override
    public int deleteSysCommentByCommentId(Long commentId) {
        return sysCommentMapper.deleteSysCommentByCommentId(commentId);
    }
}
