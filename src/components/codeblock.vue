<template>
  <div class="sourcescode" >
    <div @click="toggleRun" class="exerpt-wrapper">
      <pre>
        <div class="inner-block">{{ dataDetails.exerpt}}</div>
      </pre>
    </div>
  </div>
</template>

<script>
import Tone from "tone";
// import Audio from "../assets/scripts/audiocontext"

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
      audioSource: null,
      comp: null,
      limiter: null,
      reverb: null
    };
  },
  mounted() {
    this.player.connect( this.comp)
    this.comp.connect(this.limiter)
    this.limiter.toMaster();
    this.player.loop = true
  },
  created() {
    Tone.start()
    this.def = this.dataDetails.def;
    // this.phaser = new Tone.PingPongDelay('4n', 0.2)
    this.comp = new Tone.Compressor(-35, 3);
    this.limiter = new Tone.Limiter(-2);
    this.player = new Tone.Player(this.dataDetails.path)

    
    // window.audioPlayer = this.player
    // this.audioSource = new Tone.FFT(256)
  },
  destroyed() {},
  components: {
  },
  props: {
    dataDetails: Object
  },
  computed: {
  },
  methods: {
    toggleRun() {
      this.isCodeExecuted = !this.isCodeExecuted;
      if (this.isCodeExecuted) {
        this.handlePlaying()
        this.player.start("@1m")
      } else {
        this.player.stop()
      }
    },
    getRandomInt(min, max) {
      let _min = Math.ceil(min);
      let _max = Math.floor(max);
      return Math.floor(Math.random() * (_max - _min + 1)) + _min;
    },
    handlePlaying(){
      if( this.def === "rhythms"){
        this.player.load(`./stem-for-web/stem-for-web_gkick0${this.getRandomInt(0,5)}.mp3`)
      } else if ( this.def === "bass"){
        this.player.load(`./stem-for-web/bass0${this.getRandomInt(0,1)}-16bit.wav`)
      } else {
        this.player.load(this.dataDetails.path)
      }
    }
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
  padding: 20px;
  p {
    font-family: $font-input-mono;
    color: white;
  }
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

.inner-block{
  pointer-events: none;
}

.exerpt-wrapper {
  width: auto;
}

</style>
