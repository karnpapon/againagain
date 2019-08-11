<template>
    <div class="page-not-found">
      <div class="display-text">
        <strong class="title">404: Page Not Found</strong>
        <p class="subtitle go-back-home" @click="handleClick"> go back.</p>
      </div>
    </div>
</template>

<script>

export default {
  name: 'PageNotFound',
  data(){
    return {

    }
  },
  mounted() {
  },
  created () {
  },
  destroyed () {
  },
  components: {
  },
  props: {

  },
  computed: {
  },
  methods: {
    handleClick(){
      this.$router.push({ path: '/'})
    }
  }
}
</script>

<style lang="scss"  scoped>
  .page-not-found{
    background-color: black;
    display: flex;
    height: 100vh;
    justify-content: center;
    align-items: center;
  }

  .go-back-home{
    font-weight: normal;
    border: 1px solid;
    &:hover{
      cursor: pointer;
      color: #c4c4c4;
    }
  }

  .display-text{
    display: flex;
    flex-direction: column;
    align-items: center;
    strong{ font-size: 2rem;}
    p{ font-size: 2rem; 
    padding: 10px;}

  }


</style>
