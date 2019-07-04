<template>
  <div class="container">
    <div class="row">
      <div class="title-wrapper">
        <div class="headline-wrapper">
          <h1 class="headline">Again again (2019)</h1>
          <div class="breakline"/>
          <h1>TBC's Interpretation.</h1>
        </div>
        <p class="lead">Cadson Demak & The ███████</p>
      </div>
    </div>
    <div class="scroll-area">
      <div class="codeblock-wrapper">
        <div class="codeblock" v-for="(block, index) of codes" :key="index">
          <Codeblock/>
          <!-- <button @click="textfx">baffling</button> -->
        </div>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Codeblock from "./codeblock";
import Footer from "./footer";
import baffle from "baffle";

export default {
  name: "Index",
  data() {
    return {
      codes: [1, 2, 3, 4, 5, 6],
      b: ""
    };
  },
  methods: {
    // textfx() {
    //   this.b.reveal(1000);
    // }
  },
  mounted() {
    // this.b = baffle("#baffle", {
    //   characters: " ░▒█▓█></"
    // });
  },
  components: {
    Codeblock,
    Footer
  }
};
</script>

<style scoped lang="scss">
@import "../assets/styles/_base.scss";
.container {
  background-color: black;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 20px;
}
h3 {
  text-align: center;
}

.title-wrapper {
  display: flex;
  flex-direction: column;
  margin-top: 20px;
  width: 100%;
  width: fit-content;
  /* align-items: center; */
  margin-left: 20px;
}

.headline {
  color: white;
  font-weight: lighter;
  border-bottom: 2px solid;
}

.headline-wrapper {
  display: flex;
  align-items: center;
}

.breakline {
  width: 100px;
  height: 2px;
  background: white;
  margin: 20px;
}

.lead {
  color: white;
  margin-top: unset;
}

.codeblock-wrapper {
  display: grid;
  justify-content: center;
  width: 100%;
  height: 400px;
  grid-template-columns: repeat(3, 30vw);
  column-gap: 5px;
  row-gap: 5px;
  overflow-y: scroll;
}

.codeblock {
  /* padding: 20px; */
  overflow: scroll;

  :hover {
    cursor: pointer;
    background: $main-colorize-color;
    transition: 150ms;
  }
}

.scroll-area {
  /* overflow: hidden; */
  margin-bottom: 30px;
}
</style>
