<template>
  <div class="container">
    <div class="headline-section">
      <div class="title-wrapper">
        <div class="headline-wrapper">
          <div class="headline">
            <a target="blank" href="https://www.youtube.com/user/CadsonDemak">Again again (2019)</a>
          </div>
          <div class="breakline"/>
          <h1>TBC's Interpretation.</h1>
        </div>
        <p class="lead">
          <a target="blank" href="https://cadsondemak.com/home/">Cadson Demak</a> &
          <a target="blank" href="https://www.theblack.codes">The ███████ </a>
        </p>
      </div>
    </div>
    <canvas id="myCanvas" class="cv"></canvas>
    <div id="actx" class="scroll-area" @click="setMarchingPlay">
      <div class="codeblock-wrapper">
        <div
          class="codeblock"
          v-for="(item, index) of codes"
          :class="{'active':childList.some( chld => chld.isCodeQueued && item.def === chld.def)}"
          :key="index"
        >
          <Codeblock ref="child" :dataDetails="item" />
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
import Tone from "tone";
// import Audio from "../assets/scripts/audiocontext"
// import StartAudioContext from "startaudiocontext";

export default {
  name: "Index",
  data() {
    return {
      codes: [],
      b: "",
      SDF: null,
      isMarchingPlaying: false,
      isMarching: false,
      targetCodeBlock: "",
      childList: [],
      audioSource: null
    };
  },
  created() {
    this.codes = exerpedData;
    Tone.Transport.start();
    this.audioSource = new Tone.Meter
    this.SDF = window.Marching;

  },
  mounted() {
    this.SDF.init(document.querySelector("canvas"));
    this.SDF.export(window);
    this.childList = this.$refs.child;

  },
  computed: {
    marching() {
      // prevent re-triggered marching.
      if (this.isMarchingPlaying && !this.isMarching) {
        this.playMarching();
        this.isMarching = true;
      } else if (!this.isMarchingPlaying) {
        this.stopMarching();
        this.isMarching = false;
      }
    },

  },
  methods: {
    playMarching() {
      let sphere, repeat, rot;
      let mat1 = this.SDF.Material("phong", Vec3(0.5), Vec3(1), Vec3(0.5));
      let s = this.SDF.march(
        (rot = this.SDF.Rotation(
          this.SDF.StairsIntersection(
            this.SDF.Difference(
              this.SDF.Box(Vec3(1.5,1.5,1.5),null,mat1), this.SDF.Sphere( 1, null, mat1 )
            ),
            (repeat = this.SDF.Repeat(
              (sphere = this.SDF.Triangle(null,null,null,null,mat1)),
              Vec3(0.25)
            )),
            0.125
          ),
          Vec3(1)
        ))
      )
        // .light(this.SDF.Light(Vec3(0.5, 1, 0.24), Vec3(1), 1))
        .render(2.5, true);
      this.SDF.FFT.start();
      // console.log("this.this.audioSource", this.audioSource)
      // // Audio.start(this.audioSource)
      window.onframe = time => {
        rot.angle = (time) / 2;
        // repeat.distance.x = this.SDF.FFT.low;
        repeat.distance.y = this.SDF.FFT.mid;
        repeat.distance.z = this.SDF.FFT.high;
        sphere.radius = this.SDF.FFT.mid * this.SDF.FFT.high;
      };
    },
    stopMarching() {
      this.SDF.clear();
    },
    setMarchingPlay() {
      if (this.childList.some(child => child.isCodeExecuted)) {
        this.isMarchingPlaying = true;
      } else {
        this.isMarchingPlaying = false;
      }
      this.marching;
    },
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
  justify-content: center;
  align-items: center;
  padding: 20px;
}
h3 {
  text-align: center;
}

.headline-section {
  z-index: 5;
  width: 100%;
  margin-bottom: auto;
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
  height: calc(100% - 180px);
}

.headline {
  color: white;
  font-weight: lighter;
  border-bottom: 2px solid;

  a{ text-decoration: none; font-size: 2rem;}

  :hover {
    color: $main-colorize-color !important;
    border-bottom: 2px solid $main-colorize-color !important;

  }

  :visited {
    color: white;
  }
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
  font-weight: bold;
  a {text-decoration: none; color: white;}

  :hover {
    color: $main-colorize-color !important;
  }

  :visited {
    color: white;
  }

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
    background-color: black;
    color: white;
  }
}

.active {
  box-shadow: inset 0px 0px 0px 1px rgb(255, 255, 255);
}

@keyframes blink {
  0% {
    background-color: #000000;
    color: white;
  }
  50% {
    background-color: rgb(255, 255, 255);
    color: black;
  }
  100% {
    background-color: #000000;
    color: white;
  }
}

.queue{
  transition:all 0.5s ease-in-out;
  animation:blink normal 0.5s infinite ease-in-out;
}

.scroll-area {
  /* overflow: hidden; */
  margin-bottom: 30px;
  z-index: 4;
}
</style>
