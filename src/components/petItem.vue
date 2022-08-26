<template>
  <div>
    <el-row>
      <el-col
        :span="4"
        v-for="(o, index) in 4"
        :key="o"
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
            ><br /><br />
            <span
              ><div>
                <el-button type="primary">adopt</el-button
                ><el-button type="primary">lost</el-button>
                <el-button type="primary">receive</el-button>
              </div></span
            ><br /><br />
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import axios from 'axios'
// import Web3 from 'web3'

export default {
  data() {
    return {
        pet_arr:[],
        dogImg_list:[
            {img: require('../assets/dog1.jpeg')},
            {img: require('../assets/dog2.jpeg')},
            {img: require('../assets/dog3.jpeg')},
            {img: require('../assets/dog4.jpeg')}
        ],
    };
  },
  methods: {
    async getData() {
        axios.get('../..//public/pets.json')
        .then(result => {
            this.pet_arr = result
            console.log(result)
        })
        .catch(error => {
            console.log(error)
        })
    }
    // checkWeb3() {
    //   var Web3 = require('web3');
    //   if (typeof web3 !== 'undefined') { 
    //       console.debug(web3.currentProvider);
    //       web3 = new Web3(web3.currentProvider);
    //   } else {
    //       alert("No currentProvider for web3");
    //   }
    // }
  },
  created () {
    this.getData()
  }
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
</style>
