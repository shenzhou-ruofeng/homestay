package com.ruoyi.system.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.system.domain.SysHouse;
import com.ruoyi.system.domain.SysOrder;
import com.ruoyi.system.domain.SysOrderItem;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class SysOrderVo extends SysOrder {
    private static final long serialVersionUID = 1L;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    private List<SysOrderItemVo> orderItems;

    private String keyword;

    private String imageUrl;

    private Integer[] statusList;
}
