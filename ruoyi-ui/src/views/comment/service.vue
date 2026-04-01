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
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:comment:remove']"
        >删除
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getServiceList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="serviceList" @expand-change="handleExpandChange" row-key="serviceId">
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-table border :data="props.row.commentList" v-loading="props.row.loading" row-key="commentId"
                    @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center"/>
            <el-table-column label="房客" align="center" prop="userId" :formatter="formatTenantUserId"/>
            <el-table-column label="评分" align="center" prop="score"/>
            <el-table-column label="评论内容" align="center" prop="content"/>
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
              <template slot-scope="scope">
                <el-button
                  size="mini"
                  type="text"
                  icon="el-icon-delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['system:comment:remove']"
                >删除
                </el-button>
              </template>
            </el-table-column>
          </el-table>
          <pagination
            v-show="props.row.total>0"
            :total="props.row.total"
            :page.sync="props.row.pageNum"
            :limit.sync="props.row.pageSize"
            @pagination="getCommentList(props.row)"
          />
        </template>
      </el-table-column>
      <el-table-column label="房东账号" align="center" prop="userId" :formatter="formatUserId"
                       v-if="$store.getters.roles.includes('admin')"/>
      <el-table-column label="房源名称" align="center" prop="houseId" :formatter="formatHouseId"/>
      <el-table-column label="服务名称" align="center" prop="name"/>
      <el-table-column label="服务描述" align="center" prop="description"/>
      <el-table-column label="服务价格" align="center" prop="price"/>
      <el-table-column label="服务成本" align="center" prop="cost"/>
      <el-table-column label="剩余数量" align="center" prop="remain"/>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getServiceList"
    />
  </div>
</template>

<script>
  import {listComment, getComment, delComment, addComment, updateComment} from "@/api/system/comment";
  import {listByRole} from "../../api/system/user";
  import {listAllHouse} from "../../api/system/house";
  import {listService} from "../../api/system/service";

  export default {
    name: "Comment",
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
          name: null,
          address: null,
        },
        // 表单参数
        form: {},
        // 表单校验
        rules: {},
        houseList: [],
        landlordList: [],
        tenantList:[]
      };
    },
    created() {
      this.getServiceList();
      this.getHouseList();
      this.getLandlordList();
      this.getTenantList()
    },
    methods: {
      formatUserId(row, column) {
        let filterElement = this.landlordList.filter(item => item.userId === row.userId)[0];
        if (filterElement) {
          return filterElement.nickName
        }
        return row.userId;
      },
      formatTenantUserId(row, column) {
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
      /** 查询房源列表 */
      getHouseList() {
        listAllHouse({}).then(response => {
          this.houseList = response.data;
        });
      },
      getServiceList() {
        this.loading = true;
        listService(this.queryParams).then(response => {
          this.serviceList = response.rows;
          this.total = response.total;
          this.loading = false;
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
      getTenantList() {
        listByRole({roleKey: "tenant"}).then(response => {
          this.tenantList = response.data;
        });
      },
      handleExpandChange(row, expandedRows) {
        // 判断当前行是否展开
        const isExpanded = expandedRows.some(item => item.houseId === row.houseId);
        if (!isExpanded) {
          // 展开时触发查询操作
          return
        }
        this.getCommentList(row);
      },
      /** 查询评价列表 */
      getCommentList(row) {
        this.$set(row, 'total', 0)
        this.$set(row, 'commentList', [])
        this.$set(row, 'loading', true)
        return listComment({houseId: row.houseId, type: 2}).then(response => {
          this.$set(row, 'total', response.total)
          this.$set(row, 'commentList', response.rows)
          this.$set(row, 'loading', false)
        })
      },
      /** 搜索按钮操作 */
      handleQuery() {
        this.queryParams.pageNum = 1;
        this.getServiceList();
      },
      /** 重置按钮操作 */
      resetQuery() {
        this.resetForm("queryForm");
        this.handleQuery();
      },
      // 多选框选中数据
      handleSelectionChange(selection) {
        this.ids = selection.map(item => item.commentId)
        this.single = selection.length !== 1
        this.multiple = !selection.length
      },
      /** 删除按钮操作 */
      handleDelete(row) {
        const commentIds = row.commentId || this.ids;
        this.$modal.confirm('是否确认删除该评论？').then(function () {
          return delComment(commentIds);
        }).then(() => {
          this.getServiceList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {
        });
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('system/comment/export', {
          ...this.queryParams
        }, `comment_${new Date().getTime()}.xlsx`)
      }
    }
  };
</script>
