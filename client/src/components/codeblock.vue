<template>
  <div class="sourcescode">
    <div @mousedown="handleOn" @mouseup="handleOff" @click="runCode" class="exerpt-wrapper">
      <pre :class="{'run' :isCodeExecuted}">
      <MyCanvas v-if="isCodeExecuted" style="width: 100%; height: 600px;">
        <MyDrawer
  v-for="( obj, index ) of chartValues"
  :x1="((index / chartValues.length) * 100)"
  :x2="((index / chartValues.length) * 100) + (100 / chartValues.length)"
  :y1="100"
  :y2="100 - obj.val"
  :color="obj.color"
  :value="obj.val"
  :key="index"
></MyDrawer>
        </MyCanvas>
        <code>play{l=LocalIn.ar(8);o={|i|Pulse.ar(l[i]*16+95,0.9.rand)}!8;LocalOut.ar(o.reverse.tanh);w=BLowShelf.ar(_,47,1,_);p=BPeakEQ.ar(_,285,1,_);h=BHiShelf.ar(_,190,1,_);o=Splay.ar(o);o=h.(w.(p.(o,48),-48),-48);o=GVerb.ar(tanh(o)).flop.mean;LeakDC.ar(Limiter.ar(h.(w.(p.(o,-48),48),48)))} play{l=LocalIn.ar(8);o={|i|Pulse.ar(l[i]*16+95,0.9.rand)}!8;LocalOut.ar(o.reverse.tanh);w=BLowShelf.ar(_,47,1,_);p=BPeakEQ.ar(_,285,1,_);h=BHiShelf.ar(_,190,1,_);o=Splay.ar(o);o=h.(w.(p.(o,48),-48),-48);o=GVerb.ar(tanh(o)).flop.mean;LeakDC.ar(Limiter.ar(h.(w.(p.(o,-48),48),48)))}</code>
      </pre>
    </div>
  </div>
</template>

<script>
// import io from "socket.io-client";

// const socket = io();
import MyCanvas from "./canvas.vue";
import MyDrawer from "./drawer.vue";

export default {
  name: "Codeblock",
  data() {
    return {
      isCodeExecuted: false,
      b: "",
      chartValues: [
        { val: 24, color: "red" },
        { val: 32, color: "#0f0" },
        { val: 66, color: "rebeccapurple" },
        { val: 1, color: "green" },
        { val: 28, color: "blue" },
        { val: 60, color: "rgba(150, 100, 0, 0.2)" }
      ]
    };
  },
  mounted() {
    let dir = 1;
    let selectedVal = Math.floor(Math.random() * this.chartValues.length);

    setInterval(() => {
      if (Math.random() > 0.995) dir *= -1;
      if (Math.random() > 0.99)
        selectedVal = Math.floor(Math.random() * this.chartValues.length);

      this.chartValues[selectedVal].val = Math.min(
        Math.max(this.chartValues[selectedVal].val + dir * 0.5, 0),
        100
      );
    }, 16);
  },
  created() {},
  destroyed() {},
  components: {
    MyCanvas,
    MyDrawer
  },
  props: {},
  computed: {},
  methods: {
    runCode() {
      this.isCodeExecuted = !this.isCodeExecuted;
    },
    handleOn() {
      // this.isCodeExecuted = true;
      // this.send("noteOn", 5.0, 5.0);
    },
    handleOff() {
      // this.isCodeExecuted = false;
      // this.send("noteOff", 5.0, 5.0);
    },
    send(eventType, x, y) {
      // console.log(eventType, x, y);
      // socket.emit(eventType, {
      //   x: 0.5,
      //   y: 0.3
      // });
    }
  }
};
</script>

<style lang="scss"  scoped>
@import "../assets/styles/_base.scss";
@import "../assets/styles/_fonts.scss";

.code-snippet {
  /* background-color: #e7e7e7; */
  padding: 20px;
  p {
    font-family: $font-input-mono;
    color: white;
  }

  /* :hover {
    cursor: pointer;
    background: green;
    transition: 0.2s;
  } */
}

.run {
  background-color: $main-colorize-color;
}

.code-btn {
  margin-top: 20px;
}

.sourcescode {
  font-size: 14px;
  color: white;
  display: inline;
}

.exerpt-wrapper {
  width: auto;
}

code {
}
</style>
