package com.ruoyi.system.domain.vo;

import com.ruoyi.system.domain.SysComment;
import lombok.Data;

@Data
public class SysCommentVo extends SysComment {
    private static final long serialVersionUID = 1L;

    private String nickName;

    private String avatar;

    private String serviceName;

    private Long orderItemId;
}
