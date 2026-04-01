<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="房东账号" prop="userId" v-if="$store.getters.roles.includes('admin')">
        <el-select v-model="queryParams.userId" clearable>
          <el-option v-for="item in landlordList" :key="item.userId" :label="item.nickName" :value="item.userId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="房源名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="房源地址" prop="address">
        <el-input
          v-model="queryParams.address"
          placeholder="请输入地址"
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
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getHouseList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="houseList" @expand-change="handleExpandChange" row-key="houseId">
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
      <el-table-column label="房源名称" align="center" prop="name"/>
      <el-table-column label="房源地址" align="center" prop="address"/>
      <el-table-column label="基础设施" align="center" prop="infrastructure" :formatter="formatInfrastructure"/>
      <el-table-column label="房源面积" align="center" prop="area"/>
      <el-table-column label="房源价格/天" align="center" prop="price"/>
      <!--      <el-table-column label="描述" align="center" prop="description"/>-->
      <el-table-column label="供租状态" align="center" prop="rentStatus" :formatter="formatRentStatus"/>
      <el-table-column label="房屋状态" align="center" prop="houseStatus" :formatter="formatHouseStatus"/>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getHouseList"
    />
  </div>
</template>

<script>
  import {listHouse} from "@/api/system/house";
  import {getDicts} from "../../api/system/dict/data";
  import {listComment, getComment, delComment, addComment, updateComment} from "@/api/system/comment";
  import {listByRole} from "../../api/system/user";

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
        // 房源表格数据
        houseList: [],
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
        infrastructureOptions: [],
        landlordList: [],
        tenantList: []
      };
    },
    created() {
      this.getHouseList();
      this.getInfrastructureList();
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
      formatRentStatus(row, column) {
        if (row.rentStatus === 0) {
          return "未供租"
        } else if (row.rentStatus === 1) {
          return "已供租"
        } else {
          return "未知"
        }
      },
      formatHouseStatus(row, column) {
        if (row.houseStatus === 0) {
          return "空置"
        } else if (row.houseStatus === 1) {
          return "已下单未入住"
        } else if (row.houseStatus === 2) {
          return "已入住";
        } else {
          return "未知"
        }
      },
      formatInfrastructure(row, column) {
        let dictCodeList = row.infrastructure.split(",");
        let infrastructure = [];
        for (const dictCode of dictCodeList) {
          let dict = this.infrastructureOptions.filter(item => item.dictCode.toString() === dictCode)[0];
          if (dict) {
            infrastructure.push(dict.dictLabel);
          }
        }
        return infrastructure.join("，");
      },
      /** 查询房源列表 */
      getHouseList() {
        this.loading = true;
        listHouse(this.queryParams).then(response => {
          this.houseList = response.rows;
          this.total = response.total;
          this.loading = false;
        });
      },
      /** 查询基础设施列表 */
      getInfrastructureList() {
        getDicts("house_infrastructure").then(response => {
          this.infrastructureOptions = response.data;
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
        return listComment({houseId: row.houseId, type: 1}).then(response => {
          this.$set(row, 'total', response.total)
          this.$set(row, 'commentList', response.rows)
          this.$set(row, 'loading', false)
        })
      },
      /** 搜索按钮操作 */
      handleQuery() {
        this.queryParams.pageNum = 1;
        this.getHouseList();
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
          this.getHouseList();
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
