package com.ruoyi.system.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.system.domain.SysHouse;
import lombok.Data;

import java.util.Date;

/**
 * 房源对象 sys_house
 *
 * @date 2024-01-25
 */
@Data
public class SysHouseVo extends SysHouse {
    private static final long serialVersionUID = 1L;

    private String keyword;

    private String priceOrder;

    private Integer minArea;

    private Integer maxArea;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endDate;
}
