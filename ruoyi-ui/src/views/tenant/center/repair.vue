<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="房源" prop="houseId">
        <el-select v-model="queryParams.houseId" clearable>
          <el-option v-for="item in houseList" :key="item.houseId" :label="item.name" :value="item.houseId"/>
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
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >新增
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="repairList">
      <el-table-column label="房源" align="center" prop="houseId" :formatter="formatHouseId"/>
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
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
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

    <!-- 添加或修改报修对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="房源" prop="houseId">
          <el-select v-model="form.houseId" clearable>
            <el-option v-for="item in houseList" :key="item.houseId" :label="item.name" :value="item.houseId"/>
          </el-select>
        </el-form-item>
        <el-form-item label="报修描述" prop="description">
          <el-input type="textarea" v-model="form.description" placeholder="请输入报修描述"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel">取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import {listRepair, getRepair, delRepair, addRepair, updateRepair} from "@/api/tenant/repair";
  import {listAllHouse} from "@/api/tenant/house";

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
        // 表单参数
        form: {},
        // 表单校验
        rules: {
          houseId: [
            {required: true, message: "房源不能为空", trigger: "blur"}
          ],
          description: [
            {required: true, message: "描述不能为空", trigger: "blur"}
          ],
        },
        houseList: [],
      };
    },
    created() {
      this.getList();
      this.getHouseList();
    },
    methods: {
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
      // 表单重置
      reset() {
        this.form = {
          repairId: null,
          landlordUserId: null,
          houseId: null,
          userId: null,
          description: null,
          status: null,
        };
        this.resetForm("form");
      },
      /** 搜索按钮操作 */
      handleQuery() {
        this.queryParams.pageNum = 1;
        this.getList();
      },
      /** 重置按钮操作 */
      resetQuery() {
        this.resetForm("queryForm");
        this.handleQuery();
      },
      /** 新增按钮操作 */
      handleAdd() {
        this.reset();
        this.open = true;
        this.title = "添加报修";
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        this.reset();
        const repairId = row.repairId || this.ids
        getRepair(repairId).then(response => {
          this.form = response.data;
          this.open = true;
          this.title = "修改报修";
        });
      },
      /** 提交按钮 */
      submitForm() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.repairId != null) {
              updateRepair(this.form).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              this.form.landlordUserId = this.houseList.filter(item => item.houseId === this.form.houseId)[0].userId
              this.form.userId = this.$store.getters.userId
              addRepair(this.form).then(response => {
                this.$modal.msgSuccess("新增成功");
                this.open = false;
                this.getList();
              });
            }
          }
        });
      },
      /** 删除按钮操作 */
      handleDelete(row) {
        const repairIds = row.repairId || this.ids;
        this.$modal.confirm('是否确认删除报修编号为"' + repairIds + '"的数据项？').then(function () {
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
