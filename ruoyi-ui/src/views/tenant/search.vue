<template>
  <div>
    <tenant-navbar></tenant-navbar>
    <div class="tenant-content">
      <el-row type="flex" justify="center" style="margin: 10px 0">
        <div class="logo-wrap">
          <img :src="logo" class="search-logo"/>
          <span class="search-title">{{ title }}</span>
        </div>
        <div class="search-wrap">
          <el-input class="search" v-model="keyword" clearable @keyup.enter.native="search"
                    placeholder="请输入关键词"></el-input>
          <el-button type="primary" @click="search">搜索</el-button>
        </div>
      </el-row>
      <el-row type="flex" justify="center">
        <div class="condition-wrap">
          <el-row type="flex" class="condition-row">
            <span class="condition-label">
              基础设施
            </span>
            <el-checkbox-group v-model="infrastructure" @change="search">
              <el-checkbox v-for="(item, index) in infrastructureOptions" :key="index"
                           :label="item.dictCode.toString()">
                {{item.dictLabel}}
              </el-checkbox>
            </el-checkbox-group>
          </el-row>
          <el-row type="flex" class="condition-row">
            <span class="condition-label">
              入住人数
            </span>
            <el-input-number v-model="maxPerson" :min="1" :max="8" size="small" @change="search"></el-input-number>
          </el-row>
          <el-row type="flex" class="condition-row">
            <span class="condition-label">
              入住时间
            </span>
            <el-date-picker
              size="small"
              v-model="date"
              type="daterange"
              :picker-options="pickerOptions"
              range-separator="至"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              @change="search">
            </el-date-picker>
          </el-row>
          <el-row type="flex" class="condition-row">
            <span class="condition-label">
              房屋面积
            </span>
            <el-select v-model="area" placeholder="请选择" size="small" @change="search" clearable>
              <el-option
                v-for="item in areaOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-row>
          <el-row type="flex" class="condition-row">
            <span class="condition-label">
              价格排序
            </span>
            <el-select v-model="priceOrder" placeholder="请选择" size="small" clearable @change="search">
              <el-option
                key="asc"
                label="升序"
                value="asc">
              </el-option>
              <el-option
                key="desc"
                label="降序"
                value="desc">
              </el-option>
            </el-select>
          </el-row>
        </div>
      </el-row>
      <!--      <el-row type="flex" justify="center">-->
      <!--        <div style="width: 1200px;border-top: 3px solid #1890ff;margin-top: 30px">-->
      <!--        </div>-->
      <!--      </el-row>-->
      <el-row type="flex" justify="center" :gutter="24" style="margin:0 0 30px 0">
        <div class="house-list" v-if="total!==0">
          <el-col :span="8" v-for="item in houseList" style="margin: 30px 0">
            <div class="house-wrap" @click="handleClickHouse(item.houseId)">
              <div class="house-img-wrap">
                <el-image :src="item.imageUrl.split(',')[0]" class="house-img"></el-image>
              </div>
              <el-row>
                <div class="house-info">
                  <div class="house-info-row">
                    <span class="house-name">{{item.name}}</span>
                  </div>
                  <div class="house-info-row">
                    <span class="house-label">地址：</span>
                    <span class="house-address">{{item.address}}</span>
                  </div>
                  <div class="house-info-row">
                    <span class="house-label">面积：</span>
                    <span class="house-address">{{item.area}}㎡</span>
                  </div>
                  <div class="house-info-row">
                    <span class="house-label">基础设施：</span>
                    <el-tag type="primary"
                            v-for="tag in item.infrastructure.split(',')
                            .map(obj=>infrastructureOptions.filter(item=>item.dictCode.toString()===obj)[0])"
                            class="house-tag">
                      {{tag?tag.dictLabel:''}}
                    </el-tag>
                  </div>
                  <div class="house-info-row">
                    <span class="house-price">
                       <span class="house-price-unit">￥</span>
                       <span class="house-price-num"> {{item.price}}</span>
                    </span>
                  </div>
                </div>
              </el-row>
            </div>
          </el-col>
        </div>
        <el-empty :image-size="200" v-else></el-empty>
      </el-row>
      <el-row type="flex" justify="center" style="padding-bottom: 30px">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[30, 60, 90, 180]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
        </el-pagination>
      </el-row>
    </div>
  </div>
</template>

<script>
  import logoImg from '@/assets/logo/logo.png'
  import {listHouse} from "../../api/tenant/house";
  import {getDicts} from "../../api/system/dict/data";
  import TenantNavbar from "./tenantNavbar";

  export default {
    data() {
      return {
        title: process.env.VUE_APP_TITLE,
        logo: logoImg,
        keyword: '',
        infrastructure: [],
        maxPerson: 1,
        area: '',
        date: null,
        priceOrder: '',
        houseList: [],
        currentPage: 1,
        pageSize: 30,
        total: 0,
        infrastructureOptions: [],
        areaOptions: [{
          value: 0,
          label: "20㎡以下",
          minArea: null,
          maxArea: 20
        }, {
          value: 1,
          label: "20㎡~50㎡",
          minArea: 20,
          maxArea: 50
        }, {
          value: 2,
          label: "50㎡~100㎡",
          minArea: 50,
          maxArea: 100
        }, {
          value: 3,
          label: "100㎡以上",
          minArea: 100,
          maxArea: null
        }],
        pickerOptions: {
          disabledDate(time) {
            // 禁选今天之前以及禁选日期列表内的日期
            const today = new Date();
            today.setHours(0, 0, 0, 0)
            return time < today ;
          }
        },
      }
    },
    components: {TenantNavbar},
    created() {
      this.search();
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
      search() {
        let filter = this.areaOptions.filter(item => item.value === this.area)[0];
        let minArea, maxArea = null;
        if (filter) {
          minArea = filter.minArea
          maxArea = filter.maxArea
        }
        listHouse({
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          keyword: this.keyword,
          infrastructure: this.infrastructure.join(","),
          maxPerson: this.maxPerson,
          priceOrder: this.priceOrder,
          minArea: minArea,
          maxArea: maxArea,
          startDate: this.date && this.date.length === 2 ? this.formatDate(this.date[0]) : null,
          endDate: this.date && this.date.length === 2 ? this.formatDate(this.date[1]) : null
        }).then(response => {
          this.houseList = response.rows;
          this.total = response.total;
        });
      },
      handleSizeChange(pageSize) {
        this.pageSize = pageSize
        this.search();
      },
      handleCurrentChange(currentPage) {
        this.currentPage = currentPage;
        this.search();
      },
      /** 查询基础设施列表 */
      getInfrastructureList() {
        getDicts("house_infrastructure").then(response => {
          this.infrastructureOptions = response.data;
        });
      },
      handleClickHouse(houseId) {
        this.$router.push('/house?houseId=' + houseId);
      }
    }
  }
</script>

<style lang="scss">
  .tenant-content {
    width: 100%;

    .logo-wrap {
      display: flex;
      width: 270px;
      align-items: center;
      margin-right: 100px;

      .search-logo {
        width: 32px;
        height: 32px;
        vertical-align: middle;
        margin-right: 12px;
      }

      .search-title {
        font-size: 22px;
      }
    }

    .search-wrap {
      width: 620px;
      margin: 20px 0;
      border: 2px solid #1890ff;
      border-radius: 5px;
      display: flex;
      align-items: center;

      .search {
        height: 36px;
        width: 100%;

        .el-input__inner {
          border: none !important;
          box-shadow: none !important;
        }
      }
    }

    .condition-wrap {
      border: 1px solid #1890ff;
      width: 1200px;
      padding: 20px 50px;
      /*background: linear-gradient(to right, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0)), url('../../assets/images/login-background.jpg');*/
      background-size: cover; /* 设置背景图片的尺寸，cover 表示尽量填充整个 div */
      background-position: center; /* 设置背景图片的位置，居中显示 */
      background-repeat: no-repeat;
      border-radius: 12px;
      background-color: rgba(255, 255, 255, 0.2);

      .condition-row {
        display: flex;
        align-items: center;
        margin: 10px 0
      }

      .condition-label {
        margin-right: 30px;
        margin-bottom: 3px;
      }
    }

    .house-list {
      width: 1225px;

      .house-wrap:hover {
        box-shadow: 0px 4px 16px 1px rgba(0, 0, 0, 0.1);
        cursor: pointer;
      }

      .house-wrap {
        box-shadow: 0px 4px 16px 1px rgba(0, 0, 0, 0.06);
        border-radius: 12px 12px 12px 12px;

        .house-img-wrap {
          overflow: hidden;
          border-radius: 12px 12px 0 0;
          width: 384px;
          height: 250px;
        }

        .house-img:hover {
          width: 384px;
          height: 250px;
          transform: scale(1.2);
        }

        .house-img {
          width: 384px;
          height: 250px;
        }

        .house-info {
          padding: 20px;

          .house-info-row {
            display: block;
            margin-bottom: 10px;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
          }

          .house-label {
            margin-right: 10px;
            color: #666666;
          }

          .house-name {
            font-size: 18px;
            font-weight: 600;
            color: #333333;;
          }

          .house-address {
            margin-top: 10px;
          }

          .house-tag {
            margin-right: 10px;
          }

          .house-price {
            float: right;
            color: #0086f6;

            .house-price-unit {

            }

            .house-price-num {
              font-size: 22px;
            }
          }
        }
      }
    }
  }
</style>
