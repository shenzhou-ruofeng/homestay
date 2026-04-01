<template>
  <div class="contract_wrap">
    <h3 style="text-align: center;font-weight: bold">民宿出租及特色服务协议</h3>
    <div>
      <div>
        <span>甲方（平台）：</span><span class="value_wrap">{{data.platformName}}</span><br>
        <span>地址：</span><span class="value_wrap">{{data.platformAddress}}</span><br>
        <span>法定代表人：</span><span class="value_wrap">{{data.platformLegalName}}</span><br>
        <span>电话：</span><span class="value_wrap">{{data.platformPhone}}</span>
      </div>
      <br>
      <div>
        <span>乙方（房东）：</span><span class="value_wrap">{{data.landlordName}}</span><br>
        <span>地址：</span><span class="value_wrap">{{data.landlordAddress}}</span><br>
        <span>身份证号：</span><span class="value_wrap">{{data.landlordIdcard}}</span><br>
        <span>电话：</span><span class="value_wrap">{{data.landlordPhone}}</span>
      </div>
      <br>
      <div>
        <span>鉴于甲方经营民宿在线预订平台，乙方有出租房屋意愿，双方经友好协商，达成如下合作意向，并同意遵守以下条款：</span>
      </div>
      <br>
      <div>
        <span class="index">一、房源信息</span><br>
        <span>1.1 乙方向甲方提供的房屋信息如下：</span><br>
        <span>房屋地址：</span><span class="value_wrap">{{data.houseAddress}}</span><br>
        <span>1.2 乙方保证所提供的房源信息真实有效，不存在虚假或误导性信息。</span>
      </div>
      <br>
      <div>
        <span class="index">二、服务内容及责任</span><br>
        <span>2.1 甲方负责在平台上发布乙方提供的房源信息，并提供相应的民宿预订服务。</span><br>
        <span>2.2 乙方保证所提供的房屋符合相关法律法规和安全标准，保证房屋设施设备正常运行，保证房屋卫生整洁。</span><br>
        <span>2.3 乙方如提供民宿特色服务，则负责按照预订要求提供相应服务。</span><br>
        <span>2.4 乙方保证所提供的房源信息和服务内容不侵犯任何第三方的合法权益，不存在知识产权纠纷或其他纠纷。</span>
      </div>
      <br>
      <div>
        <span class="index">三、费用结算</span><br>
        <span>3.1 甲方有权在合作期间对该房屋的每笔订单收取手续费，手续费比例在10%-30%之间。乙方可根据系统公告提示查看当前手续费比例。</span><br>
        <span>3.2 乙方同意按照甲方要求提供相关账单和结算信息，以便甲方进行服务费的结算。</span>
      </div>
      <br>
      <div>
        <span class="index">四、违约责任</span><br>
        <span>4.1 若任何一方违反本合同的约定，应承担相应的违约责任，并赔偿对方因此造成的损失。</span><br>
        <span>4.2 若因不可抗力或其他不可预见的情形导致无法履行合同的一方，应及时通知对方并尽力减少损失，双方互相谅解。</span>
      </div>
      <br>
      <div>
        <span class="index">五、其他条款</span><br>
        <span>5.1 本合同自乙方提交合同信息，甲方审核房源信息真实有效后，通过起生效。</span>
      </div>
      <br>
      <div>
        <span>乙方（房东）提交合同日期：</span><span class="value_wrap">{{data.submitDate}}</span>
      </div>
      <br>
      <div>
        <span>甲方（平台）审核通过日期：</span><span class="value_wrap">{{data.signingDate}}</span>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "contractTemplate",
    props: {
      data: {
        type: Object,
        required: true
      }
    },
    created() {
      this.init();
    },
    methods: {
      init() {
        if (!this.data.submitDate) {
          const d = new Date();
          const year = d.getFullYear();
          const month = ('0' + (d.getMonth() + 1)).slice(-2);
          const day = ('0' + d.getDate()).slice(-2);
          this.data.submitDate = year + '-' + month + '-' + day;
        }
      },
    }
  }
</script>

<style scoped>
  .contract_wrap {
    line-height: 2;
    margin: 0 20px;
  }

  .value_wrap {
    font-weight: bold;
    border-bottom: 1px solid #000000;
  }

  .index {
    font-weight: bold;
  }
</style>
