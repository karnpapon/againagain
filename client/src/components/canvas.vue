<template>
  <div class="my-canvas-wrapper">
    <canvas ref="my-canvas"></canvas>
    <slot></slot>
  </div>
</template>

<script>


export default {
  data() {
    return {
      provider: {
        context: null,
        meter: null,
        waveform: null
      }
    };
  },

  create(){
  
  },

  // Allows any child component to `inject: ['provider']` and have access to it.
  provide() {
    return {
      provider: this.provider
    };
  },

  mounted() {
    this.provider.context = this.$refs["my-canvas"].getContext("2d");
    this.$refs["my-canvas"].width = this.$refs[
      "my-canvas"
    ].parentElement.clientWidth;
    this.$refs["my-canvas"].height = this.$refs[
      "my-canvas"
    ].parentElement.clientHeight;

  }
};
</script>

<style lang="scss"  scoped>
@import "../assets/styles/_base.scss";
@import "../assets/styles/_fonts.scss";

.my-canvas-wrapper {
  float: right;
  position: absolute;
  width: calc(30vw - 40px) !important;
  height: 10rem !important;
  pointer-events: none;
  opacity: 0.85;
}

canvas {
  width: inherit;
  height: inherit;
}
</style>