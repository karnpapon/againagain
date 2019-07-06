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
    <button @click="marchingClick">click</button>
    <canvas class="cv"></canvas>
    <div class="scroll-area">
      <div class="codeblock-wrapper">
        <div class="codeblock" v-for="(item, index) of codes" :key="index">
          <Codeblock :dataDetails="item"/>
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
      SDF: null
    };
  },
  created() {
    this.codes = exerpedData;

    // let scriptTag = document.createElement("script");
    // scriptTag.setAttribute("src", "../../node_modules/marching/dist/index.js");
    // document.head.appendChild(scriptTag);

    // console.log("Marching", Marching);
    // this.meter = new Tone.Meter(0.95);
    // this.waveform = new Tone.Waveform(256);
    // Tone.UserMedia.enumerateDevices().then(function(devices) {
    //   console.log("enum devices", devices);
    // });
  },
  methods: {
    marchingClick() {
      this.SDF.init(document.querySelector("canvas"));
      this.SDF.export(window);
      let sphere, repeat, rot;
      let s = this.SDF.march(
        (rot = this.SDF.Rotation(
          this.SDF.StairsIntersection(
            this.SDF.Sphere(2, null, this.SDF.Material.white),
            (repeat = this.SDF.Repeat(
              (sphere = this.SDF.Sphere(0.125)),
              Vec3(0.25)
            )),
            0.125
          ),
          Vec3(1)
        ))
      ).render(4, true);

      this.SDF.FFT.start();

      window.onframe = time => {
        rot.angle = time / 4;
        repeat.distance.x = this.SDF.FFT.low;
        repeat.distance.y = this.SDF.FFT.mid;
        repeat.distance.z = this.SDF.FFT.high;
        sphere.radius = this.SDF.FFT.mid * this.SDF.FFT.high;
      };
    }
  },
  mounted() {
    this.SDF = window.Marching;
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
    background: $main-colorize-color;
    transition: 200ms ease-in-out;
  }

  :active {
    background-color: white;
  }
}

.scroll-area {
  /* overflow: hidden; */
  margin-bottom: 30px;
}
</style>
