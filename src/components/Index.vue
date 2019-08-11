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
    <canvas id="myCanvas2" class="cv"></canvas>
    <canvas id="myCanvas" class="cv"></canvas>
    <div id="actx" class="scroll-area" @click="setMarchingPlay">
      <div class="codeblock-wrapper">
        <div
          class="codeblock"
          v-for="(item, index) of codes"
          :class="{'active':childList.some( chld => chld.isCodeExecuted && item.def === chld.def)}"
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
    // this.audioSource = new Tone.Analyser
   
  },
  mounted() {
    this.SDF = window.Marching;
    const canvas = document.querySelector("#myCanvas");
    // const ctx = canvas.getContext("2d");
    // console.log(ctx)

    // ctx.beginPath();
    // ctx.arc(0, 0, 30, 0, Math.PI * 2, true);
    // ctx.closePath()
    // ctx.clip();

    // var img=new Image();
    // img.onload=function(){
        // canvas.width=400;
        // canvas.height=300;
        // ctx.drawImage(img,0,0,img.width,img.height,0,0,400,300);
    // }
    // img.src="../assets/path/path.png";


    // ctx.drawImage(img, 0, 0);
    // ctx.globalCompositeOperation = 'source-in';
    // ctx.drawImage(YOUR_IMAGE, 0 , 0); 
    this.SDF.init(canvas);
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
              (sphere = this.SDF.Torus( Vec2(.05,.05),null)),
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
      // // Audio.start(this.audioSource) 
      window.onframe = time => {
        rot.angle = (time) / 4;
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
    background-color: #4f00ff;
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
