<template>
  <div class="container">
    <div class="headline-section">
      <div class="title-wrapper">
        <div class="headline-wrapper">
          <h1 class="headline">Again again (2019)</h1>
          <div class="breakline"/>
          <h1>TBC's Interpretation.</h1>
        </div>
        <p class="lead">Cadson Demak & The ███████</p>
      </div>
    </div>
    <canvas class="cv"></canvas>
    <div class="scroll-area" @click="setMarchingPlay">
      <div class="codeblock-wrapper">
        <div
          class="codeblock"
          v-for="(item, index) of codes"
          :class="{'active':childList.some( chld => chld.isCodeExecuted && item.def === chld.def)}"
          :key="index"
        >
          <Codeblock ref="child" :dataDetails="item" @clicked="codeBlockState"/>
        </div>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Codeblock from "./codeblock";
import Footer from "./footer";
import { exerpedData } from "../data/exerpted";
import Marching from "../../node_modules/marching/dist/index.js";
// import Tone from "tone";

export default {
  name: "Index",
  data() {
    return {
      codes: [],
      b: "",
      SDF: null,
      isMarchingPlaying: false,
      targetCodeBlock: "",
      childList: []
    };
  },
  created() {
    this.codes = exerpedData;

    // this.meter = new Tone.Meter(0.95);
    // this.waveform = new Tone.Waveform(256);
    // Tone.UserMedia.enumerateDevices().then(function(devices) {
    //   console.log("enum devices", devices);
    // });
  },
  computed: {
    marching() {
      if (this.isMarchingPlaying) {
        this.playMarching();
      } else {
        this.stopMarching();
      }
    }
  },
  methods: {
    codeBlockState(value, target) {
      this.targetCodeBlock = {
        status: value,
        def: target
      };
    },
    playMarching() {
      let sphere, repeat, rot;
      let mat1 = this.SDF.Material("phong", Vec3(0.05), Vec3(1), Vec3(0.5));
      let s = this.SDF.march(
        (rot = this.SDF.Rotation(
          this.SDF.StairsIntersection(
            this.SDF.Sphere(2, null, mat1),
            (repeat = this.SDF.Repeat(
              (sphere = this.SDF.Sphere(0.125)),
              Vec3(0.25)
            )),
            0.125
          ),
          Vec3(1)
        ))
      )
        // .light(this.SDF.Light(Vec3(0, 1, 0), Vec3(0.25, 0.25, 0.5), 0.5))
        .render(4, true);
      this.SDF.FFT.start();
      window.onframe = time => {
        rot.angle = time / 4;
        repeat.distance.x = this.SDF.FFT.low;
        repeat.distance.y = this.SDF.FFT.mid;
        repeat.distance.z = this.SDF.FFT.high;
        sphere.radius = this.SDF.FFT.mid * this.SDF.FFT.high;
      };
    },
    stopMarching() {
      this.SDF.clear();
    },
    setMarchingPlay() {
      // if (this.$children.some(child => child.isCodeExecuted)) {
      //   this.isMarchingPlaying = true;
      // } else {
      //   this.isMarchingPlaying = false;
      // }
      // this.marching;
    }
  },
  mounted() {
    this.SDF = window.Marching;
    this.SDF.init(document.querySelector("canvas"));
    this.SDF.export(window);
    this.childList = this.$refs.child;
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
  align-items: center;
  padding: 20px;
}
h3 {
  text-align: center;
}

.headline-section {
  z-index: 5;
  width: 100%;
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

.cv {
  position: absolute;
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
    background: white;
    color: black;
    transition: 200ms ease-in-out;
  }

  :active {
    background-color: $main-colorize-color;
  }
}

.active {
  box-shadow: inset 0px 0px 0px 1px rgb(255, 255, 255);
}

.scroll-area {
  /* overflow: hidden; */
  margin-bottom: 30px;
  z-index: 4;
}
</style>
