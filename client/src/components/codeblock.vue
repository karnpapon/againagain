<template>
  <div class="sourcescode" >
    <div @click="toggleRun(dataDetails.def)" class="exerpt-wrapper">
      <pre>
        <code>{{ dataDetails.exerpt}}</code>
      </pre>
    </div>
  </div>
</template>

<script>
// import io from "socket.io-client";

import Tone from "tone";

// const socket = io();
import MyCanvas from "./canvas.vue";
import MyDrawer from "./drawer.vue";
import Audio from "../assets/scripts/audiocontext"

export default {
  name: "Codeblock",
  data() {
    return {
      meter: null,
      waveform: null,
      isCodeExecuted: false,
      def: "",
      player: null,
      b: "",
      audioSource: null
    };
  },
  mounted() {
    this.def = this.dataDetails.def;
    
    this.player.toMaster();
    this.player.loop = true
    // 
    // this.audioMonitoring
  },
  created() {
    this.player = new Tone.Player(this.dataDetails.path)
    // window.audioPlayer = this.player
    // this.audioSource = new Tone.FFT(256)
  },
  destroyed() {},
  components: {
    MyCanvas,
    MyDrawer
  },
  props: {
    dataDetails: Object
  },
  computed: {
    audioMonitoring(){
      // this.$emit("clicked", this.player);
      if(this.player.state === 'started'){
        console.log("startedddd")
      }
    }
  },
  methods: {
    stateMonitoring(event) {
      // this.$emit("clicked", this.isCodeExecuted, this.dataDetails.def);
    },
    toggleRun(def) {
      this.isCodeExecuted = !this.isCodeExecuted;
      
      
      if (this.isCodeExecuted) {
      // this.player.buffer.fan(this.$parent.audioSource)
        this.player.start("@1m")
      } else {
        this.player.stop()
        // this.send("stopPattern", def);
      }
    },
    // send(eventType, def) {
      // socket.emit(eventType, def);
    // }
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
