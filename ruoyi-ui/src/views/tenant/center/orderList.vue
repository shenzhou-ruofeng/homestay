<template>
  <div>
    <div v-if="orderList.length>0">
      <div class="order-wrap" v-for="item in orderList">
        <div class="house-info">
          <el-row>
            <el-col :span="3">
              <el-avatar shape="square" :size="100" :src="item.imageUrl"></el-avatar>
            </el-col>
            <el-col :span="21">
              <div class="info-row">{{item.name}}</div>
              <div class="info-row">下单时间：{{formatDate(new Date(item.createTime),2)}}</div>
              <div class="info-row">入住人数：{{JSON.parse(item.tenantInfo).length}}</div>
              <div class="info-row">入住时间：{{formatDate(new Date(item.arrivalDate),1)+" 至 "+formatDate(new
                Date(item.departureDate),1)}}
              </div>
              <div>总价：{{item.price}}</div>
            </el-col>
          </el-row>
        </div>
        <el-table
          :data="item.orderItems"
          style="width: 100%;margin-top: 10px">
          <el-table-column
            prop="type"
            label="类型"
            :formatter="formatType">
          </el-table-column>
          <el-table-column
            prop="name"
            label="名称">
          </el-table-column>
          <el-table-column
            prop="num"
            label="数量">
          </el-table-column>
          <el-table-column
            prop="price"
            label="单价">
          </el-table-column>
          <el-table-column
            prop="total"
            label="小计">
          </el-table-column>
          <el-table-column
            prop="status"
            label="状态"
            :formatter="formatStatus">
          </el-table-column>
          <el-table-column
            label="操作">
            <template slot-scope="scope">
              <el-button v-if="scope.row.status===0" type="primary" @click="handleRefund(scope.row,item)"
                         size="mini">退 款
              </el-button>
              <el-button v-if="scope.row.type===1&&scope.row.status===1" type="primary"
                         @click="handleViewPassword(scope.row)"
                         size="mini">门禁密码
              </el-button>
              <el-button v-if="scope.row.type===1&&(item.status===2||item.status===4)" type="primary"
                         @click="handleDeleteOrder(item)"
                         size="mini">删 除
              </el-button>
              <el-button v-if="scope.row.status===2" type="primary" @click="handleComment(scope.row,item)"
                         size="mini">去评价
              </el-button>
              <el-button v-if="scope.row.status===3" type="primary" @click="handleComment(scope.row,item)"
                         size="mini">评 价
              </el-button>
              <el-button
                v-if="(scope.row.type===2&&item.status!==3&&scope.row.status===4)||(scope.row.type===1&&item.status===3)"
                type="primary"
                @click="handleCancelRefund(scope.row)"
                size="mini">取消退款
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <el-row type="flex" justify="center" style="padding-bottom: 30px">
        <el-pagination
          :current-page="currentPage"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total">
        </el-pagination>
      </el-row>
    </div>
    <el-empty :image-size="200" v-else></el-empty>

    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="50px">
        <el-form-item label="评分" prop="score">
          <el-rate v-model="form.score" style="margin-top: 9px"></el-rate>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input type="textarea" v-model="form.content" placeholder="请输入评论内容"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel">取 消</el-button>
        <el-button type="primary" @click="submitComment">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import {listOrder, updateOrder, updateOrderItem} from "../../../api/tenant/order";
  import {addComment, getComment, updateComment} from "../../../api/tenant/comment";

  export default {
    name: "orderList",
    props: {
      status: {
        type: Array,
        default: null
      }
    },
    data() {
      const validateScore = (rule, value, callback) => {
        if (!value || value === 0) {
          return callback(new Error('评分不能为空'));
        }
        callback();
      };
      return {
        total: 0,
        currentPage: 1,
        pageSize: 5,
        orderList: [],
        open: false,
        title: '',
        form: {},
        rules: {
          score: [
            {required: true, message: "评分不能为空", trigger: "blur"},
            {required: true, validator: validateScore, trigger: "blur"}
          ],
          content: [
            {required: true, message: "评价不能为空", trigger: "blur"}
          ],
        }
      }
    },
    created() {
      this.getList();
    },
    methods: {
      formatStatus(row) {
        if (row.status === 0) {
          return "待使用"
        } else if (row.status === 1) {
          return "消费中"
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
      formatType(row) {
        return row.type === 1 ? '民宿' : '特色服务'
      },
      // 格式化日期格式如：2017-9-19
      formatDate(value, type) {
        // 计算日期相关值
        let time = typeof value == 'number' ? new Date(value) : value;
        let Y = time.getFullYear();
        let M = time.getMonth() + 1;
        let D = time.getDate();
        let h = time.getHours();
        let m = time.getMinutes();
        let s = time.getSeconds();
        let week = time.getDay();
        // 如果传递了type的话
        if (type === 1) {
          return Y + '-' + (M < 10 ? '0' + M : M) + '-' + (D < 10 ? '0' + D : D);
        } else if (type === 2) {
          return Y + '-' + (M < 10 ? '0' + M : M) + '-' + (D < 10 ? '0' + D : D) + ' ' + (h < 10 ? '0' + h : h) + ':' + (m < 10 ? '0' + m : m) + ':' + (s < 10 ? '0' + s : s);
        }
      },
      getList() {
        listOrder({
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          statusList: this.status
        }).then(response => {
          this.orderList = response.rows;
          this.total = response.total;
        });
      },
      handleRefund(row, order) {
        //判断是否在入住时间的14:00之前
        let today = new Date();
        let date = new Date(order.arrivalDate);
        date.setHours(14, 0, 0, 0);
        if (today >= date) {
          this.$message({
            type: 'error',
            message: '退款失败，仅支持在入住时间14:00前退款，仍需退款请联系房东'
          });
          return
        }
        if (row.type === 1) {
          this.$confirm('房费退款，会对房屋配套的特色服务一同退款，是否继续？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            //修改订单
            updateOrder({orderId: row.orderId, status: 3}).then(response => {
              if (response.code === 200) {
                this.$message({
                  type: 'success',
                  message: '退款处理中'
                });
                this.getList();
              } else {
                this.$message({
                  type: 'error',
                  message: '退款失败，请重新发起'
                });
              }
            })
          }).catch(() => {
          });
        } else {
          this.$confirm('将退款' + row.total + '元，是否继续？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            //修改服务子订单
            updateOrderItem({orderItemId: row.orderItemId, status: 4}).then(response => {
              if (response.code === 200) {
                this.$message({
                  type: 'success',
                  message: '退款处理中'
                });
                this.getList();
              } else {
                this.$message({
                  type: 'error',
                  message: '退款失败，请重新发起'
                });
              }
            })
          }).catch(() => {
          });
        }
      },
      handleViewPassword(row) {
        this.$alert(row.password, '门禁密码', {
          confirmButtonText: '确定',
          callback: action => {
          }
        });
      },
      handleCancelRefund(row) {
        if (row.type === 1) {
          this.$confirm('是否取消房费及配套的特色服务费退款？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            //修改订单
            updateOrder({orderId: row.orderId, status: 0}).then(response => {
              if (response.code === 200) {
                this.$message({
                  type: 'success',
                  message: '取消退款成功'
                });
                this.getList();
              } else {
                this.$message({
                  type: 'error',
                  message: '取消退款失败，请重新发起'
                });
              }
            })
          }).catch(() => {
          });
        } else {
          this.$confirm('是否取消特色服务费退款？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            //修改服务子订单
            updateOrderItem({orderItemId: row.orderItemId, status: 0}).then(response => {
              if (response.code === 200) {
                this.$message({
                  type: 'success',
                  message: '取消退款成功'
                });
                this.getList();
              } else {
                this.$message({
                  type: 'error',
                  message: '取消退款失败，请重新发起'
                });
              }
            })
          }).catch(() => {
          });
        }
      },
      handleDeleteOrder(order) {
        this.$modal.confirm('是否确认删除订单？').then(function () {
          return delOrder(order.orderId);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {
        });
      },
      handleComment(row, order) {
        this.reset();
        if (row.status === 2) {
          //待评价
          this.form.orderItemId = row.orderItemId
          this.form.type = row.type;
          this.form.userId = this.$store.getters.userId
          this.form.houseId = order.houseId
          if (this.form.type === 2) {
            this.title = '评价特色服务'
            this.form.serviceId = row.productId
          } else {
            this.title = '评价民宿'
          }
          this.form.score = row.score
          this.form.content = row.content
          this.open = true;
        } else {
          //已完成状态
          getComment(row.orderItemId).then(response => {
            this.form = response.data;
            if (this.form.type === 2) {
              this.title = '评价特色服务'
            } else {
              this.title = '评价民宿'
            }
            this.open = true;
          });
        }
      },
      reset() {
        this.form = {
          orderItemId: null,
          type: null,
          userId: null,
          houseId: null,
          serviceId: null,
          score: null,
          content: null,
        };
        this.resetForm("form");
      },
      // 取消按钮
      cancel() {
        this.open = false;
        this.reset();
      },
      submitComment() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.commentId != null) {
              updateComment(this.form).then(response => {
                this.$modal.msgSuccess("修改评价成功");
                this.open = false;
                this.getList();
              });
            } else {
              addComment(this.form).then(response => {
                this.$modal.msgSuccess("评价成功");
                this.open = false;
                this.getList();
              });
            }
          }
        })
      }
    },
  }
</script>

<style scoped>

</style>
