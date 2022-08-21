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
            <span>name: {{pet_arr.data[index].name}}</span><br />
            <span>breed: {{pet_arr.data[index].breed}}</span><br />
            <span>age: {{pet_arr.data[index].age}}</span><br />
            <span>vaccinated: {{pet_arr.data[index].vaccinated}}</span><br />
            <span>address: {{pet_arr.data[index].location}}</span><br />
            <span>health: {{pet_arr.data[index].health}}</span><br />
            <span>lost: {{pet_arr.data[index].lost}}</span><br /><br />
            <span
              ><div>
                <el-button style="float: left" type="primary">adopt</el-button
                ><el-button style="float: right" type="primary">find</el-button>
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
export default {
  data() {
    return {
        pet_arr:[],
        dogImg_list:[
            {img: require('../assets/dog1.jpeg')},
            {img: require('../assets/dog2.jpeg')},
            {img: require('../assets/dog3.jpeg')},
            {img: require('../assets/dog4.jpeg')}
        ]
    };
  },
  methods: {
    async getData() {
        axios.get('../..//public/pets.json')
        .then(result => {
            this.pet_arr = result
            console.log(this.pet_arr.data[0].name)
        })
        .catch(error => {
            console.log(error)
        })
    }
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
.image:hover{
    transform: scale(1.1,1.1);
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
