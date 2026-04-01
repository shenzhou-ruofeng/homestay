package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 合同对象 sys_contract
 *
 * @date 2024-02-01
 */
public class SysContract extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 合同ID */
    private Long contractId;

    /** 房源ID */
    @Excel(name = "房源ID")
    private Long houseId;

    /** 房源地址 */
    @Excel(name = "房源地址")
    private String houseAddress;

    /** 房东用户ID */
    @Excel(name = "房东用户ID")
    private Long userId;

    /** 房东姓名 */
    @Excel(name = "房东姓名")
    private String landlordName;

    /** 房东身份证 */
    @Excel(name = "房东身份证")
    private String landlordIdcard;

    /** 房东电话 */
    @Excel(name = "房东电话")
    private String landlordPhone;

    /** 房东地址 */
    @Excel(name = "房东地址")
    private String landlordAddress;

    /** 平台公司名称 */
    @Excel(name = "平台公司名称")
    private String platformName;

    /** 平台公司地址 */
    @Excel(name = "平台公司地址")
    private String platformAddress;

    /** 平台公司法人 */
    @Excel(name = "平台公司法人")
    private String platformLegalName;

    /** 平台公司电话 */
    @Excel(name = "平台公司电话")
    private String platformPhone;

    /** 状态，0-审批中，1-审批失败，2-合同生效，3-合同终止 */
    @Excel(name = "状态，0-审批中，1-审批失败，2-合同生效，3-合同终止")
    private Integer status;

    /** 平台审核通过后合同生效日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "平台审核通过后合同生效日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date signingDate;

    /** 房东合同提交日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "房东合同提交日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date submitDate;

    /** 合同终止日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "合同终止日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date terminateDate;

    /** 审核失败原因 */
    @Excel(name = "审核失败原因")
    private String errMsg;

    /** 删除标志（0代表存在 2代表删除） */
    private Integer delFlag;

    public void setContractId(Long contractId)
    {
        this.contractId = contractId;
    }

    public Long getContractId()
    {
        return contractId;
    }
    public void setHouseId(Long houseId)
    {
        this.houseId = houseId;
    }

    public Long getHouseId()
    {
        return houseId;
    }
    public void setHouseAddress(String houseAddress)
    {
        this.houseAddress = houseAddress;
    }

    public String getHouseAddress()
    {
        return houseAddress;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setLandlordName(String landlordName)
    {
        this.landlordName = landlordName;
    }

    public String getLandlordName()
    {
        return landlordName;
    }
    public void setLandlordIdcard(String landlordIdcard)
    {
        this.landlordIdcard = landlordIdcard;
    }

    public String getLandlordIdcard()
    {
        return landlordIdcard;
    }
    public void setLandlordPhone(String landlordPhone)
    {
        this.landlordPhone = landlordPhone;
    }

    public String getLandlordPhone()
    {
        return landlordPhone;
    }
    public void setLandlordAddress(String landlordAddress)
    {
        this.landlordAddress = landlordAddress;
    }

    public String getLandlordAddress()
    {
        return landlordAddress;
    }
    public void setPlatformName(String platformName)
    {
        this.platformName = platformName;
    }

    public String getPlatformName()
    {
        return platformName;
    }
    public void setPlatformAddress(String platformAddress)
    {
        this.platformAddress = platformAddress;
    }

    public String getPlatformAddress()
    {
        return platformAddress;
    }
    public void setPlatformLegalName(String platformLegalName)
    {
        this.platformLegalName = platformLegalName;
    }

    public String getPlatformLegalName()
    {
        return platformLegalName;
    }
    public void setPlatformPhone(String platformPhone)
    {
        this.platformPhone = platformPhone;
    }

    public String getPlatformPhone()
    {
        return platformPhone;
    }
    public void setStatus(Integer status)
    {
        this.status = status;
    }

    public Integer getStatus()
    {
        return status;
    }
    public void setSigningDate(Date signingDate)
    {
        this.signingDate = signingDate;
    }

    public Date getSigningDate()
    {
        return signingDate;
    }
    public void setSubmitDate(Date submitDate)
    {
        this.submitDate = submitDate;
    }

    public Date getSubmitDate()
    {
        return submitDate;
    }
    public void setTerminateDate(Date terminateDate)
    {
        this.terminateDate = terminateDate;
    }

    public Date getTerminateDate()
    {
        return terminateDate;
    }
    public void setErrMsg(String errMsg)
    {
        this.errMsg = errMsg;
    }

    public String getErrMsg()
    {
        return errMsg;
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
                .append("contractId", getContractId())
                .append("houseId", getHouseId())
                .append("houseAddress", getHouseAddress())
                .append("userId", getUserId())
                .append("landlordName", getLandlordName())
                .append("landlordIdcard", getLandlordIdcard())
                .append("landlordPhone", getLandlordPhone())
                .append("landlordAddress", getLandlordAddress())
                .append("platformName", getPlatformName())
                .append("platformAddress", getPlatformAddress())
                .append("platformLegalName", getPlatformLegalName())
                .append("platformPhone", getPlatformPhone())
                .append("status", getStatus())
                .append("signingDate", getSigningDate())
                .append("submitDate", getSubmitDate())
                .append("terminateDate", getTerminateDate())
                .append("errMsg", getErrMsg())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
