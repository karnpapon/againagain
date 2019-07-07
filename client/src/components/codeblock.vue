<template>
  <div class="sourcescode" @click="stateMonitoring">
    <div @click="toggleRun(dataDetails.def)" class="exerpt-wrapper">
      <pre>
        <!-- <MyCanvas v-if="isCodeExecuted" style="width: 100%; height: 600px;">
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
          </MyCanvas> -->
        <code>{{ dataDetails.exerpt}}</code>
      </pre>
    </div>
  </div>
</template>

<script>
import io from "socket.io-client";

// import Tone from "tone";

const socket = io();
import MyCanvas from "./canvas.vue";
import MyDrawer from "./drawer.vue";

export default {
  name: "Codeblock",
  data() {
    return {
      meter: null,
      waveform: null,
      isCodeExecuted: false,
      def: "",
      b: "",
      chartValues: [
        { val: 24, color: "red" },
        { val: 32, color: "#0f0" },
        { val: 66, color: "rebeccapurple" }
      ]
    };
  },
  mounted() {
    this.def = this.dataDetails.def;
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
  props: {
    dataDetails: Object
  },
  computed: {},
  methods: {
    stateMonitoring(event) {
      this.$emit("clicked", this.isCodeExecuted, this.dataDetails.def);
    },
    toggleRun(def) {
      this.isCodeExecuted = !this.isCodeExecuted;
      if (this.isCodeExecuted) {
        this.send("playPattern", def);
      } else {
        this.send("stopPattern", def);
      }
    },
    send(eventType, def) {
      socket.emit(eventType, def);
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
  background-color: white;
  color: black;
  :active {
    color: black;
  }
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
