<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="房客账号" prop="userId">
        <el-select v-model="queryParams.userId" clearable>
          <el-option v-for="item in tenantList" :key="item.userId" :label="item.nickName" :value="item.userId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="房源" prop="houseId">
        <el-select v-model="queryParams.houseId" clearable>
          <el-option v-for="item in houseList" :key="item.houseId" :label="item.name" :value="item.houseId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" clearable>
          <el-option v-for="item in statusList" :key="item.value" :label="item.label" :value="item.value"/>
        </el-select>
      </el-form-item>
      <el-form-item label="入住日期" prop="arrivalDate">
        <el-date-picker clearable
                        v-model="queryParams.arrivalDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择入住日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="离开日期" prop="departureDate">
        <el-date-picker clearable
                        v-model="queryParams.departureDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择离开日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-button icon="el-icon-bottom" size="mini" @click="expandAll">全部展开</el-button>
      <el-button icon="el-icon-top" size="mini" @click="collapseAll">全部缩起</el-button>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="orderList" :expand-row-keys="expandRowKeys" row-key="orderId">
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-table :data="props.row.orderItems" row-key="orderItemId" border>
            <el-table-column prop="type" align="center" label="类型" :formatter="formatType"></el-table-column>
            <el-table-column prop="name" align="center" label="名称"></el-table-column>
            <el-table-column prop="num" align="center" label="数量"></el-table-column>
            <el-table-column prop="price" align="center" label="单价"></el-table-column>
            <el-table-column prop="total" align="center" label="小计"></el-table-column>
            <el-table-column prop="status" align="center" label="状态" :formatter="formatItemStatus"></el-table-column>
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
              <template slot-scope="scope">
                <el-button
                  v-if="props.row.status!==3&&scope.row.status<4"
                  size="mini"
                  type="text"
                  icon="el-icon-coin"
                  @click="handleItemRefund(scope.row)"
                  v-hasPermi="['system:order:edit']"
                >退款
                </el-button>
                <el-button
                  v-if="props.row.status!==3&&scope.row.status===4"
                  size="mini"
                  type="text"
                  icon="el-icon-check"
                  @click="handleItemPassRefund(scope.row)"
                  v-hasPermi="['system:order:remove']"
                >同意
                </el-button>
                <el-button
                  v-if="scope.row.status===4"
                  size="mini"
                  type="text"
                  icon="el-icon-close"
                  @click="handleItemRejectRefund(scope.row)"
                  v-hasPermi="['system:order:remove']"
                >拒绝
                </el-button>
              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-table-column>
      <el-table-column label="房客" align="center" prop="userId" :formatter="formatUserId"/>
      <el-table-column label="房源名称" align="center" prop="houseId" :formatter="formatHouseId"/>
      <el-table-column label="入住日期" align="center" prop="arrivalDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.arrivalDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="离开日期" align="center" prop="departureDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.departureDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="订单总金额" align="center" prop="price"/>
      <el-table-column label="订单状态" align="center" prop="status" :formatter="formatStatus"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            v-if="scope.row.status<3"
            size="mini"
            type="text"
            icon="el-icon-coin"
            @click="handleRefund(scope.row)"
            v-hasPermi="['system:order:edit']"
          >退款
          </el-button>
          <el-button
            v-if="scope.row.status===3"
            size="mini"
            type="text"
            icon="el-icon-check"
            @click="handlePassRefund(scope.row)"
            v-hasPermi="['system:order:remove']"
          >同意
          </el-button>
          <el-button
            v-if="scope.row.status===3"
            size="mini"
            type="text"
            icon="el-icon-close"
            @click="handleRejectRefund(scope.row)"
            v-hasPermi="['system:order:remove']"
          >拒绝
          </el-button>
          <el-button
            v-if="scope.row.status===4"
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:order:remove']"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改主订单对话框 -->
    <!--    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>-->
    <!--      <el-form ref="form" :model="form" :rules="rules" label-width="80px">-->
    <!--        <el-form-item label="房源ID" prop="houseId">-->
    <!--          <el-input v-model="form.houseId" placeholder="请输入房源ID"/>-->
    <!--        </el-form-item>-->
    <!--        <el-form-item label="房客ID" prop="userId">-->
    <!--          <el-input v-model="form.userId" placeholder="请输入房客ID"/>-->
    <!--        </el-form-item>-->
    <!--        <el-form-item label="订单总金额" prop="price">-->
    <!--          <el-input v-model="form.price" placeholder="请输入订单总金额"/>-->
    <!--        </el-form-item>-->
    <!--        <el-form-item label="入住日期" prop="arrivalDate">-->
    <!--          <el-date-picker clearable-->
    <!--                          v-model="form.arrivalDate"-->
    <!--                          type="date"-->
    <!--                          value-format="yyyy-MM-dd"-->
    <!--                          placeholder="请选择入住日期">-->
    <!--          </el-date-picker>-->
    <!--        </el-form-item>-->
    <!--        <el-form-item label="离开日期" prop="departureDate">-->
    <!--          <el-date-picker clearable-->
    <!--                          v-model="form.departureDate"-->
    <!--                          type="date"-->
    <!--                          value-format="yyyy-MM-dd"-->
    <!--                          placeholder="请选择离开日期">-->
    <!--          </el-date-picker>-->
    <!--        </el-form-item>-->
    <!--      </el-form>-->
    <!--      <div slot="footer" class="dialog-footer">-->
    <!--        <el-button type="primary" @click="submitForm">确 定</el-button>-->
    <!--        <el-button @click="cancel">取 消</el-button>-->
    <!--      </div>-->
    <!--    </el-dialog>-->
  </div>
</template>

<script>
import {listOrder, getOrder, delOrder, addOrder, updateOrder} from "@/api/system/order";
import {listByRole} from "../../api/system/user";
import {listAllHouse} from "../../api/system/house";
import {updateItem} from "../../api/system/item";

export default {
  name: "Order",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      expandRowKeys: [],
      // 主订单表格数据
      orderList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        houseId: null,
        userId: null,
        price: null,
        arrivalDate: null,
        departureDate: null,
        tenantInfo: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {},
      tenantList: [],
      houseList: [],
      statusList: [{
        value: 0,
        label: '待使用'
      }, {
        value: 1,
        label: '进行中'
      }, {
        value: 2,
        label: '待评价'
      }, {
        value: 3,
        label: '已完成'
      }, {
        value: 4,
        label: '退款中'
      }, {
        value: 5,
        label: '已退款'
      }]
    };
  },
  created() {
    this.getList();
    this.getTenantList();
    this.getHouseList();
  },
  methods: {
    // 展开全部按钮点击事件处理函数
    expandAll() {
      this.expandRowKeys = this.orderList.map(item => item.orderId)
    },
    // 收起全部按钮点击事件处理函数
    collapseAll() {
      this.expandRowKeys = []
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    formatType(row) {
      return row.type === 1 ? '民宿' : '特色服务'
    },
    formatUserId(row, column) {
      let filterElement = this.tenantList.filter(item => item.userId === row.userId)[0];
      if (filterElement) {
        return filterElement.nickName
      }
      return row.userId;
    },
    formatHouseId(row, column) {
      let filterElement = this.houseList.filter(item => item.houseId === row.houseId)[0];
      if (filterElement) {
        return filterElement.name
      }
      return row.houseId;
    },
    formatStatus(row, column) {
      if (row.status === 0) {
        return "待使用"
      } else if (row.status === 1) {
        return "进行中"
      } else if (row.status === 2) {
        return "已完成"
      } else if (row.status === 3) {
        return "退款中"
      } else if (row.status === 4) {
        return "已退款"
      }
    },
    formatItemStatus(row, column) {
      if (row.status === 0) {
        return "待使用"
      } else if (row.status === 1) {
        return "进行中"
      } else if (row.status === 2) {
        return "待评价"
      } else if (row.status === 3) {
        return "已完成"
      } else if (row.status === 4) {
        return "退款中"
      } else if (row.status === 5) {
        return "已退款"
      }
    },
    /** 查询房客用户列表 */
    getTenantList() {
      listByRole({roleKey: "tenant"}).then(response => {
        this.tenantList = response.data;
      });
    },
    getHouseList() {
      listAllHouse({}).then(response => {
        this.houseList = response.data;
      });
    },
    /** 查询主订单列表 */
    getList() {
      this.loading = true;
      listOrder(this.queryParams).then(response => {
        this.orderList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        orderId: null,
        houseId: null,
        userId: null,
        price: null,
        arrivalDate: null,
        departureDate: null,
        tenantInfo: null,
        status: null,
        delFlag: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 主订单退款 */
    handleRefund(row) {
      //弹窗判断
      this.$modal.confirm('是否退款房费及特色服务费？').then(() => {
        //修改订单
        updateOrder({orderId: row.orderId, status: 4}).then(response => {
          if (response.code === 200) {
            this.$message({
              type: 'success',
              message: '退款成功'
            });
            this.getList();
          } else {
            this.$message({
              type: 'error',
              message: '退款失败，重新发起'
            });
          }
        })
      });
    },
    /** 主订单同意退款 */
    handlePassRefund(row) {
      //弹窗判断
      this.$modal.confirm('是否同意退款房费及特色服务费？').then(() => {
        //修改订单
        updateOrder({orderId: row.orderId, status: 4}).then(response => {
          if (response.code === 200) {
            this.$message({
              type: 'success',
              message: '退款成功'
            });
            this.getList();
          } else {
            this.$message({
              type: 'error',
              message: '退款失败，重新发起'
            });
          }
        })
      });
    },
    /** 主订单拒绝退款 */
    handleRejectRefund(row) {
      //弹窗判断
      this.$modal.confirm('是否拒绝退款房费及特色服务费？').then(() => {
        //修改订单
        updateOrder({orderId: row.orderId, status: 0}).then(response => {
          if (response.code === 200) {
            this.$message({
              type: 'success',
              message: '拒绝退款成功'
            });
            this.getList();
          } else {
            this.$message({
              type: 'error',
              message: '拒绝退款失败，重新发起'
            });
          }
        })
      });
    },
    /** 子订单退款 */
    handleItemRefund(row) {
      //弹窗判断
      this.$modal.confirm(row.type === 1 ? '是否退款房费？' : '是否退款服务费').then(() => {
        //修改订单
        updateItem({orderItemId: row.orderItemId, status: 5}).then(response => {
          if (response.code === 200) {
            this.$message({
              type: 'success',
              message: '退款成功'
            });
            this.getList();
          } else {
            this.$message({
              type: 'error',
              message: '退款失败，重新发起'
            });
          }
        })
      });
    },
    /** 子订单同意退款 */
    handleItemPassRefund(row) {
      //弹窗判断
      this.$modal.confirm('是否同意退款特色服务费？').then(() => {
        //修改订单
        updateItem({orderItemId: row.orderItemId, status: 5}).then(response => {
          if (response.code === 200) {
            this.$message({
              type: 'success',
              message: '退款成功'
            });
            this.getList();
          } else {
            this.$message({
              type: 'error',
              message: '退款失败，重新发起'
            });
          }
        })
      });
    },
    /** 子订单拒绝退款 */
    handleItemRejectRefund(row) {
      //弹窗判断
      this.$modal.confirm('是否拒绝退款特色服务费？').then(() => {
        //修改订单
        updateOrder({orderId: row.orderId, status: 0}).then(response => {
          if (response.code === 200) {
            this.$message({
              type: 'success',
              message: '拒绝退款成功'
            });
            this.getList();
          } else {
            this.$message({
              type: 'error',
              message: '拒绝退款失败，重新发起'
            });
          }
        })
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      this.$modal.confirm('是否确认删除该订单？').then(function () {
        return delOrder(row.orderId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/order/export', {
        ...this.queryParams
      }, `order_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
