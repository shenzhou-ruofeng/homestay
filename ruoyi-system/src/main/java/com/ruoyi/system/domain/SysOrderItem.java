package com.ruoyi.system.domain;

import java.math.BigDecimal;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 子订单对象 sys_order_item
 *
 * @author ruoyi
 * @date 2024-02-05
 */
public class SysOrderItem extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 子订单ID
     */
    private Long orderItemId;

    /**
     * 主订单ID
     */
    @Excel(name = "主订单ID")
    private Long orderId;

    /**
     * 房东用户ID
     */
    @Excel(name = "房东用户ID")
    private Long landlordUserId;

    /**
     * 房客用户ID
     */
    @Excel(name = "房客用户ID")
    private Long userId;

    /**
     * 子订单产品类型，1-房屋，2-特色服务
     */
    @Excel(name = "子订单产品类型，1-房屋，2-特色服务")
    private Integer type;

    /**
     * 子订单产品ID，type=1时为房屋ID，type=2时为服务ID
     */
    @Excel(name = "子订单产品ID，type=1时为房屋ID，type=2时为服务ID")
    private Long productId;

    /**
     * 产品数量，type=1时为入住天数，type=2时为服务数量
     */
    @Excel(name = "产品数量，type=1时为入住天数，type=2时为服务数量")
    private Long num;

    /**
     * 产品单价，type=1时为房屋单天价格，type=2时为服务单价
     */
    @Excel(name = "产品单价，type=1时为房屋单天价格，type=2时为服务单价")
    private BigDecimal price;

    /**
     * 子订单总价
     */
    @Excel(name = "子订单总价")
    private BigDecimal total;

    /**
     * 状态，0-待使用，1-进行中，2-待评价，3-已完成，4-退款中，5-已退款
     */
    @Excel(name = "状态，0-待使用，1-进行中，2-待评价，3-已完成，4-退款中，5-已退款")
    private Integer status;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    private Integer delFlag;

    public void setOrderItemId(Long orderItemId) {
        this.orderItemId = orderItemId;
    }

    public Long getOrderItemId() {
        return orderItemId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setLandlordUserId(Long landlordUserId) {
        this.landlordUserId = landlordUserId;
    }

    public Long getLandlordUserId() {
        return landlordUserId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getType() {
        return type;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setNum(Long num) {
        this.num = num;
    }

    public Long getNum() {
        return num;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getStatus() {
        return status;
    }

    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }

    public Integer getDelFlag() {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("orderItemId", getOrderItemId())
                .append("orderId", getOrderId())
                .append("landlordUserId", getLandlordUserId())
                .append("userId", getUserId())
                .append("type", getType())
                .append("productId", getProductId())
                .append("num", getNum())
                .append("price", getPrice())
                .append("total", getTotal())
                .append("status", getStatus())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
