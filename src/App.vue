<template>
  <div class="header">
    <div class="menu">
      <NavMenu></NavMenu>
    </div>
    <div class="carousel">
      <CarouselM></CarouselM>
      <div>
        <div class="item"><PetItem></PetItem></div>
        <div class="item"><PetItem></PetItem></div>
      </div>
    </div>
  </div>
</template>

<script>
import NavMenu from './components/navMenu.vue'
import CarouselM from './components/carouselM.vue'
import PetItem from './components/petItem.vue'

export default {
  name: 'App',
  components: {
    NavMenu,
    CarouselM,
    PetItem
  }
}
</script>

<style scoped>
  .header{
    width: 100%;
  }
  .menu{
    display: inline-block;
    width: 15%;
  }
  .carousel{
    display: inline-block;
    width: 85%;
  }
  .item{
    margin-bottom: 40px;
  }
</style>
