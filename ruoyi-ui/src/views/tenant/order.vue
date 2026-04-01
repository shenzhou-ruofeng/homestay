<template>
  <div>
    <tenant-navbar></tenant-navbar>
    <div class="order-content">
      <div style="font-weight: bold">确认订单信息</div>
      <div class="order-detail">
        <div class="order-row">
          <span class="order-label">入住人数：</span>
          {{JSON.parse(order.tenantInfo).length}}
        </div>
        <div class="order-row">
          <span class="order-label">入住日期：</span>
          {{formatDate(order.arrivalDate)}}
        </div>
        <div class="order-row">
          <span class="order-label">离开日期：</span>
          {{formatDate(order.departureDate)}}
        </div>
        <div class="order-row">
          <span class="order-label">入住人信息：</span>
        </div>
        <el-table
          :data="JSON.parse(order.tenantInfo)"
          style="width: 100%;">
          <el-table-column
            prop="name"
            label="名称">
          </el-table-column>
          <el-table-column
            prop="idcard"
            label="身份证号">
          </el-table-column>
        </el-table>
        <div class="order-row">
          <span class="order-label">订单明细：</span>
        </div>
        <el-table
          :data="order.orderItems"
          style="width: 100%;">
          <el-table-column
            prop="type"
            label="类型"
            :formatter="formatType">
          </el-table-column>
          <el-table-column
            prop="name"
            label="名称">
          </el-table-column>
          <el-table-column
            prop="num"
            label="数量">
          </el-table-column>
          <el-table-column
            prop="price"
            label="单价">
          </el-table-column>
          <el-table-column
            prop="total"
            label="小计">
          </el-table-column>
        </el-table>
        <div class="order-price-wrap">
          <span>总计：</span>
          <span class="order-price">￥{{order.price}}</span>
          <el-button style="margin-left: 30px" type="primary" @click="handlePay">立即付款</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import TenantNavbar from "./tenantNavbar";
  import {addOrder} from "../../api/tenant/order";

  export default {
    data() {
      return {
        order: {
          orderItems: [],
          tenantInfo: "[]",
          houseId: null,
          userId: null,
          arrivalDate: null,
          departureDate: null,
          price: null
        },
      }
    },
    components: {TenantNavbar},
    created() {
      const orderString = this.$route.query.order;
      if (orderString) {
        this.order = JSON.parse(orderString);
        this.order.arrivalDate = new Date(this.order.arrivalDate)
        this.order.departureDate = new Date(this.order.departureDate)
      }
    },
    methods: {
      // 格式化日期格式如：2017-9-19
      formatDate(value) {
        // 计算日期相关值
        let time = typeof value == 'number' ? new Date(value) : value;
        let Y = time.getFullYear();
        let M = time.getMonth() + 1;
        let D = time.getDate();
        return Y + '-' + (M < 10 ? '0' + M : M) + '-' + (D < 10 ? '0' + D : D);
      },
      formatType(row) {
        return row.type === 1 ? '民宿' : '特色服务'
      },
      handlePay() {
        //保存订单
        addOrder(this.order).then(response => {
          if (response.code === 200) {
            this.$modal.msgSuccess("付款成功");
            //跳转到用户订单列表
            this.$router.push({path: '/center/order'});
          } else {
            this.$modal.msgError(response.msg);
          }
        })
      }
    },
  }
</script>

<style lang="scss">
  .order-content {
    margin: 50px 170px;

    .el-table__header th div.cell {
      text-align: center;
    }

    .el-table__body-wrapper .cell {
      text-align: center;
    }

    .order-detail {
      border: 1px solid #dfe4ed;
      margin-top: 20px;

      .order-row {
        margin: 20px 0;

        .order-label {
          margin-left: 10px;
        }
      }

      .order-price-wrap {
        float: right;
        margin: 10px 0;
        padding-bottom: 50px;

        .order-price {
          font-size: 22px;
          color: #0086f6;
        }
      }
    }

  }
</style>
