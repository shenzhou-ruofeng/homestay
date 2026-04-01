<template>
  <div class="detail-wrap">
    <tenant-navbar></tenant-navbar>
    <div class="detail-content">
      <el-breadcrumb separator=">" style="margin-bottom: 30px">
        <el-breadcrumb-item :to="{ path: '/search' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>{{house.name}}</el-breadcrumb-item>
      </el-breadcrumb>
      <el-row>
        <h1 class="house-name">{{house.name}}</h1>
      </el-row>
      <el-row style="margin: 20px 0 50px 0" type="flex" justify="space-between">
        <el-col :span="12">
          <el-carousel height="350px">
            <el-carousel-item v-for="item in house.imageUrl.split(',')" :key="item">
              <el-image
                :src="item"
              ></el-image>
            </el-carousel-item>
          </el-carousel>
        </el-col>
        <el-col :span="11">
          <el-row>
            <div class="house-info-row-wrap">
              <span class="house-price">{{house.price}}</span>
              <span class="house-price-unit">元/天</span>
            </div>
          </el-row>
          <el-row>
            <div class="house-info-row-wrap">
              <span class="house-info-label">房屋地址：</span>
              <span class="house-info-value">{{house.address}}</span>
            </div>
          </el-row>
          <el-row>
            <div class="house-info-row-wrap">
              <span class="house-info-label">房屋面积：</span>
              <span class="house-info-value">{{house.area}}㎡</span>
            </div>
          </el-row>
          <el-row>
            <div class="house-info-row-wrap">
              <span class="house-info-label">入住人数：</span>
              <span class="house-info-value">
                <el-input-number v-model="num" :min="1" :max="house.maxPerson" size="small"></el-input-number>
                <el-button style="margin-left: 20px" @click="openTenantInfo = true">填写入住人信息</el-button>
              </span>
            </div>
          </el-row>
          <el-row>
            <div class="house-info-row-wrap">
              <span class="house-info-label">入住时间：</span>
              <span class="house-info-value">
                <el-date-picker
                  size="small"
                  v-model="date"
                  type="daterange"
                  :picker-options="pickerOptions"
                  range-separator="至"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期">
                </el-date-picker>
              </span>
            </div>
          </el-row>
          <el-row>
            <div class="house-info-row-wrap">
              <span class="house-info-label">特色服务：</span>
              <span class="house-info-value">
                <el-button @click="openService = true" style="margin-right: 20px">选择特色服务</el-button>
                <el-tag v-for="item in order.orderItems.filter(item=>item.type===2)">{{item.name+"×"+item.num}}</el-tag>
              </span>
            </div>
          </el-row>
          <el-row>
            <el-button type="primary" class="order-buttom" @click="handleSubmitOrder">立即下单</el-button>
          </el-row>
        </el-col>
      </el-row>
      <el-tabs v-model="activeName" type="card" @tab-click="handleClickTab">
        <el-tab-pane label="房源详情" name="first" class="tab-pane-wrap">
          <div>
            <el-row>
              <div class="detail-label">基础设施</div>
            </el-row>
            <el-row type="flex" justify="space-between">
              <el-col v-for="item in infrastructureOptions">
                <div v-if="house.infrastructure.split(',').filter(obj=>obj===item.dictCode.toString())[0]"
                     style="color: #0086f6">
                  <el-row type="flex" justify="center">
                    <i class="el-icon-circle-check" style="font-size: 50px">
                    </i>
                  </el-row>
                  <el-row type="flex" justify="center">
                    <span>{{item.dictLabel}}</span>
                  </el-row>
                </div>
                <div v-else style="color: #999999">
                  <el-row type="flex" justify="center">
                    <i class="el-icon-circle-close" style="font-size: 50px">
                    </i>
                  </el-row>
                  <el-row type="flex" justify="center">
                    <span>{{item.dictLabel}}</span>
                  </el-row>
                </div>
              </el-col>
            </el-row>
          </div>
          <div style="margin-top: 20px">
            <el-row>
              <div class="detail-label">房源描述</div>
            </el-row>
            <el-row>
              <div style="color: #555555;font-size: 14px;padding: 0 10px;line-height: 25px">{{house.description}}</div>
            </el-row>
          </div>
        </el-tab-pane>
        <el-tab-pane label="特色服务" name="second" class="tab-pane-wrap">
          <el-empty :image-size="200" v-if="house.services.length===0"></el-empty>
          <div v-else>
            <div class="service-wrap" v-for="item in house.services">
              <div class="service-name">{{item.name}}</div>
              <div class="service-description">{{item.description}}</div>
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="房源评价" name="third" class="tab-pane-wrap">
          <el-empty :image-size="200" v-if="house.houseComments.length===0"></el-empty>
          <div v-else>
            <el-row class="comment-wrap" v-for="item in house.houseComments">
              <el-col :span="2">
                <el-avatar :size="60" :src="item.avatar"></el-avatar>
              </el-col>
              <el-col :span="22">
                <div class="comment-username">{{item.nickName}}</div>
                <div>
                  <el-rate v-model="item.score"></el-rate>
                </div>
                <div class="comment-time">{{item.createTime.split(" ")[0]}}</div>
                <div class="comment-content"> {{item.content}}</div>
              </el-col>
            </el-row>
          </div>
        </el-tab-pane>
        <el-tab-pane label="特色服务评价" name="fourth" class="tab-pane-wrap">
          <el-empty :image-size="200" v-if="house.serviceComments.length===0"></el-empty>
          <div v-else>
            <el-row class="comment-wrap" v-for="item in house.serviceComments">
              <el-col :span="2">
                <el-avatar :size="60" :src="item.avatar"></el-avatar>
              </el-col>
              <el-col :span="22">
                <div class="comment-username">{{item.nickName}}</div>
                <div class="comment-service-name">特色服务名称：{{item.serviceName}}</div>
                <div>
                  <el-rate v-model="item.score"></el-rate>
                </div>
                <div class="comment-time">{{item.createTime.split(" ")[0]}}</div>
                <div class="comment-content"> {{item.content}}</div>
              </el-col>
            </el-row>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>

    <el-dialog
      title="特色服务"
      :visible.sync="openService"
      width="80%">
      <el-table
        :data="house.services"
        style="width: 100%">
        <el-table-column
          prop="name"
          label="服务名称">
        </el-table-column>
        <el-table-column
          prop="description"
          width="250"
          label="服务描述">
        </el-table-column>
        <el-table-column
          prop="price"
          label="价格/元">
        </el-table-column>
        <el-table-column
          prop="remain"
          label="剩余数量">
        </el-table-column>
        <el-table-column
          label="购买数量">
          <template slot-scope="scope">
            <el-input-number v-model="scope.row.num" :min="0" :max="scope.row.remain" size="small"
                             :step="1" step-strictly
                             @change="handleServiceNum(scope.row)"></el-input-number>
          </template>
        </el-table-column>
        <el-table-column
          prop="total"
          label="金额/元">
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="openService = false">取 消</el-button>
        <el-button type="primary" @click="handleSaveService">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog
      title="入住人信息"
      :visible.sync="openTenantInfo"
      width="50%">
      <el-form ref="form" :model="form" :rules="rules" label-width="70px">
        <el-row :gutter="10">
          <el-col :span="10">
            <el-form-item label="姓名" prop="name">
              <el-input v-model="form.name" placeholder="请输入姓名"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="10">
            <el-form-item label="身份证" prop="idcard">
              <el-input v-model="form.idcard" placeholder="请输入身份证号"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="4">
            <el-button type="primary" @click="handleAddTenantInfo">保 存</el-button>
          </el-col>
        </el-row>
      </el-form>
      <el-table
        :data="tenantInfos"
        style="width: 100%;">
        <el-table-column
          prop="name"
          label="姓名">
        </el-table-column>
        <el-table-column
          prop="idcard"
          label="身份证号">
        </el-table-column>
        <el-table-column
          label="操作">
          <template slot-scope="scope">
            <el-button type="danger" @click="handleDeleteTenantInfo(scope.row)" size="small">删 除</el-button>
            <el-button type="primary" @click="handleEditTenantInfo(scope.row)" size="small">编 辑</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="openTenantInfo = false">取 消</el-button>
        <el-button type="primary" @click="handleSaveTenantInfo">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
  import {getHouse} from "../../api/tenant/house";
  import {getDicts} from "../../api/system/dict/data";
  import TenantNavbar from "./tenantNavbar";

  export default {
    data() {
      const vm = this;
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
      return {
        infrastructureOptions: [],
        house: {
          imageUrl: '',
          infrastructure: '',
          disableDates: [],
          services: [],
          houseComments: [],
          serviceComments: []
        },
        num: 1,
        date: null,
        activeName: 'first',
        openService: false,
        order: {
          orderItems: []
        },
        pickerOptions: {
          disabledDate(time) {
            // 禁选今天之前以及禁选日期列表内的日期
            const today = new Date();
            today.setHours(0, 0, 0, 0)
            return time < today || (vm.house.disableDates && vm.house.disableDates.includes(vm.formatDate(time)));
          }
        },
        openTenantInfo: false,
        tenantInfos: [],
        form: {},
        rules: {
          name: [
            {required: true, message: "姓名不能为空", trigger: "blur"}
          ],
          idcard: [
            {required: true, trigger: "blur", message: "身份证号不能为空"},
            {required: true, validator: validateIdCard, trigger: "blur"}
          ],
        },
      }
    },
    components: {TenantNavbar},
    created() {
      this.getHouseInfo();
      this.getInfrastructureList();
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
      getHouseInfo() {
        getHouse(this.$route.query.houseId).then(response => {
          this.house = response.data
          for (const service of this.house.services) {
            this.$set(service, 'num', 0)
            this.$set(service, 'total', 0)
          }
          for (const houseComment of this.house.houseComments) {
            if (!houseComment.avatar) {
              houseComment.avatar = require("@/assets/images/profile.jpg");
            }
          }
          for (const serviceComment of this.house.serviceComments) {
            if (!serviceComment.avatar) {
              serviceComment.avatar = require("@/assets/images/profile.jpg");
            }
          }
        })
      },
      /** 查询基础设施列表 */
      getInfrastructureList() {
        getDicts("house_infrastructure").then(response => {
          this.infrastructureOptions = response.data;
        });
      },
      handleClickTab(tab, event) {
        this.activeName = tab.name;
      },
      handleServiceNum(row) {
        row.total = row.price * row.num;
      },
      handleAddTenantInfo() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.id) {
              //编辑
              let filterElement = this.tenantInfos.filter(item => item.id === this.form.id)[0];
              filterElement.name = this.form.name
              filterElement.idcard = this.form.idcard
            } else {
              //新增
              this.tenantInfos.push({
                id: Date.now(),
                name: this.form.name,
                idcard: this.form.idcard
              })
            }
            this.form = {
              id: null,
              name: null,
              idcard: null
            }
          }
        })
      },
      handleEditTenantInfo(row) {
        this.form = {
          id: row.id,
          name: row.name,
          idcard: row.idcard
        }
      },
      handleDeleteTenantInfo(row) {
        this.tenantInfos = this.tenantInfos.filter(item => item.id !== row.id)
      },
      handleSaveTenantInfo() {
        if (this.tenantInfos.length !== this.num) {
          this.$message({
            type: 'error',
            message: '入住人信息个数与入住人数不符！'
          });
          return;
        }
        //房客信息存到订单里
        this.order.tenantInfo = JSON.stringify(this.tenantInfos)
        this.openTenantInfo = false;
      },
      handleSaveService() {
        let filter = this.house.services.filter(item => item.num > 0);
        let orderItemList = [];
        for (const service of filter) {
          orderItemList.push({
            name: service.name,
            type: 2,
            productId: service.serviceId,
            num: service.num,
            price: service.price,
            total: service.total
          })
        }
        this.order.orderItems = orderItemList;
        this.openService = false;
      },
      handleSubmitOrder() {
        if (this.tenantInfos.length !== this.num) {
          this.$message({
            type: 'error',
            message: '入住人信息个数与入住人数不符！'
          });
          return
        }
        if (!this.date) {
          this.$message({
            type: 'error',
            message: '未选择入住时间！'
          });
          return
        }
        this.order.houseId = this.house.houseId;
        this.order.landlordUserId = this.house.userId
        this.order.userId = this.$store.getters.userId;
        this.order.arrivalDate = this.date[0];
        this.order.departureDate = this.date[1];
        this.order.orderItems = this.order.orderItems ? this.order.orderItems : []
        //计算住的天数
        let days = Math.ceil((this.date[1].getTime() - this.date[0].getTime()) / (1000 * 3600 * 24));
        this.order.orderItems.push({
          type: 1,
          productId: this.house.houseId,
          name: this.house.name,
          num: days,
          price: this.house.price,
          total: this.house.price * days
        })
        this.order.price = this.order.orderItems.reduce((total, obj) => total + obj.total, 0);
        this.$router.push({path: '/order', query: {order: JSON.stringify(this.order)}});
      }
    },
  }
</script>

<style lang="scss">
  .detail-wrap {
    .el-table__header th div.cell {
      text-align: center;
    }

    .el-table__body-wrapper .cell {
      text-align: center;
    }

    .detail-content {
      margin: 50px 170px;

      .house-name {
        font-weight: 400;
        font-size: 20px;
      }

      .house-info-row-wrap {
        margin-bottom: 20px;

        .house-price {
          font-size: 36px;
          color: #0086f6;
        }

        .house-price-unit {
          font-size: 16px;
          color: #0086f6;
          margin-left: 10px;
        }

        .house-info-label {
          color: #888888;
          font-size: 14px;
          margin-right: 20px;
        }

        .house-info-value {
          color: #333333;
          font-size: 14px;
        }
      }

      .order-buttom {
        height: 50px;
        width: 100%;
      }

      .el-tabs__item {
        font-size: 16px;
      }

      .detail-label {
        color: #333333;
        font-size: 16px;
        margin: 20px 0;
        font-weight: bold;
      }

      .tab-pane-wrap {
        margin-bottom: 100px;
      }

      .service-wrap {
        .service-name {
          color: #333333;
          font-size: 16px;
          margin: 20px 0;
          font-weight: bold;
        }

        .service-description {
          color: #555555;
          font-size: 14px;
          padding: 0 10px;
          line-height: 25px
        }
      }

      .comment-wrap {
        padding: 20px 20px;
        border-bottom: 1px solid #dfe4ed;
        color: #333333;
        font-size: 14px;

        .comment-username {
          margin-bottom: 5px;
          margin-left: 3px;
        }

        .comment-service-name, .comment-time {
          color: #C6D1DE;
          margin: 5px 0 5px 3px;
        }

        .comment-content {
          margin-left: 3px;
          padding: 5px 0;
        }
      }

    }
  }

</style>
