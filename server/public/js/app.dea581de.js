(function(t){function n(n){for(var r,i,u=n[0],o=n[1],c=n[2],l=0,f=[];l<u.length;l++)i=u[l],a[i]&&f.push(a[i][0]),a[i]=0;for(r in o)Object.prototype.hasOwnProperty.call(o,r)&&(t[r]=o[r]);d&&d(n);while(f.length)f.shift()();return s.push.apply(s,c||[]),e()}function e(){for(var t,n=0;n<s.length;n++){for(var e=s[n],r=!0,u=1;u<e.length;u++){var o=e[u];0!==a[o]&&(r=!1)}r&&(s.splice(n--,1),t=i(i.s=e[0]))}return t}var r={},a={app:0},s=[];function i(n){if(r[n])return r[n].exports;var e=r[n]={i:n,l:!1,exports:{}};return t[n].call(e.exports,e,e.exports,i),e.l=!0,e.exports}i.m=t,i.c=r,i.d=function(t,n,e){i.o(t,n)||Object.defineProperty(t,n,{enumerable:!0,get:e})},i.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},i.t=function(t,n){if(1&n&&(t=i(t)),8&n)return t;if(4&n&&"object"===typeof t&&t&&t.__esModule)return t;var e=Object.create(null);if(i.r(e),Object.defineProperty(e,"default",{enumerable:!0,value:t}),2&n&&"string"!=typeof t)for(var r in t)i.d(e,r,function(n){return t[n]}.bind(null,r));return e},i.n=function(t){var n=t&&t.__esModule?function(){return t["default"]}:function(){return t};return i.d(n,"a",n),n},i.o=function(t,n){return Object.prototype.hasOwnProperty.call(t,n)},i.p="/";var u=window["webpackJsonp"]=window["webpackJsonp"]||[],o=u.push.bind(u);u.push=n,u=u.slice();for(var c=0;c<u.length;c++)n(u[c]);var d=o;s.push([0,"chunk-vendors"]),e()})({0:function(t,n,e){t.exports=e("56d7")},"0d95":function(t,n,e){"use strict";var r=e("8276"),a=e.n(r);a.a},1:function(t,n){},"24ad":function(t,n,e){"use strict";var r=e("2c47"),a=e.n(r);a.a},"2c47":function(t,n,e){},"3fa7":function(t,n,e){"use strict";var r=e("478b"),a=e.n(r);a.a},"478b":function(t,n,e){},5238:function(t,n,e){},"56d7":function(t,n,e){"use strict";e.r(n);e("cadf"),e("551c"),e("097d");var r,a,s=e("2b0e"),i=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{attrs:{id:"app"}},[e("router-view")],1)},u=[],o=(e("5c0b"),e("2877")),c={},d=Object(o["a"])(c,i,u,!1,null,null,null),l=d.exports,f=e("8c4f"),h=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"container"},[t._m(0),e("canvas",{staticClass:"cv"}),e("div",{staticClass:"scroll-area",on:{click:t.setMarchingPlay}},[e("div",{staticClass:"codeblock-wrapper"},t._l(t.codes,function(n,r){return e("div",{key:r,staticClass:"codeblock",class:{active:t.childList.some(function(t){return t.isCodeExecuted&&n.def===t.def})}},[e("Codeblock",{ref:"child",refInFor:!0,attrs:{dataDetails:n},on:{clicked:t.codeBlockState}})],1)}),0)]),e("Footer")],1)},p=[function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"headline-section"},[e("div",{staticClass:"title-wrapper"},[e("div",{staticClass:"headline-wrapper"},[e("h1",{staticClass:"headline"},[t._v("Again again (2019)")]),e("div",{staticClass:"breakline"}),e("h1",[t._v("TBC's Interpretation.")])]),e("p",{staticClass:"lead"},[t._v("Cadson Demak & The ███████")])])])}],P=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"sourcescode",on:{click:t.stateMonitoring}},[e("div",{staticClass:"exerpt-wrapper",on:{click:function(n){return t.toggleRun(t.dataDetails.def)}}},[e("pre",[t._v("        "),t._v("\n        "),e("code",[t._v(t._s(t.dataDetails.exerpt))]),t._v("\n      ")])])])},m=[],b=e("4bea"),v=e.n(b),x=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"my-canvas-wrapper"},[e("canvas",{ref:"my-canvas"}),t._t("default")],2)},g=[],y={data:function(){return{provider:{context:null,meter:null,waveform:null}}},create:function(){},provide:function(){return{provider:this.provider}},mounted:function(){this.provider.context=this.$refs["my-canvas"].getContext("2d"),this.$refs["my-canvas"].width=this.$refs["my-canvas"].parentElement.clientWidth,this.$refs["my-canvas"].height=this.$refs["my-canvas"].parentElement.clientHeight}},w=y,k=(e("3fa7"),Object(o["a"])(w,x,g,!1,null,"9ef4d0fa",null)),q=k.exports,_=(e("6c7b"),e("c5f6"),function(t,n){return Math.floor(n.canvas.width/100*t)}),C=function(t,n){return Math.floor(n.canvas.height/100*t)},F={inject:["provider"],props:{x1:{type:Number,default:0},y1:{type:Number,default:0},x2:{type:Number,default:0},y2:{type:Number,default:0},value:{type:Number,defualt:0},color:{type:String,default:"#F00"}},data:function(){return{oldBox:{x:null,y:null,w:null,h:null}}},computed:{calculatedBox:function(){var t=this.provider.context,n={x:_(this.x1,t),y:C(this.y1,t),w:_(this.x2-this.x1,t),h:C(this.y2-this.y1,t)};return this.oldBox=n,n}},render:function(){if(this.provider.context){var t=this.provider.context,n=this.oldBox,e=this.calculatedBox;t.beginPath(),t.clearRect(n.x,n.y,n.w,n.h),t.clearRect(e.x,e.y-42,e.w,100),t.rect(e.x,e.y,e.w,e.h),t.fillStyle=this.color,t.fill()}}},M=F,S=Object(o["a"])(M,r,a,!1,null,null,null),D=S.exports,j=v()(),E={name:"Codeblock",data:function(){return{meter:null,waveform:null,isCodeExecuted:!1,def:"",b:"",chartValues:[{val:24,color:"red"},{val:32,color:"#0f0"},{val:66,color:"rebeccapurple"}]}},mounted:function(){var t=this;this.def=this.dataDetails.def;var n=1,e=Math.floor(Math.random()*this.chartValues.length);setInterval(function(){Math.random()>.995&&(n*=-1),Math.random()>.99&&(e=Math.floor(Math.random()*t.chartValues.length)),t.chartValues[e].val=Math.min(Math.max(t.chartValues[e].val+.5*n,0),100)},16)},created:function(){},destroyed:function(){},components:{MyCanvas:q,MyDrawer:D},props:{dataDetails:Object},computed:{},methods:{stateMonitoring:function(t){this.$emit("clicked",this.isCodeExecuted,this.dataDetails.def)},toggleRun:function(t){this.isCodeExecuted=!this.isCodeExecuted,this.isCodeExecuted?this.send("playPattern",t):this.send("stopPattern",t)},send:function(t,n){j.emit(t,n)}}},O=E,$=(e("0d95"),Object(o["a"])(O,P,m,!1,null,"40eb16c2",null)),T=$.exports,V=function(){var t=this,n=t.$createElement;t._self._c;return t._m(0)},B=[function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"footer-container"},[e("div",{staticClass:"wrapper"},[e("div",{staticClass:"details"},[t._v("\n      this project is integrating between\n      "),e("p",{staticClass:"underline"},[e("a",{attrs:{target:"blank",href:"https://crucialfelix.github.io/supercolliderjs/"}},[t._v("SuperCollider")])]),t._v("and\n      "),e("p",{staticClass:"underline"},[e("a",{attrs:{target:"blank",href:"https://vuejs.org/"}},[t._v("Vue.js")])]),t._v("and\n      "),e("p",{staticClass:"underline"},[e("a",{attrs:{target:"blank",href:"https://github.com/charlieroberts/marching"}},[t._v("marching.js")])])]),e("div",{staticClass:"credits"},[e("span",{staticClass:"icon"},[e("a",{attrs:{target:"blank",href:"https://github.com/karnpapon"}},[e("i",{staticClass:"fab fa-github"})])]),e("span",{staticClass:"icon"},[e("a",{attrs:{target:"blank",href:"https://github.com/karnpapon"}},[e("i",{staticClass:"fab fa-youtube"})])])])])])}],R={name:"Footer",data:function(){return{}},methods:{},components:{}},I=R,N=(e("24ad"),Object(o["a"])(I,V,B,!1,null,"0715f468",null)),L=N.exports,z=[{title:"exerpt-00",def:"main_kick",exerpt:"\n      Pbindef(\\main_kick,\n       \\instrument,\\kick,\n       \\dur, Pseq([Pseq([1,1,1,0.75],1),Pseq([1.25,1,1,0.75],inf)],inf),\n       \\freq, Pstutter(16,Pexprand(1000,20000,inf)),\n       \\detune, 0,\n       \\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),\n       \\atk, 0,\n       \\sus, 0,\n       \\rel, Pexprand(0.02,0.04),\n       \\c1, -4,\n       \\amp, 0.5,\n       \\pan, Pseq([1,-1],inf),\n       \\out, 0,\n       \\rout, ~dbus,\n       \\rsend, -30,\n      ).play(t,quant:1);\n    "},{title:"exerpt-00",def:"bass",exerpt:"\n      Pbindef(\\bass,\n       \\instrument,\\osc,\n       \\dur, 0.5,\n       \\atk, 0.001,\n       \\sus, 0,\n       \\rel, 0.5,\n       \\c0, 0,\n       \\detune, 0.18,\n       \\c1, Pwhite(5,10).neg, //brightness\n       \\buf, Prand(~wt_buf[4..9], inf),\n       \\midinote, Pseq([\n          Pn([53 - 24],32),\n          Pn([50 - 24],32),\n          Pn([58 - 24],32),\n          Pn([43 - 12],26),\n          Pn([48 - 12],6),\n        ],inf),\n       \\amp, 0.3,\n       \\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),\n       \\out, 0,\n       \\rout, ~rbus,\n       \\rsend, -20,\n      ).play(t, quant:1);\n    "},{title:"exerpt-00",def:"pad",exerpt:"\n    Pbindef(\\pad,\n     \\instrument,\\osc,\n     \\dur, Pseq([Prand([2,4,16,8])],inf),\n     \\atk, 0.4,\n     \\sus, 0,\n     \\rel, 0.25,\n     \\c0, Pexprand(1,2),\n     \\c1, Pexprand(1,2).neg,\n     \\detune, Pfunc({rrand(0.15,0.4)}!3),\n     \\buf, Prand(~wt_buf[0..3], inf),\n     \\degree, 4,\n     \\midinote, 48 + 12,\n     \\amp, 0.35,\n     \\pan, Pwhite(-0.4,0.4),\n     \\out, 0,\n     \\rsend, -10,\n    ).play(t, quant: 1);\n\n    Pbindef(\\melody,\n      \\instrument, \\osc,\n      \\dur, Pseq([\n        Pseq([14,1/4,1/4,1/4,1/4]),\n        Pseq([15,1/4,1/4,1/4,1/4]),\n      ],inf),\n      \\atk, 0.01,\n      \\sus, 0.03,\n      \\rel, 2,\n      \\c0, 1,\n      \\c1, 1,\n      \\detune, 0.2,\n      \\buf, Pseq([~wt_buf[5]],inf),\n      \\midinote, Pseq([39+2,51+2,55+2,62+2,65+2]+ 12,inf),\n      \\amp, 0.075,\n      \\out, 0,\n      \\rout, ~rbus,\n    ).play(t, quant:1);\n    "},{title:"exerpt-00",def:"chords",exerpt:"\n    Pbindef(\\chords,\n      \\instrument, \\osc,\n      \\dur, 4,\n      \\atk, 0.001,\n      \\sus, 0.5,\n      \\rel, Pseq([Prand([3,5])], inf),\n      \\c0, 0,\n      \\c1, Pwhite(1,10).neg,\n      \\detune, 0.3,\n      \\buf, Prand(~wt_buf[4..9], inf),\n      \\midinote, Pseq([\n        Pn([41,53,57,64,67],4),\n        Pn([38,48,60,64,67],4),\n        Pn([46,58,62,65,67],4),\n        Pn([36,55,58,60,67],4),\n      ],inf),\n      \\amp, Pseq([Pgeom(0.1,-1.dbamp,4)],inf),\n      \\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),\n      \\out, 0,\n      \\rout, ~rbus,\n      \\rsend, -10,\n    ).play(t, quant:1);\n    "},{title:"exerpt-00",def:"melodyhook",exerpt:"\n      Pbindef(\\melodyhook,\n       \\instrument,\\osc,\n       \\dur, Pseq([\n          Pseq([0.5,0.5,0.25,0.5,0.25]), // 3.75\n          Pseq([0.75,0.5, 0.25, 0.5]) // 4\n        ],inf),\n       \\atk, 0.001,\n       \\sus, 0.05,\n       \\rel, 1.55,\n       \\c0, 2,\n       \\c1, Pwhite(5,10).neg,\n       \\detune, 0.13,\n       \\buf, Prand(~wt_buf[4..9], inf),\n       \\midinote, Pseq([Prand([57,57,57,53,53,48,50,48,50]) + Pwrand([0,12,-12,24,36],[9,21,2,13,10].normalizeSum)] ,inf),\n       \\amp, 0.095,\n       \\out,  0,\n       \\rout, ~rbus,\n       \\rsend, -20,\n      ).play(t, quant:1);\n    "},{title:"exerpt-00",def:"rhythms",exerpt:"\n    Pdef(\\rhythms,\n\t\tPwrand([\n\t\t\tPbind(\n\t\t\t\\instrument,\\osc,\n\t\t\t\\dur,Pseq([1/8],4),\n\t\t\t\\freq, Pstutter(4, Prand([\n\t\t\t\t\tPexprand(10000,20000,1),\n\t\t\t\t\tPexprand(100,200,1),\n\t\t\t\t\tPexprand(1,2,1)\n\t\t\t\t],inf)),\n\t\t\t\\detune, 10,\n\t\t\t\\buf, Pstutter(4, Prand(~wt_buf[5..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pstutter(8, Pexprand(0.01,0.06)),\n\t\t\t\\c1, exprand(8,20).neg,\n\t\t\t\\amp, Pgeom(0.9, -6.dbamp, 4) * Pstutter(4,Pexprand(0.3,1)),\n\t\t\t\\pan, Pwhite(-0.6,0.6),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-30,-15),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\kick,\n\t\t\t\\dur, Pseq([1/4],2),\n\t\t\t\\freq, Pstutter(2, Pexprand(1,200)),\n\t\t\t\\detune, Pstutter(2, Pexprand(1,100)),\n\t\t\t\\buf, Pstutter(2, Prand(~wt_buf[8..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pstutter(2, Pexprand(0.01,0.2)),\n\t\t\t\\c1, -10,\n\t\t\t\\amp, Pgeom(0.4, -3.dbamp, 2)  * Pexprand(0.4,1),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-30,-15),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\osc,\n\t\t\t\\dur, Pseq([1/2,1/4,1/4],1),\n\t\t\t\\freq, Pstutter(6, Pexprand(1000,2000)),\n\t\t\t\\detune, 100,\n\t\t\t\\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, Pseq([1/3,0,0],1),\n\t\t\t\\rel, Pseq([0,Pexprand(0.01,0.3,2)],1),\n\t\t\t\\c1, -12,\n\t\t\t\\amp, Pseq([0.1,0.5,0.3],1),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~rbus,\n\t\t\t\\rsend, Pwhite(-30,-18),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\kick,\n\t\t\t\\dur, Pseq([1/4,1/2,1/4],1),\n\t\t\t\\freq, Pstutter(6, Pexprand(100,2000)),\n\t\t\t\\detune, 100,\n\t\t\t\\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, Pseq([0,1/3,0],1),\n\t\t\t\\rel, Pseq([Pexprand(0.01,0.3,1),0,Pexprand(0.01,0.3,1)],1),\n\t\t\t\\c1, -12,\n\t\t\t\\amp, Pseq([0.5,0.1,0.4],1),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-30,-18),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\osc,\n\t\t\t\\dur, Pseq([1/6],6),\n\t\t\t\\freq, Pstutter(6, Pexprand(1,200)),\n\t\t\t\\detune, Pstutter(6, Pexprand(1,100)),\n\t\t\t\\buf, Pstutter(6, Prand(~wt_buf[8..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pstutter(6, Pexprand(0.01,0.1)),\n\t\t\t\\c1, -10,\n\t\t\t\\amp, Pgeom(0.7, -4.dbamp, 6)  * Pexprand(0.4,1),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-30,-18),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\kick,\n\t\t\t\\dur, Prand([\n\t\t\t\t\tPseq([1/2],2),\n\t\t\t\t\tPseq([1],2),\n\t\t\t\t\tPseq([1,1/2,1/2],1),\n\t\t\t\t\tPseq([2],1),\n\t\t\t\t],1),\n\t\t\t\\freq, Pstutter(2, Pexprand(1,200)),\n\t\t\t\\detune, Pstutter(2, Pexprand(1,100)),\n\t\t\t\\buf, Pstutter(2, Prand(~wt_buf[8..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pstutter(2, Pexprand(0.01,0.2)),\n\t\t\t\\c1, -10,\n\t\t\t\\amp, 0.5,\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-20,-10),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\kick,\n\t\t\t\\dur, Prand([\n\t\t\t\t\tPseq([1/16],16),\n\t\t\t\t\tPseq([1/16],8)\n\t\t\t\t],1),\n\t\t\t\\freq, Pstutter(16,Pexprand(1000,20000,inf)),\n\t\t\t\\detune, 0,\n\t\t\t\\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pexprand(0.02,0.04),\n\t\t\t\\c1, -4,\n\t\t\t\\amp, 0.13,\n\t\t\t\\pan, Pseq([1,-1],inf),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, -30,\n\t\t\t)\n\t\t],\n\t\t[40,18,3,3,15,25,5].normalizeSum, inf)\n\t).play(t, quant:1);\n    "}],J=(e("3d1b"),{name:"Index",data:function(){return{codes:[],b:"",SDF:null,isMarchingPlaying:!1,isMarching:!1,targetCodeBlock:"",childList:[]}},created:function(){this.codes=z},computed:{marching:function(){this.isMarchingPlaying&&!this.isMarching?(this.playMarching(),this.isMarching=!0):this.isMarchingPlaying||(this.stopMarching(),this.isMarching=!1)}},methods:{codeBlockState:function(t,n){this.targetCodeBlock={status:t,def:n}},playMarching:function(){var t,n,e,r=this,a=this.SDF.Material("phong",Vec3(.5),Vec3(1),Vec3(.5));this.SDF.march(e=this.SDF.Rotation(this.SDF.StairsIntersection(this.SDF.Sphere(2,null,a),n=this.SDF.Repeat(t=this.SDF.Sphere(.125),Vec3(.25)),.125),Vec3(1))).render(2.5,!0);this.SDF.FFT.start(),window.onframe=function(a){e.angle=.5*a/4,n.distance.x=r.SDF.FFT.low,n.distance.y=r.SDF.FFT.mid,n.distance.z=r.SDF.FFT.high,t.radius=r.SDF.FFT.mid*r.SDF.FFT.high}},stopMarching:function(){this.SDF.clear()},setMarchingPlay:function(){this.childList.some(function(t){return t.isCodeExecuted})?this.isMarchingPlaying=!0:this.isMarchingPlaying=!1,this.marching}},mounted:function(){this.SDF=window.Marching,this.SDF.init(document.querySelector("canvas")),this.SDF.export(window),this.childList=this.$refs.child},components:{Codeblock:T,Footer:L}}),A=J,H=(e("b0cd"),Object(o["a"])(A,h,p,!1,null,"224ead62",null)),W=H.exports;s["a"].use(f["a"]);var G=new f["a"]({mode:"history",routes:[{path:"/",component:W}]}),K=e("2f62");s["a"].use(K["a"]);var Q=new K["a"].Store({state:{},mutations:{},actions:{}});s["a"].config.productionTip=!1,new s["a"]({router:G,store:Q,render:function(t){return t(l)}}).$mount("#app")},"5c0b":function(t,n,e){"use strict";var r=e("5e27"),a=e.n(r);a.a},"5e27":function(t,n,e){},8276:function(t,n,e){},b0cd:function(t,n,e){"use strict";var r=e("5238"),a=e.n(r);a.a}});
//# sourceMappingURL=app.dea581de.js.map