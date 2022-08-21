<template>
  <el-carousel :interval="4000" type="card" height="200px">
    <el-carousel-item v-for="(item, index) in bg_img" :key="index">
      <img :src="item.img" alt = "">
    </el-carousel-item>
  </el-carousel>
</template>

<script>
export default {
  data() {
    return {
        bg_img:[
          {img: require('../assets/logo1.jpg')},
          {img: require('../assets/logo.jpg')},
          {img: require('../assets/logo2.webp')},
        ]
    };
  },
  methods: {

  },
};
</script>

<style>
  .el-carousel__item h3 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 200px;
    margin: 0;
  }
  
  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }
  
  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
  img{
    height: 100%;
    width: 100%;
  }
</style>