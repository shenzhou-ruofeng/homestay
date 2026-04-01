<template>
  <el-container class="center-wrap">
    <el-header>
      <tenant-navbar></tenant-navbar>
    </el-header>
    <el-container>
      <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
        <el-menu :default-active="this.$route.name" :router="true">
          <el-menu-item index="userProfile" route="/center/profile">
            <i class="el-icon-s-custom"></i>
            <span slot="title">个人中心</span>
          </el-menu-item>
          <el-menu-item index="userOrder" route="/center/order">
            <i class="el-icon-s-order"></i>
            <span slot="title">我的订单</span>
          </el-menu-item>
          <el-menu-item index="userRepair" route="/center/repair">
            <i class="el-icon-s-open"></i>
            <span slot="title">报修申请</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
  import logoImg from '@/assets/logo/logo.png'
  import TenantNavbar from "../tenantNavbar";

  export default {
    data() {
      return {
        title: process.env.VUE_APP_TITLE,
        logo: logoImg,
      }
    },
    components: {TenantNavbar},
    created() {
    },
    methods: {},
  }
</script>

<style lang="scss">
  .center-wrap {
    .el-table__header th div.cell {
      text-align: center;
    }

    .el-table__body-wrapper .cell {
      text-align: center;
    }

    .el-header {
      padding: 0;
      height: auto !important;
    }

    .el-aside {
      padding: 0;
      margin: 0;

      .el-menu {
        min-height: 100vh;
      }
    }

    .el-main {
      min-height: 100vh;
    }
  }

</style>
