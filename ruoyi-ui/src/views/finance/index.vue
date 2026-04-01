<template>
  <div>
    <el-row :gutter="20" style="margin:20px 0">
      <el-col :span="8">
        <div>
          <el-statistic
            group-separator=","
            :precision="2"
            :value="houseProfit"
            title="房源总盈利"
          ></el-statistic>
        </div>
      </el-col>
      <el-col :span="8">
        <div>
          <el-statistic
            group-separator=","
            :precision="2"
            :value="serviceProfit"
            title="特色服务总盈利"
          ></el-statistic>
        </div>
      </el-col>
      <el-col :span="8">
        <div>
          <el-statistic
            group-separator=","
            :precision="2"
            :value="profit"
            title="总盈利"
          ></el-statistic>
        </div>
      </el-col>
    </el-row>
    <div style="padding: 0 20px">
      <el-table :data="list" row-key="orderItemId" border>
        <el-table-column prop="type" align="center" label="类型" :formatter="formatType"></el-table-column>
        <el-table-column prop="name" align="center" label="名称"></el-table-column>
        <el-table-column prop="num" align="center" label="数量"></el-table-column>
        <el-table-column prop="price" align="center" label="单价"></el-table-column>
        <el-table-column prop="total" align="center" label="小计"></el-table-column>
        <el-table-column prop="cost" align="center" label="成本" :formatter="formatCost"></el-table-column>
        <el-table-column prop="feeRatio" align="center" label="平台手续费比例" :formatter="formatFeeRatio"></el-table-column>
        <el-table-column prop="profit" align="center" label="利润"></el-table-column>
      </el-table>
      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getFinanceList()"
      />
    </div>
  </div>
</template>

<script>
  import {listFinance} from "../../api/system/finance";

  export default {
    name: "index",
    data() {
      return {
        list: [],
        total: 0,
        profit: 0,
        feeRatio: 0,
        houseProfit: 0,
        serviceProfit: 0,
        queryParams: {
          pageNum: 1,
          pageSize: 10,
        },
      };
    },
    created() {
      this.getFinanceList();
    },
    methods: {
      formatType(row) {
        return row.type === 1 ? '民宿' : '特色服务'
      },
      formatCost(row) {
        return row.cost ? row.cost : '未知'
      },
      formatFeeRatio(row) {
        return this.feeRatio + "%"
      },
      getFinanceList() {
        listFinance(this.queryParams).then(response => {
          this.list = response.data.rows;
          this.total = response.data.total;
          this.houseProfit = response.data.houseProfit;
          this.serviceProfit = response.data.serviceProfit;
          this.feeRatio = response.data.feeRatio;
          this.profit = this.houseProfit + this.serviceProfit
        });
      }
    }
  }
</script>

<style scoped>

</style>
