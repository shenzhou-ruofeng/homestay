<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="100px">
      <el-form-item label="房东" prop="userId" v-if="this.$store.getters.roles.includes('admin')">
        <el-select v-model="queryParams.userId" clearable>
          <el-option v-for="item in landlordList" :key="item.userId" :label="item.nickName" :value="item.userId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="房源" prop="houseId">
        <el-select v-model="queryParams.houseId" clearable>
          <el-option v-for="item in houseList" :key="item.houseId" :label="item.name" :value="item.houseId"/>
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" clearable>
          <el-option :key="0" label="审核中" :value="0"/>
          <el-option :key="1" label="审核失败" :value="1"/>
          <el-option :key="2" label="合同生效" :value="2"/>
          <el-option :key="3" label="合同终止" :value="3"/>
          <el-option :key="4" label="合同到期" :value="4"/>
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
          v-hasPermi="['system:contract:add']"
          v-if="$store.getters.roles.includes('landlord')"
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
          v-hasPermi="['system:contract:edit']"
        >修改
        </el-button>
      </el-col>
      <!--      <el-col :span="1.5">-->
      <!--        <el-button-->
      <!--          type="danger"-->
      <!--          plain-->
      <!--          icon="el-icon-delete"-->
      <!--          size="mini"-->
      <!--          :disabled="multiple"-->
      <!--          @click="handleDelete"-->
      <!--          v-hasPermi="['system:contract:remove']"-->
      <!--        >删除-->
      <!--        </el-button>-->
      <!--      </el-col>-->
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:contract:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="contractList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="房东账号" align="center" prop="userId" :formatter="formatUserId"
                       v-if="$store.getters.roles.includes('admin')"/>
      <el-table-column label="房东姓名" align="center" prop="landlordName"/>
      <el-table-column label="房东电话" align="center" prop="landlordPhone"/>
      <el-table-column label="房源名称" align="center" prop="houseName"/>
      <el-table-column label="房源地址" align="center" prop="houseAddress"/>
      <el-table-column label="状态" align="center" prop="status" :formatter="formatStatus"/>
      <el-table-column label="生效日期" align="center" prop="signingDate"/>
      <el-table-column label="终止日期" align="center" prop="terminateDate"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:contract:edit']"
            v-if="$store.getters.roles.includes('landlord')&&scope.row.status===0"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleReapply(scope.row)"
            v-hasPermi="['system:contract:edit']"
            v-if="$store.getters.roles.includes('landlord')&&scope.row.status===1"
          >重新申请
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleView(scope.row)"
            v-hasPermi="['system:contract:list']"
            v-if="scope.row.status===2||scope.row.status===3"
          >查看
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-circle-close"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:contract:edit']"
            v-if="scope.row.status===2"
          >终止
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-finished"
            @click="handleCheck(scope.row)"
            v-hasPermi="['system:contract:edit']"
            v-if="$store.getters.roles.includes('admin')&&(scope.row.status===0||scope.row.status===1)"
          >{{scope.row.status===0?'审核':'重新审核'}}
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

    <!-- 添加或修改合同对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-steps :active="activeStep" align-center>
        <el-step title="填写信息" icon="el-icon-edit"></el-step>
        <el-step title="确认合同" icon="el-icon-document-checked"></el-step>
      </el-steps>
      <el-divider></el-divider>
      <el-form v-if="activeStep===1" ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="房源" prop="houseId">
          <el-select v-model="form.houseId" @change="handleSelectHouse">
            <el-option v-for="item in houseList" :key="item.houseId" :label="item.name" :value="item.houseId"/>
          </el-select>
        </el-form-item>
        <el-form-item label="房源地址" prop="houseAddress">
          <el-input v-model="form.houseAddress" placeholder="请输入房源地址"/>
        </el-form-item>
        <el-form-item label="房东姓名" prop="landlordName">
          <el-input v-model="form.landlordName" placeholder="请输入房东姓名"/>
        </el-form-item>
        <el-form-item label="房东身份证" prop="landlordIdcard">
          <el-input v-model="form.landlordIdcard" placeholder="请输入房东身份证"/>
        </el-form-item>
        <el-form-item label="房东电话" prop="landlordPhone">
          <el-input v-model="form.landlordPhone" placeholder="请输入房东电话"/>
        </el-form-item>
        <el-form-item label="房东地址" prop="landlordAddress">
          <el-input v-model="form.landlordAddress" placeholder="请输入房东地址"/>
        </el-form-item>
      </el-form>
      <contract-template v-if="activeStep===2" id="contract" :data="form"></contract-template>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="nextStep" v-if="activeStep===1">下一步</el-button>
        <el-button type="danger" @click="prevStep" v-if="activeStep===2">上一步</el-button>
        <el-button type="primary" @click="submitForm" v-if="activeStep===2">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <el-dialog :title="checkTitle" :visible.sync="openCheck" width="800px" append-to-body>
      <contract-template ref="contract" :data="form"></contract-template>
      <div v-if="!view">
        <el-divider></el-divider>
        <el-form ref="form" :model="form" :rules="rules" label-width="120px">
          <el-form-item label="审核状态" prop="status">
            <el-select v-model="form.status" @change="handleSelectStatus">
              <el-option :key="1" label="审核失败" :value="1"/>
              <el-option :key="2" label="审核通过" :value="2"/>
            </el-select>
          </el-form-item>
          <el-form-item label="失败原因" prop="errMsg" v-if="form.status===1">
            <el-input type="textarea" v-model="form.errMsg"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm" v-if="!view">确 定</el-button>
        <el-button type="primary" @click="print" v-if="view">打 印</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {listContract, getContract, addContract, updateContract} from "@/api/system/contract";
import {listByRole} from "../../api/system/user";
import {listAllHouse} from "../../api/system/house";
import {getDicts} from "../../api/system/dict/data";
import ContractTemplate from "./contractTemplate";

export default {
  name: "Contract",
  components: {ContractTemplate},
  data() {
    const validateIdCard = (rule, value, callback) => {
      const reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
      if (!value) {
        return callback(new Error('请输入身份证号'));
      }
      if (!reg.test(value)) {
        return callback(new Error('请输入正确的身份证号'));
      }
      callback();
    };
    const validatePhoneNumber = (rule, value, callback) => {
      const reg = /^1[3456789]\d{9}$/;
      if (!value) {
        return callback(new Error('请输入手机号'));
      }
      if (!reg.test(value)) {
        return callback(new Error('请输入正确的手机号'));
      }
      callback();
    };
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
      // 合同表格数据
      contractList: [],
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
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        houseId: [
          {required: true, message: "房源不能为空", trigger: "blur"}
        ],
        houseAddress: [
          {required: true, message: "房源地址不能为空", trigger: "blur"}
        ],
        landlordName: [
          {required: true, message: "房东姓名不能为空", trigger: "blur"}
        ],
        landlordIdcard: [
          {required: true, message: "房东身份证不能为空", trigger: "blur"},
          {required: true, validator: validateIdCard, trigger: "blur"}
        ],
        landlordPhone: [
          {required: true, message: "房东电话不能为空", trigger: "blur"},
          {required: true, validator: validatePhoneNumber, trigger: "blur"}
        ],
        landlordAddress: [
          {required: true, message: "房东地址不能为空", trigger: "blur"},
        ],
        status: [
          {required: true, message: "审核状态不能为空", trigger: "blur"},
        ],
        errMsg: [
          {required: true, message: "失败原因不能为空", trigger: "blur"},
        ],
      },
      houseList: [],
      landlordList: [],
      activeStep: 1,
      openCheck: false,
      view: false,
      checkTitle: ""
    };
  },
  created() {
    this.getList();
    this.getHouseList();
    this.getLandlordList();
  },
  methods: {
    formatStatus(row, column) {
      if (row.status === 0) {
        return "审核中"
      } else if (row.status === 1) {
        return "审核失败"
      } else if (row.status === 2) {
        return "合同生效"
      } else if (row.status === 3) {
        return "合同终止"
      } else if (row.status === 4) {
        return "合同到期"
      }
    },
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
    /** 查询未提交合同的房屋列表 */
    getHouseList() {
      listAllHouse({}).then(response => {
        this.houseList = response.data;
      });
    },
    handleSelectHouse(houseId) {
      if (!houseId) {
        this.form.houseAddress = null
      } else {
        this.form.houseAddress = this.houseList.filter(item => item.houseId === houseId)[0].address
      }
    },
    /** 查询合同列表 */
    getList() {
      this.loading = true;
      listContract(this.queryParams).then(response => {
        this.contractList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    //下一步按钮
    nextStep() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          getDicts("contract_info").then(response => {
            for (const dict of response.data) {
              this.form[dict.dictValue] = dict.dictLabel
            }
            this.activeStep = 2;
          });
        }
      });
    },
    prevStep() {
      this.activeStep = 1;
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.openCheck = false;
      this.activeStep = 1;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        contractId: null,
        houseId: null,
        houseAddress: null,
        userId: null,
        landlordName: null,
        landlordIdcard: null,
        landlordPhone: null,
        landlordAddress: null,
        status: null,
        errMsg: null
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
      this.ids = selection.map(item => item.contractId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加合同";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      this.activeStep = 1;
      const contractId = row.contractId || this.ids
      getContract(contractId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改合同";
      });
    },
    handleReapply(row) {
      this.reset();
      this.activeStep = 1;
      const contractId = row.contractId || this.ids
      getContract(contractId).then(response => {
        this.form = response.data;
        this.form.status = 0;
        this.open = true;
        this.title = "重新申请合同";
      });
    },
    /** 提交按钮 */
    submitForm() {
      if (this.form.contractId != null) {
        if (this.openCheck) {
          //审核信息保存
          this.$refs["form"].validate(valid => {
            if (valid) {
              updateContract(this.form).then(response => {
                this.$modal.msgSuccess("审核结果保存成功");
                this.openCheck = false;
                this.getList();
              });
            }
          });
        } else {
          updateContract(this.form).then(response => {
            this.$modal.msgSuccess("修改成功，等待平台审核");
            this.open = false;
            this.getList();
          });
        }
      } else {
        this.form.userId = this.houseList.filter(item => item.houseId === this.form.houseId)[0].userId;
        addContract(this.form).then(response => {
          this.$modal.msgSuccess("新增成功，等待平台审核");
          this.open = false;
          this.getList();
        });
      }
    },
    /** 审核 */
    handleCheck(row) {
      this.view = false;
      this.reset();
      const contractId = row.contractId || this.ids
      getContract(contractId).then(response => {
        this.form = response.data;
        this.form.errMsg = null
        this.form.status = this.form.status === 0 ? null : this.form.status;
        this.checkTitle = "审核合同信息"
        this.openCheck = true;
      });
    },
    handleSelectStatus(value) {
      //审核通过给表单审核通过日期赋值
      if (value === 2) {
        const d = new Date();
        const year = d.getFullYear();
        const month = ('0' + (d.getMonth() + 1)).slice(-2);
        const day = ('0' + d.getDate()).slice(-2);
        this.form.signingDate = year + '-' + month + '-' + day;
      } else {
        this.form.signingDate = null;
      }
    },
    /** 查看合同 */
    handleView(row) {
      this.view = true;
      this.reset();
      const contractId = row.contractId || this.ids
      getContract(contractId).then(response => {
        this.form = response.data;
        this.form.status = this.form.status === 0 ? null : this.form.status;
        this.checkTitle = "合同信息"
        this.openCheck = true;
      });
    },
    print() {
      // 创建一个 iframe 用于打印
      const iframe = document.createElement('iframe');
      document.body.appendChild(iframe);

      // 获取 iframe 的 document
      const doc = iframe.contentDocument || iframe.contentWindow.document;

      // 将需要打印的内容复制到 iframe 中
      const printContent = document.getElementsByClassName('contract_wrap')[0].innerHTML;
      doc.write('<html><head><title></title></head><body>' + printContent + '</body></html>');
      doc.close();

      iframe.contentWindow.print();
      document.body.removeChild(iframe);
    },
    /** 终止按钮操作 */
    handleDelete(row) {
      this.$modal.confirm('是否确认终止该合同？').then(function () {
        const d = new Date();
        const year = d.getFullYear();
        const month = ('0' + (d.getMonth() + 1)).slice(-2);
        const day = ('0' + d.getDate()).slice(-2);
        let terminateDate = year + '-' + month + '-' + day;
        return updateContract({
          contractId: row.contractId,
          houseId: row.houseId,
          terminateDate: terminateDate,
          status: 3
        });
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("终止成功");
      }).catch(() => {
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/contract/export', {
        ...this.queryParams
      }, `contract_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
