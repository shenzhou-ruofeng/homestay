package com.ruoyi.system.domain;

import java.math.BigDecimal;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 特色服务对象 sys_service
 *
 * @date 2024-01-29
 */
public class SysService extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 特色服务ID
     */
    private Long serviceId;

    /**
     * 房东ID
     */
    @Excel(name = "房东ID")
    private Long userId;

    /**
     * 房源ID
     */
    @Excel(name = "房源ID")
    private Long houseId;

    /**
     * 服务名称
     */
    @Excel(name = "服务名称")
    private String name;

    /**
     * 价格
     */
    @Excel(name = "价格")
    private BigDecimal price;

    /**
     * 服务描述
     */
    @Excel(name = "服务描述")
    private String description;

    /**
     * 成本
     */
    @Excel(name = "成本")
    private BigDecimal cost;

    /**
     * 剩余数量
     */
    @Excel(name = "剩余数量")
    private Long remain;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    private Integer delFlag;

    public void setServiceId(Long serviceId) {
        this.serviceId = serviceId;
    }

    public Long getServiceId() {
        return serviceId;
    }

    public void setHouseId(Long houseId) {
        this.houseId = houseId;
    }

    public Long getHouseId() {
        return houseId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setRemain(Long remain) {
        this.remain = remain;
    }

    public Long getRemain() {
        return remain;
    }

    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }

    public Integer getDelFlag() {
        return delFlag;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("serviceId", getServiceId())
                .append("userId", getUserId())
                .append("houseId", getHouseId())
                .append("name", getName())
                .append("price", getPrice())
                .append("description", getDescription())
                .append("cost", getCost())
                .append("remain", getRemain())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
