<template>
  <div class="app-container home">
    <div style="margin-bottom: 20px;display: flex;align-items: center;">
      <img src="@/assets/images/sun.png" style="width: 30px;height: 30px;margin-right: 10px">
      <span style="font-family: 'Arial Black';font-size: 18px">您好，&emsp;</span>
      <span style="font-family: 'Arial Black';font-size: 18px">{{user.nickName}}！</span>
    </div>
    <el-row>
      <el-col :span="12" :offset="6">
        <el-card class="box-card">
          <el-calendar v-model="date">
          </el-calendar>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
  import {getUserProfile} from "@/api/system/user";

  export default {
    name: "Index",
    data() {
      return {
        user: {},
        date: new Date()
      };
    },
    created() {
      this.getUser();
    },
    methods: {
      getUser() {
        getUserProfile().then(response => {
          this.user = response.data;
        });
      }
    }
  };
</script>

<style>
  .el-calendar-table .el-calendar-day {
    height: 50px !important;
  }

  .home {
    blockquote {
      padding: 10px 20px;
      margin: 0 0 20px;
      font-size: 17.5px;
      border-left: 5px solid #eee;
    }

    hr {
      margin-top: 20px;
      margin-bottom: 20px;
      border: 0;
      border-top: 1px solid #eee;
    }

    .col-item {
      margin-bottom: 20px;
    }

    ul {
      padding: 0;
      margin: 0;
    }

    font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 13px;
    color: #676a6c;
    overflow-x: hidden;

    ul {
      list-style-type: none;
    }

    h4 {
      margin-top: 0px;
    }

    h2 {
      margin-top: 10px;
      font-size: 26px;
      font-weight: 100;
    }

    p {
      margin-top: 10px;

      b {
        font-weight: 700;
      }
    }

    .update-log {
      ol {
        display: block;
        list-style-type: decimal;
        margin-block-start: 1em;
        margin-block-end: 1em;
        margin-inline-start: 0;
        margin-inline-end: 0;
        padding-inline-start: 40px;
      }
    }
  }
</style>

