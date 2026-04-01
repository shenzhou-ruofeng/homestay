package com.ruoyi.common.core.domain.model;

import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 用户注册对象
 *
 * @author ruoyi
 */
@Data
public class RegisterBody extends LoginBody {
    @NotBlank(message = "用户昵称不能为空")
    private String nickName;
    @NotBlank(message = "身份证号不能为空")
    private String idCard;
    @NotBlank(message = "手机号不能为空")
    private String phonenumber;
    @NotBlank(message = "性别不能为空")
    private String sex;
    @NotBlank(message = "角色不能为空")
    private String role;
}
