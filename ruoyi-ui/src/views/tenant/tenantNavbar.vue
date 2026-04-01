<template>
  <div class="tenant_navbar">
    <div class="right-menu">
      <template v-if="device!=='mobile'">
        <router-link to="/search">
          <span class="header_menu">首页</span>
        </router-link>
        <router-link to="/center/profile">
          <span class="header_menu">个人中心</span>
        </router-link>
        <router-link to="/center/order">
          <span class="header_menu">我的订单</span>
        </router-link>
        <router-link to="/center/repair">
          <span class="header_menu">报修申请</span>
        </router-link>
      </template>

      <el-dropdown class="avatar-container right-menu-item hover-effect" trigger="click">
        <div class="avatar-wrapper">
          <img :src="avatar" class="user-avatar">
          <i class="el-icon-caret-bottom"/>
        </div>
        <el-dropdown-menu slot="dropdown">
          <router-link to="/center/profile">
            <el-dropdown-item>个人中心</el-dropdown-item>
          </router-link>
          <router-link to="/center/order">
            <el-dropdown-item>我的订单</el-dropdown-item>
          </router-link>
          <router-link to="/center/repair">
            <el-dropdown-item>报修申请</el-dropdown-item>
          </router-link>
          <el-dropdown-item divided @click.native="logout">
            <span>退出登录</span>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </div>
</template>

<script>
  import {mapGetters} from "vuex";

  export default {
    name: "tenantNavbar",
    computed: {
      ...mapGetters([
        'avatar',
        'device'
      ]),
      setting: {
        get() {
          return this.$store.state.settings.showSettings
        },
        set(val) {
          this.$store.dispatch('settings/changeSetting', {
            key: 'showSettings',
            value: val
          })
        }
      }
    },
    methods: {
      async logout() {
        this.$confirm('确定注销并退出系统吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$store.dispatch('LogOut').then(() => {
            location.href = '/index';
          })
        }).catch(() => {
        });
      }
    }
  }
</script>

<style lang="scss" scoped>
  .tenant_navbar {
    height: 50px;
    overflow: hidden;
    position: relative;
    background: #f4f4f4;
    border-bottom: 1px solid #ddd;
    color: #6C6C6C;

    .hamburger-container {
      line-height: 46px;
      height: 100%;
      float: left;
      cursor: pointer;
      transition: background .3s;
      -webkit-tap-highlight-color: transparent;

      &:hover {
        background: rgba(0, 0, 0, .025)
      }
    }

    .breadcrumb-container {
      float: left;
    }

    .topmenu-container {
      position: absolute;
      left: 50px;
    }

    .errLog-container {
      display: inline-block;
      vertical-align: top;
    }

    .right-menu {
      display: flex;
      align-items: center;
      justify-content: flex-end;
      height: 100%;
      line-height: 50px;

      &:focus {
        outline: none;
      }

      .header_menu {
        margin: 0 20px;
      }

      .right-menu-item {
        display: inline-block;
        padding: 0 8px;
        height: 100%;
        font-size: 18px;
        color: #5a5e66;
        vertical-align: text-bottom;

        &.hover-effect {
          cursor: pointer;
          transition: background .3s;

          &:hover {
            background: rgba(0, 0, 0, .025)
          }
        }
      }

      .avatar-container {
        margin-right: 30px;
        margin-left: 30px;

        .avatar-wrapper {
          margin-top: 5px;
          position: relative;

          .user-avatar {
            cursor: pointer;
            width: 40px;
            height: 40px;
            border-radius: 10px;
          }

          .el-icon-caret-bottom {
            cursor: pointer;
            position: absolute;
            right: -20px;
            top: 25px;
            font-size: 12px;
          }
        }
      }
    }
  }
</style>
