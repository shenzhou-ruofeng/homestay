package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 报修对象 sys_repair
 *
 * @date 2024-02-05
 */
public class SysRepair extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 报修ID */
    private Long repairId;

    /** 房东用户ID */
    @Excel(name = "房东用户ID")
    private Long landlordUserId;

    /** 房源ID */
    @Excel(name = "房源ID")
    private Long houseId;

    /** 房客用户ID */
    @Excel(name = "房客用户ID")
    private Long userId;

    /** 报修描述 */
    @Excel(name = "报修描述")
    private String description;

    /** 报修状态，0-未维修，1-已维修 */
    @Excel(name = "报修状态，0-未维修，1-已维修")
    private Integer status;

    /** 删除标志（0代表存在 2代表删除） */
    private Integer delFlag;

    public void setRepairId(Long repairId)
    {
        this.repairId = repairId;
    }

    public Long getRepairId()
    {
        return repairId;
    }
    public void setLandlordUserId(Long landlordUserId)
    {
        this.landlordUserId = landlordUserId;
    }

    public Long getLandlordUserId()
    {
        return landlordUserId;
    }
    public void setHouseId(Long houseId)
    {
        this.houseId = houseId;
    }

    public Long getHouseId()
    {
        return houseId;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getDescription()
    {
        return description;
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
                .append("repairId", getRepairId())
                .append("landlordUserId", getLandlordUserId())
                .append("houseId", getHouseId())
                .append("userId", getUserId())
                .append("description", getDescription())
                .append("status", getStatus())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
