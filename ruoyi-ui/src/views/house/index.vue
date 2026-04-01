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
      <el-form-item label="供租状态" prop="rentStatus">
        <el-select v-model="queryParams.rentStatus" clearable>
          <el-option :key="0" label="未供租" :value="0"/>
          <el-option :key="1" label="已供租" :value="1"/>
        </el-select>
      </el-form-item>
      <el-form-item label="房屋状态" prop="houseStatus">
        <el-select v-model="queryParams.houseStatus" clearable>
          <el-option :key="0" label="空置" :value="0"/>
          <el-option :key="1" label="已下单未入住" :value="1"/>
          <el-option :key="2" label="已入住" :value="2"/>
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
          v-hasPermi="['system:house:add']"
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
          v-hasPermi="['system:house:edit']"
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
          v-hasPermi="['system:house:remove']"
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
          v-hasPermi="['system:house:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="houseList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
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
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:house:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:house:remove']"
            v-if="scope.row.rentStatus!==1"
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

    <!-- 添加或修改房源对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="房东" prop="userId" v-if="$store.getters.roles.includes('admin')">
          <el-select v-model="form.userId" clearable>
            <el-option v-for="item in landlordList" :key="item.userId" :label="item.nickName" :value="item.userId"/>
          </el-select>
        </el-form-item>
        <el-form-item label="房源名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入名称"/>
        </el-form-item>
        <el-form-item label="房源地址" prop="address">
          <el-input  v-if="(title==='添加房源')" v-model="form.address" placeholder="请输入地址" />
          <el-input  v-if="(title==='修改房源')" v-model="form.address" placeholder="请输入地址"  disabled/>
        </el-form-item>
        <el-form-item label="基础设施" prop="infrastructure">
          <el-checkbox-group v-model="form.infrastructure" size="medium">
            <el-checkbox v-for="(item, index) in infrastructureOptions" :key="index" :label="item.dictCode.toString()">
              {{item.dictLabel}}
            </el-checkbox>
          </el-checkbox-group>
        </el-form-item>
        <el-form-item label="图片" prop="imageUrl">
          <el-input type="hidden" v-model="form.imageUrl"></el-input>
          <el-upload ref="upload" :file-list="imageUrlfileList" :auto-upload="false" multiple action=""
                     list-type="picture-card" accept="image/*">
            <i class="el-icon-plus"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="面积" prop="area">
          <el-input v-model="form.area" placeholder="请输入面积"/>
        </el-form-item>
        <el-form-item label="价格/天" prop="price">
          <el-input v-model="form.price" placeholder="请输入价格/天"/>
        </el-form-item>
        <el-form-item label="最大入住人数" prop="maxPerson">
          <el-input-number v-model="form.maxPerson" :min="1" :max="8"></el-input-number>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input type="textarea" v-model="form.description" placeholder="请输入描述"/>
        </el-form-item>
        <el-form-item label="门禁密码" prop="password">
          <el-input v-model="form.password" placeholder="请输入门禁密码" clearable show-password
                    auto-complete="off"></el-input>
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
import {listByRole} from '../../api/system/user';
import {listHouse, getHouse, delHouse, addHouse, updateHouse} from "@/api/system/house";
import {getDicts} from "../../api/system/dict/data";

export default {
  name: "House",
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
        rentStatus: null,
        houseStatus: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [{
          required: true,
          message: '请选择房东',
          trigger: 'blur'
        }],
        name: [{
          required: true,
          message: '请输入名称',
          trigger: 'blur'
        }],
        address: [{
          required: true,
          message: '请输入地址',
          trigger: 'blur'
        }],
        area: [{
          required: true,
          message: '请输入面积',
          trigger: 'blur',
        }],
        price: [{
          required: true,
          message: '请输入价格',
          trigger: 'blur'
        }],
        description: [{
          required: true,
          message: '请输入房源描述信息',
          trigger: 'blur'
        }],
        password: [{
          required: true,
          message: '请输入门禁密码',
          trigger: 'blur'
        }],
        infrastructure: [{
          required: true,
          type: 'array',
          message: '请至少选择一个基础设施',
          trigger: 'change'
        }],
        imageUrl: [{
          required: true,
          message: '请至少上传一张图片',
          trigger: 'blur'
        }],
        maxPerson: [{
          required: true,
          message: '最大入住人数不能为空',
          trigger: 'blur'
        }],
      },
      infrastructureOptions: [],
      imageUrlfileList: [],
      landlordList: []
    };
  },
  created() {
    this.getList();
    this.getInfrastructureList();
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
    getList() {
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
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.imageUrlfileList = [];
      this.form = {
        userId: null,
        houseId: null,
        name: null,
        address: null,
        infrastructure: [],
        imageUrl: null,
        area: null,
        price: null,
        description: null,
        password: null,
        maxPerson: null,
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
      this.ids = selection.map(item => item.houseId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加房源";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const houseId = row.houseId || this.ids
      getHouse(houseId).then(response => {
        let data = response.data;
        console.log(response.data)
        data.infrastructure = data.infrastructure.split(",")
        for (const url of data.imageUrl.split(",")) {
          let split = url.split('/');
          let fileName = split[split.length - 1];
          this.imageUrlfileList.push({name: fileName, url: url})
        }
        this.form = data;
        this.title = "修改房源";
        this.open = true;
        uhy
      });
    },
    fileToBase64(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onloadend = () => resolve(reader.result.split(",")[1]);
        reader.onerror = (err) => reject(err);
        reader.readAsDataURL(file);
      });
    },
    /** 提交按钮 */
    submitForm() {
      //图片转base64存入imageUrl
      let uploadFiles = this.$refs.upload.uploadFiles;
      let base64Promise = [];
      let oldUrl = [];
      for (const uploadFile of uploadFiles) {
        if (uploadFile.url.indexOf("/common/image/") !== -1) {
          oldUrl.push(uploadFile.name);
        } else {
          base64Promise.push(this.fileToBase64(uploadFile.raw))
        }
      }
      if (base64Promise.length !== 0) {
        Promise.all(base64Promise).then(res => {
          const urls = res.concat(oldUrl)
          this.form.imageUrl = urls.join(",");
          this.$refs["form"].validate(valid => {
            if (valid) {
              let data = {}
              Object.assign(data, this.form);
              data.infrastructure = data.infrastructure.join(",");
              if (data.houseId != null) {
                updateHouse(data).then(response => {
                  this.$modal.msgSuccess("修改成功");
                  this.open = false;
                  this.getList();
                });
              } else {
                addHouse(data).then(response => {
                  this.$modal.msgSuccess("新增成功");
                  this.open = false;
                  this.getList();
                });
              }
            }
          });
        })
      } else {
        this.form.imageUrl = oldUrl.join(",");
        this.$refs["form"].validate(valid => {
          if (valid) {
            let data = {}
            Object.assign(data, this.form);
            data.infrastructure = data.infrastructure.join(",");
            if (data.houseId != null) {
              updateHouse(data).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              addHouse(data).then(response => {
                this.$modal.msgSuccess("新增成功");
                this.open = false;
                this.getList();
              });
            }
          }
        });
      }
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const houseIds = row.houseId || this.ids;
      this.$modal.confirm('是否确认删除该房源？').then(function () {
        return delHouse(houseIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/house/export', {
        ...this.queryParams
      }, `house_${new Date().getTime()}.xlsx`)
    },
  }
};
</script>
