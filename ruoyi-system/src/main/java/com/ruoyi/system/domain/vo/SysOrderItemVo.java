package com.ruoyi.system.domain.vo;

import com.ruoyi.system.domain.SysOrderItem;
import lombok.Data;

import java.math.BigDecimal;


@Data
public class SysOrderItemVo extends SysOrderItem {
    private static final long serialVersionUID = 1L;

    private String name;

    private String imageUrl;

    private String password;

    private BigDecimal profit;

    private Integer[] statusList;

    private BigDecimal cost;

}
