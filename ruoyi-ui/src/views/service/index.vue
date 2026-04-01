<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="房东账号" prop="userId" v-if="$store.getters.roles.includes('admin')">
        <el-select v-model="queryParams.userId" clearable>
          <el-option v-for="item in landlordList" :key="item.userId" :label="item.nickName" :value="item.userId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="房源" prop="houseId">
        <el-select v-model="queryParams.houseId" clearable>
          <el-option v-for="item in houseList" :key="item.houseId" :label="item.name" :value="item.houseId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="服务名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入服务名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['system:service:add']"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:service:edit']"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:service:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:service:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="serviceList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="房东账号" align="center" prop="userId" :formatter="formatUserId"
                       v-if="$store.getters.roles.includes('admin')"/>
      <el-table-column label="房源名称" align="center" prop="houseId" :formatter="formatHouseId"/>
      <el-table-column label="服务名称" align="center" prop="name"/>
      <el-table-column label="服务描述" align="center" prop="description"/>
      <el-table-column label="服务价格" align="center" prop="price"/>
      <el-table-column label="服务成本" align="center" prop="cost"/>
      <el-table-column label="剩余数量" align="center" prop="remain"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:service:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:service:remove']"
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

    <!-- 添加或修改特色服务对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="房源" prop="houseId">
          <el-select v-model="form.houseId">
            <el-option v-for="item in houseList" :key="item.houseId" :label="item.name" :value="item.houseId"/>
          </el-select>
        </el-form-item>
        <el-form-item label="服务名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入服务名称"/>
        </el-form-item>
        <el-form-item label="服务描述" prop="description">
          <el-input type="textarea" v-model="form.description" placeholder="请输入服务描述"/>
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input v-model="form.price" placeholder="请输入价格"/>
        </el-form-item>
        <el-form-item label="成本" prop="cost">
          <el-input v-model="form.cost" placeholder="请输入成本"/>
        </el-form-item>
        <el-form-item label="数量" prop="remain">
          <el-input v-model="form.remain" placeholder="请输入数量"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import {listService, getService, delService, addService, updateService} from "@/api/system/service";
  import {listAllHouse} from "../../api/system/house";
  import {listByRole} from "../../api/system/user";

  export default {
    name: "Service",
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
        // 特色服务表格数据
        serviceList: [],
        // 弹出层标题
        title: "",
        // 是否显示弹出层
        open: false,
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
          userId: null,
          houseId: null,
          name: null,
        },
        // 表单参数
        form: {},
        // 表单校验
        rules: {
          houseId: [
            {required: true, message: "房源不能为空", trigger: "blur"}
          ],
          name: [
            {required: true, message: "名称不能为空", trigger: "blur"}
          ],
          description: [
            {required: true, message: "描述不能为空", trigger: "blur"}
          ],
          price: [
            {required: true, message: "价格不能为空", trigger: "blur"}
          ],
          cost: [
            {required: true, message: "成本不能为空", trigger: "blur"}
          ],
          remain: [
            {required: true, message: "数量不能为空", trigger: "blur"}
          ],
        },
        houseList: [],
        landlordList: []
      };
    },
    created() {
      this.getList();
      this.getHouseList();
      this.getLandlordList();
    },
    methods: {
      formatUserId(row, column) {
        let filterElement = this.landlordList.filter(item => item.userId === row.userId)[0];
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
      /** 查询房东用户列表 */
      getLandlordList() {
        if (!this.$store.getters.roles.includes('admin')) {
          return
        }
        listByRole({roleKey: "landlord"}).then(response => {
          this.landlordList = response.data;
        });
      },
      /** 查询特色服务列表 */
      getList() {
        this.loading = true;
        listService(this.queryParams).then(response => {
          this.serviceList = response.rows;
          this.total = response.total;
          this.loading = false;
        });
      },
      getHouseList() {
        listAllHouse({}).then(response => {
          this.houseList = response.data;
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
          serviceId: null,
          houseId: null,
          name: null,
          price: null,
          description: null,
          cost: null,
          remain: null,
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
      /** 重置按钮操作 */
      resetQuery() {
        this.resetForm("queryForm");
        this.handleQuery();
      },
      // 多选框选中数据
      handleSelectionChange(selection) {
        this.ids = selection.map(item => item.serviceId)
        this.single = selection.length !== 1
        this.multiple = !selection.length
      },
      /** 新增按钮操作 */
      handleAdd() {
        this.reset();
        this.open = true;
        this.title = "添加特色服务";
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        this.reset();
        const serviceId = row.serviceId || this.ids
        getService(serviceId).then(response => {
          this.form = response.data;
          this.open = true;
          this.title = "修改特色服务";
        });
      },
      /** 提交按钮 */
      submitForm() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.serviceId != null) {
              updateService(this.form).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              this.form.userId = this.houseList.filter(item => item.houseId === this.form.houseId)[0].userId;
              addService(this.form).then(response => {
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
        const serviceIds = row.serviceId || this.ids;
        this.$modal.confirm('是否确认删除特色服务编号为"' + serviceIds + '"的数据项？').then(function () {
          return delService(serviceIds);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {
        });
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('system/service/export', {
          ...this.queryParams
        }, `service_${new Date().getTime()}.xlsx`)
      }
    }
  };
</script>
