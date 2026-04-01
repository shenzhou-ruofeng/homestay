package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 评价对象 sys_comment
 *
 * @author ruoyi
 * @date 2024-02-05
 */
public class SysComment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 评论ID */
    private Long commentId;

    /** 子订单ID */
    @Excel(name = "子订单ID")
    private Long orderItemId;

    /** 房源ID */
    @Excel(name = "房源ID")
    private Long houseId;

    /** 特色服务ID */
    @Excel(name = "特色服务ID")
    private Long serviceId;

    /** 房客用户ID */
    @Excel(name = "房客用户ID")
    private Long userId;

    /** 评论类型（1房屋评论2特色服务评论） */
    @Excel(name = "评论类型", readConverterExp = "1=房屋评论2特色服务评论")
    private Integer type;

    /** 评论内容 */
    @Excel(name = "评论内容")
    private String content;

    /** 评分（1-5） */
    @Excel(name = "评分", readConverterExp = "1=-5")
    private Long score;

    /** 删除标志（0代表存在 2代表删除） */
    private Integer delFlag;

    public void setCommentId(Long commentId)
    {
        this.commentId = commentId;
    }

    public Long getCommentId()
    {
        return commentId;
    }
    public void setOrderItemId(Long orderItemId)
    {
        this.orderItemId = orderItemId;
    }

    public Long getOrderItemId()
    {
        return orderItemId;
    }
    public void setHouseId(Long houseId)
    {
        this.houseId = houseId;
    }

    public Long getHouseId()
    {
        return houseId;
    }
    public void setServiceId(Long serviceId)
    {
        this.serviceId = serviceId;
    }

    public Long getServiceId()
    {
        return serviceId;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setType(Integer type)
    {
        this.type = type;
    }

    public Integer getType()
    {
        return type;
    }
    public void setContent(String content)
    {
        this.content = content;
    }

    public String getContent()
    {
        return content;
    }
    public void setScore(Long score)
    {
        this.score = score;
    }

    public Long getScore()
    {
        return score;
    }
    public void setDelFlag(Integer delFlag)
    {
        this.delFlag = delFlag;
    }

    public Integer getDelFlag()
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("commentId", getCommentId())
                .append("orderItemId", getOrderItemId())
                .append("houseId", getHouseId())
                .append("serviceId", getServiceId())
                .append("userId", getUserId())
                .append("type", getType())
                .append("content", getContent())
                .append("score", getScore())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
