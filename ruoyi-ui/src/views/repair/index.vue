<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="房东" prop="landlordUserId" v-if="$store.getters.roles.includes('admin')">
        <el-select v-model="queryParams.landlordUserId" clearable>
          <el-option v-for="item in landlordList" :key="item.userId" :label="item.nickName" :value="item.userId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="房源" prop="houseId">
        <el-select v-model="queryParams.houseId" clearable>
          <el-option v-for="item in houseList" :key="item.houseId" :label="item.name" :value="item.houseId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="房客" prop="userId">
        <el-select v-model="queryParams.userId" clearable>
          <el-option v-for="item in tenantList" :key="item.userId" :label="item.nickName" :value="item.userId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="维修状态" prop="status">
        <el-select v-model="queryParams.status" clearable>
          <el-option :key="0" label="未维修" :value="0"/>
          <el-option :key="1" label="已维修" :value="1"/>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="repairList">
      <el-table-column label="房源" align="center" prop="houseId" :formatter="formatHouseId"/>
      <el-table-column label="房客" align="center" prop="userId" :formatter="formatUserId"/>
      <el-table-column label="报修描述" align="center" prop="description"/>
      <el-table-column label="报修状态" align="center" prop="status" :formatter="formatStatus"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            v-if="scope.row.status===0"
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:repair:edit']"
          >处理
          </el-button>
          <el-button
            v-if="scope.row.status===1"
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:repair:remove']"
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
  </div>
</template>

<script>
  import {listRepair, delRepair, updateRepair} from "@/api/system/repair";
  import {listByRole} from "../../api/system/user";
  import {listAllHouse} from "../../api/system/house";

  export default {
    name: "Repair",
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
        // 报修表格数据
        repairList: [],
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
          status: null,
        },
        tenantList: [],
        houseList: [],
        landlordList: []
      };
    },
    created() {
      this.getList();
      this.getTenantList();
      this.getLandlordList();
      this.getHouseList();
    },
    methods: {
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
        return row.status === 0 ? '未维修' : '已维修'
      },
      /** 查询房客用户列表 */
      getTenantList() {
        listByRole({roleKey: "tenant"}).then(response => {
          this.tenantList = response.data;
        });
      },
      /** 查询房东用户列表 */
      getLandlordList() {
        if (!this.$store.getters.roles.includes('admin')) {
          return
        }
        listByRole({roleKey: "landlord"}).then(response => {
          this.landlordList = response.data;
        });
      },
      getHouseList() {
        listAllHouse({}).then(response => {
          this.houseList = response.data;
        });
      },
      /** 查询报修列表 */
      getList() {
        this.loading = true;
        listRepair(this.queryParams).then(response => {
          this.repairList = response.rows;
          this.total = response.total;
          this.loading = false;
        });
      },
      // 取消按钮
      cancel() {
        this.open = false;
        this.reset();
      },
      /** 重置按钮操作 */
      resetQuery() {
        this.resetForm("queryForm");
        this.handleQuery();
      },
      /** 搜索按钮操作 */
      handleQuery() {
        this.queryParams.pageNum = 1;
        this.getList();
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        updateRepair({repairId: row.repairId, status: 1}).then(response => {
          this.$modal.msgSuccess("处理成功");
          this.getList();
        });
      },
      /** 删除按钮操作 */
      handleDelete(row) {
        const repairIds = row.repairId || this.ids;
        this.$modal.confirm('是否确认删除该报修？').then(function () {
          return delRepair(repairIds);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {
        });
      },
    }
  };
</script>
