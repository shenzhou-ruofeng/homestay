package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 主订单对象 sys_order
 *
 * @date 2024-02-05
 */
public class SysOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 订单ID */
    private Long orderId;

    /** 房源ID */
    @Excel(name = "房源ID")
    private Long houseId;

    /** 房东ID */
    @Excel(name = "房东ID")
    private Long landlordUserId;

    /** 房客ID */
    @Excel(name = "房客ID")
    private Long userId;

    /** 订单总金额 */
    @Excel(name = "订单总金额")
    private BigDecimal price;

    /** 入住日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "入住日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date arrivalDate;

    /** 离开日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "离开日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date departureDate;

    /** 入住房客信息，json字符串，例[{"name":"xx","idcard":"35023023"}] */
    @Excel(name = "入住房客信息，json字符串，例[{\"name\":\"xx\",\"idcard\":\"35023023\"}]")
    private String tenantInfo;

    /** 订单状态，0-待使用，1-进行中，2-已完成，3-退款中，4-已退款 */
    @Excel(name = "订单状态，0-待使用，1-进行中，2-已完成，3-退款中，4-已退款")
    private Integer status;

    /** 删除标志（0代表存在 2代表删除） */
    private Integer delFlag;

    public void setOrderId(Long orderId)
    {
        this.orderId = orderId;
    }

    public Long getOrderId()
    {
        return orderId;
    }
    public void setHouseId(Long houseId)
    {
        this.houseId = houseId;
    }

    public Long getHouseId()
    {
        return houseId;
    }
    public void setLandlordUserId(Long landlordUserId)
    {
        this.landlordUserId = landlordUserId;
    }

    public Long getLandlordUserId()
    {
        return landlordUserId;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setPrice(BigDecimal price)
    {
        this.price = price;
    }

    public BigDecimal getPrice()
    {
        return price;
    }
    public void setArrivalDate(Date arrivalDate)
    {
        this.arrivalDate = arrivalDate;
    }

    public Date getArrivalDate()
    {
        return arrivalDate;
    }
    public void setDepartureDate(Date departureDate)
    {
        this.departureDate = departureDate;
    }

    public Date getDepartureDate()
    {
        return departureDate;
    }
    public void setTenantInfo(String tenantInfo)
    {
        this.tenantInfo = tenantInfo;
    }

    public String getTenantInfo()
    {
        return tenantInfo;
    }
    public void setStatus(Integer status)
    {
        this.status = status;
    }

    public Integer getStatus()
    {
        return status;
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
                .append("orderId", getOrderId())
                .append("houseId", getHouseId())
                .append("landlordUserId", getLandlordUserId())
                .append("userId", getUserId())
                .append("price", getPrice())
                .append("arrivalDate", getArrivalDate())
                .append("departureDate", getDepartureDate())
                .append("tenantInfo", getTenantInfo())
                .append("status", getStatus())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
