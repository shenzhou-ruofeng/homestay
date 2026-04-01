package com.ruoyi.system.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 房源对象 sys_house
 * 
 * @date 2024-01-25
 */
public class SysHouse extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 房源ID */
    private Long houseId;

    /** 房东用户ID */
    @Excel(name = "房东用户ID")
    private Long userId;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 地址 */
    @Excel(name = "地址")
    private String address;

    /** 基础设施字典ID，多个英文逗号分隔 */
    @Excel(name = "基础设施字典ID，多个英文逗号分隔")
    private String infrastructure;

    /** 图片url，多个英文逗号分隔 */
    @Excel(name = "图片url，多个英文逗号分隔")
    private String imageUrl;

    /** 面积 */
    @Excel(name = "面积")
    private BigDecimal area;

    /** 最大入住人数 */
    @Excel(name = "最大入住人数")
    private Integer maxPerson;

    /** 价格/天 */
    @Excel(name = "价格/天")
    private BigDecimal price;

    /** 描述 */
    @Excel(name = "描述")
    private String description;

    /** 租赁状态，0-未租，1-已租 */
    @Excel(name = "租赁状态，0-未租，1-已租")
    private Integer rentStatus;

    /** 房屋状态，0-空置，1-已下单未入住，2-已入住 */
    @Excel(name = "房屋状态，0-空置，1-已下单未入住，2-已入住")
    private Integer houseStatus;

    /** 门禁密码 */
    @Excel(name = "门禁密码")
    private String password;

    /** 删除标志（0代表存在 2代表删除） */
    private Integer delFlag;

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
    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }
    public void setAddress(String address) 
    {
        this.address = address;
    }

    public String getAddress() 
    {
        return address;
    }
    public void setInfrastructure(String infrastructure) 
    {
        this.infrastructure = infrastructure;
    }

    public String getInfrastructure() 
    {
        return infrastructure;
    }
    public void setImageUrl(String imageUrl) 
    {
        this.imageUrl = imageUrl;
    }

    public String getImageUrl() 
    {
        return imageUrl;
    }
    public void setArea(BigDecimal area) 
    {
        this.area = area;
    }

    public BigDecimal getArea() 
    {
        return area;
    }
    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }
    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }
    public void setRentStatus(Integer rentStatus) 
    {
        this.rentStatus = rentStatus;
    }

    public Integer getRentStatus() 
    {
        return rentStatus;
    }
    public void setHouseStatus(Integer houseStatus) 
    {
        this.houseStatus = houseStatus;
    }

    public Integer getHouseStatus() 
    {
        return houseStatus;
    }
    public void setPassword(String password) 
    {
        this.password = password;
    }

    public String getPassword() 
    {
        return password;
    }
    public void setDelFlag(Integer delFlag) 
    {
        this.delFlag = delFlag;
    }

    public Integer getDelFlag() 
    {
        return delFlag;
    }

    public Integer getMaxPerson() {
        return maxPerson;
    }

    public void setMaxPerson(Integer maxPerson) {
        this.maxPerson = maxPerson;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("houseId", getHouseId())
            .append("userId", getUserId())
            .append("name", getName())
            .append("address", getAddress())
            .append("infrastructure", getInfrastructure())
            .append("imageUrl", getImageUrl())
            .append("area", getArea())
            .append("maxPerson", getMaxPerson())
            .append("price", getPrice())
            .append("description", getDescription())
            .append("rentStatus", getRentStatus())
            .append("houseStatus", getHouseStatus())
            .append("password", getPassword())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
