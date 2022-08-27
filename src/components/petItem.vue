<template>
  <div>
    <el-row>
      <el-col
        :span="4"
        v-for="(item, index) in 4"
        :key="item"
        :offset="index > 0 ? 2 : 0"
      >
        <el-card :body-style="{ padding: '0px' }">
          <img :src="dogImg_list[index].img" class="image" />
          <div style="padding: 14px">
            <span><strong>breed:</strong> {{ pet_arr.data[index].breed }}</span
            ><br />
            <span><strong>age: </strong>{{ pet_arr.data[index].age }}</span
            ><br />
            <span
              ><strong>vet phone: </strong
              >{{ pet_arr.data[index].vetPhone }}</span
            ><br />
            <span><strong>phone: </strong>{{ pet_arr.data[index].phone }}</span
            ><br />
            <span
              ><strong>disease: </strong>{{ pet_arr.data[index].disease }}</span
            ><br />
            <span
              ><strong>vaccinated: </strong
              >{{ pet_arr.data[index].vaccinated }}</span
            ><br />
            <span
              ><strong>address: </strong>{{ pet_arr.data[index].address }}</span
            ><br />
            <span
              ><strong>desinsectization: </strong
              >{{ pet_arr.data[index].desinsectization }}</span
            ><br />
            <span
              ><strong>vaccine code: </strong
              >{{ pet_arr.data[index].VCcode }}</span
            ><br />
            <span
              ><strong>lost: </strong
              >{{ pet_arr.data[index].lost }}</span
            ><br />
            <span
              ><strong>adopted: </strong
              >{{ pet_arr.data[index].adopted }}</span
            ><br />
            <span
              ><strong>owner: </strong
              >{{ pet_arr.data[index].owner }}</span
            ><br />
            <br />
            <span
              ><div class="btn">
                <el-button type="primary" :disabled="pet_arr.data[index].alreadyAdopted" @click="adopt(index)">adopt</el-button>
                <el-button type="primary" @click="lost(index)">lost</el-button>
              </div>
              <div class="btn1">
                <el-button type="primary" @click="found()"
                  >found</el-button
                >
                <el-button type="primary" @click="receive(index)">receive</el-button>
              </div> </span
            ><br /><br />
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import axios from "axios";
import Web3 from "web3";

export default {
  data() {
    return {
      pet_arr: [],
      userId: "",
      dogImg_list: [
        { img: require("../assets/dog1.jpeg") },
        { img: require("../assets/dog2.jpeg") },
        { img: require("../assets/dog3.jpeg") },
        { img: require("../assets/dog4.jpeg") },
      ],
    };
  },
  methods: {
    async getData() {
      axios
        .get("../..//public/pets.json")
        .then((result) => {
          this.pet_arr = result;
          console.log(result);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    lost(index) {
      this.pet_arr.data[index].lost = "Yes"
      let web3 = new Web3(window.web3.currentProvider);
      let fromAddress = "0xf047D4100CB13B6De20B024b1D599dbA903D877e";
      // console.log(fromAddress);
      let amount = 1 * Math.pow(10, 18);

      let toAddress = "0x04d1A4c5D0936Da3108AfC391C7F20d6fBd09411";
      // console.log(toAddress)
      web3.eth.sendTransaction(
        {
          gas: 21000,
          gasPrice: 5000000000,
          from: fromAddress,
          to: toAddress,
          value: amount,
        },
        (err, result) => {
          console.log("转账Hash=", result);
        }
      );
    },
    receive(index) {
      this.pet_arr.data[index].lost = "No"
    },
    adopt(index) {
      let web3 = new Web3(window.web3.currentProvider);
      let fromAddress = "0xf047D4100CB13B6De20B024b1D599dbA903D877e";
      // console.log(fromAddress);
      let amount = 1 * Math.pow(10, 18);

      let toAddress = "0x04d1A4c5D0936Da3108AfC391C7F20d6fBd09411";
      // console.log(toAddress)
      web3.eth.sendTransaction(
        {
          gas: 21000,
          gasPrice: 5000000000,
          from: fromAddress,
          to: toAddress,
          value: amount,
        },
        (err, result) => {
          console.log("转账Hash=", result);
        }
      );
      this.pet_arr.data[index].adopted = "Yes"
      this.pet_arr.data[index].alreadyAdopted = true
      this.userId = sessionStorage.getItem('Id')
      console.log(this.userId)
      console.log(this.pet_arr.data[index].owner)
      this.pet_arr.data[index].owner = this.userId
    },
    find() {
      let web3 = new Web3(window.web3.currentProvider);
      let fromAddress = "0x04d1A4c5D0936Da3108AfC391C7F20d6fBd09411";
      console.log(fromAddress);
      let amount = 1 * Math.pow(10, 18);

      let toAddress = "0xf047D4100CB13B6De20B024b1D599dbA903D877e";
      // console.log(toAddress)
      web3.eth.sendTransaction(
        {
          gas: 21000,
          gasPrice: 5000000000,
          from: fromAddress,
          to: toAddress,
          value: amount,
        },
        (err, result) => {
          console.log("转账Hash=", result);
        }
      );
    }
  },
  created() {
    this.getData();
  },
};
</script>

<style>
.time {
  font-size: 13px;
  color: #999;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}

.image {
  width: 100%;
  display: block;
}
.image:hover {
  transform: scale(1.1, 1.1);
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both;
}
.btn {
  display: flex;
  justify-content: space-between;
}
.btn1 {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
}
</style>
