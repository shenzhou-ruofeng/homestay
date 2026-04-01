<template>
  <div class="register">
    <el-form ref="registerForm" :model="registerForm" :rules="registerRules" class="register-form">
      <h3 class="title">特色民宿在线预订平台</h3>
      <el-form-item prop="username">
        <el-input v-model="registerForm.username" type="text" auto-complete="off" placeholder="账号">
          <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon"/>
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="registerForm.password"
          type="password"
          auto-complete="off"
          placeholder="密码"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon"/>
        </el-input>
      </el-form-item>
      <el-form-item prop="confirmPassword">
        <el-input
          v-model="registerForm.confirmPassword"
          type="password"
          auto-complete="off"
          placeholder="确认密码"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon"/>
        </el-input>
      </el-form-item>
      <el-form-item prop="nickName">
        <el-input v-model="registerForm.nickName" type="text" auto-complete="off" placeholder="昵称">
          <svg-icon slot="prefix" icon-class="people" class="el-input__icon input-icon"/>
        </el-input>
      </el-form-item>
      <el-form-item prop="idCard">
        <el-input v-model="registerForm.idCard" type="text" auto-complete="off" placeholder="身份证号">
          <svg-icon slot="prefix" icon-class="logininfor" class="el-input__icon input-icon"/>
        </el-input>
      </el-form-item>
      <el-form-item prop="phonenumber">
        <el-input v-model="registerForm.phonenumber" type="text" auto-complete="off" placeholder="手机号">
          <svg-icon slot="prefix" icon-class="phone" class="el-input__icon input-icon"/>
        </el-input>
      </el-form-item>
      <el-form-item prop="sex">
        <i class="el-icon-lollipop" style="height: 39px;width: 14px;margin-left: 6px;color: #C0C4CC"></i>
        <span style="margin-left: 11px;color:#C0C4CC;margin-right: 60px;font-size: inherit">性别</span>
        <el-radio-group v-model="registerForm.sex">
          <el-radio :label="0">男</el-radio>
          <el-radio :label="1">女</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item prop="code" v-if="captchaEnabled">
        <el-input
          v-model="registerForm.code"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon"/>
        </el-input>
        <div class="register-code">
          <img :src="codeUrl" @click="getCode" class="register-code-img"/>
        </div>
      </el-form-item>
      <el-form-item style="width:100%;">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          style="width:100%;"
          @click.native.prevent="handleRegister"
        >
          <span v-if="!loading">注 册</span>
          <span v-else>注 册 中...</span>
        </el-button>
        <div style="float: right;">
          <router-link class="link-type" :to="'/login'">使用已有账户登录</router-link>
        </div>
      </el-form-item>
    </el-form>
    <!--  底部  -->
    <div class="el-register-footer">
      <!--      <span>Copyright © 2018-2023 ruoyi.vip All Rights Reserved.</span>-->
    </div>
  </div>
</template>

<script>
  import {getCodeImg, register} from "@/api/login";

  export default {
    name: "Register",
    data() {
      const equalToPassword = (rule, value, callback) => {
        if (this.registerForm.password !== value) {
          callback(new Error("两次输入的密码不一致"));
        } else {
          callback();
        }
      };
      const validateIdCard = (rule, value, callback) => {
        const reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (!value) {
          return callback(new Error('请输入身份证号'));
        }
        if (!reg.test(value)) {
          return callback(new Error('请输入正确的身份证号'));
        }
        callback();
      };
      const validatePhoneNumber = (rule, value, callback) => {
        const reg = /^1[3456789]\d{9}$/;
        if (!value) {
          return callback(new Error('请输入手机号'));
        }
        if (!reg.test(value)) {
          return callback(new Error('请输入正确的手机号'));
        }
        callback();
      };
      return {
        codeUrl: "",
        registerForm: {
          username: "",
          password: "",
          confirmPassword: "",
          code: "",
          uuid: "",
          nickName: "",
          idCard: "",
          phonenumber: "",
          sex: 0,
          role: ""
        },
        registerRules: {
          username: [
            {required: true, trigger: "blur", message: "请输入您的账号"},
            {min: 2, max: 20, message: '用户账号长度必须介于 2 和 20 之间', trigger: 'blur'}
          ],
          password: [
            {required: true, trigger: "blur", message: "请输入您的密码"},
            {min: 5, max: 20, message: '用户密码长度必须介于 5 和 20 之间', trigger: 'blur'}
          ],
          confirmPassword: [
            {required: true, trigger: "blur", message: "请再次输入您的密码"},
            {required: true, validator: equalToPassword, trigger: "blur"}
          ],
          code: [{required: true, trigger: "change", message: "请输入验证码"}],
          nickName: [
            {required: true, trigger: "blur", message: "请输入您的昵称"},
            {min: 2, max: 20, message: '用户昵称长度必须介于 2 和 20 之间', trigger: 'blur'}
          ],
          idCard: [
            {required: true, trigger: "blur", message: "请输入您的身份证号"},
            {required: true, validator: validateIdCard, trigger: "blur"}
          ],
          phonenumber: [
            {required: true, trigger: "blur", message: "请输入您的手机号"},
            {required: true, validator: validatePhoneNumber, trigger: "blur"}
          ]
        },
        loading: false,
        captchaEnabled: false
      };
    },
    created() {
      this.getCode();
      this.registerForm.role = this.$route.query.role;
    },
    methods: {
      getCode() {
        getCodeImg().then(res => {
          this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
          if (this.captchaEnabled) {
            this.codeUrl = "data:image/gif;base64," + res.img;
            this.registerForm.uuid = res.uuid;
          }
        });
      },
      handleRegister() {
        this.$refs.registerForm.validate(valid => {
          if (valid) {
            this.loading = true;
            register(this.registerForm).then(res => {
              const username = this.registerForm.username;
              this.$alert("<font color='red'>恭喜你，您的账号 " + username + " 注册成功！</font>", '系统提示', {
                dangerouslyUseHTMLString: true,
                type: 'success'
              }).then(() => {
                this.$router.push("/login");
              }).catch(() => {
              });
            }).catch(() => {
              this.loading = false;
              if (this.captchaEnabled) {
                this.getCode();
              }
            })
          }
        });
      }
    }
  };
</script>

<style rel="stylesheet/scss" lang="scss">
  .register {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    background-image: url("../assets/images/login-background.jpg");
    background-size: cover;
  }

  .title {
    margin: 0px auto 30px auto;
    text-align: center;
    color: #707070;
  }

  .register-form {
    border-radius: 6px;
    background: #ffffff;
    width: 400px;
    padding: 25px 25px 5px 25px;

    .el-input {
      height: 38px;

      input {
        height: 38px;
      }
    }

    .input-icon {
      height: 39px;
      width: 14px;
      margin-left: 2px;
    }
  }

  .register-tip {
    font-size: 13px;
    text-align: center;
    color: #bfbfbf;
  }

  .register-code {
    width: 33%;
    height: 38px;
    float: right;

    img {
      cursor: pointer;
      vertical-align: middle;
    }
  }

  .el-register-footer {
    height: 40px;
    line-height: 40px;
    position: fixed;
    bottom: 0;
    width: 100%;
    text-align: center;
    color: #fff;
    font-family: Arial;
    font-size: 12px;
    letter-spacing: 1px;
  }

  .register-code-img {
    height: 38px;
  }
</style>
