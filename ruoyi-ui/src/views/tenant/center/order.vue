<template>
  <el-tabs type="border-card" class="order-tab-wrap" v-model="activeTab" @tab-click="handleTabClick">
    <el-tab-pane label="全部订单" name="1">
      <el-scrollbar style="height: 80vh;">
        <order-list v-if="activeTab === '1'" :status="null"></order-list>
      </el-scrollbar>
    </el-tab-pane>
    <el-tab-pane label="待使用" name="2">
      <el-scrollbar style="height: 80vh;">
        <order-list v-if="activeTab === '2'" :status="[0]"></order-list>
      </el-scrollbar>
    </el-tab-pane>
    <el-tab-pane label="进行中" name="3">
      <el-scrollbar style="height: 80vh;">
        <order-list v-if="activeTab === '3'" :status="[1]"></order-list>
      </el-scrollbar>
    </el-tab-pane>
    <el-tab-pane label="已完成" name="4">
      <el-scrollbar style="height: 80vh;">
        <order-list v-if="activeTab === '4'" :status="[2]"></order-list>
      </el-scrollbar>
    </el-tab-pane>
    <el-tab-pane label="退款/售后" name="5">
      <el-scrollbar style="height: 80vh;">
        <order-list v-if="activeTab === '5'" :status="[3,4]"></order-list>
      </el-scrollbar>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
  import OrderList from "./orderList";

  export default {
    components: {OrderList},
    data() {
      return {
        activeTab: '1',
      }
    },
    methods: {
      handleTabClick(tab) {
        // 当选项卡被点击时，更新当前活动的选项卡
        this.activeTab = tab.name;
      }
    }
  }
</script>

<style lang="scss">
  .order-tab-wrap {
    .el-table__header th div.cell {
      text-align: center;
    }

    .el-table__body-wrapper .cell {
      text-align: center;
    }

    .el-tabs__content {
      min-height: 80vh;
    }

    .order-wrap {
      margin: 10px;
      border: 1px solid #dfe4ed;
      box-shadow: 0 4px 16px 1px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
      padding: 20px;

      .house-info {
        font-size: 14px;

        .info-row {
          margin-bottom: 5px;
        }
      }
    }

  }

</style>
