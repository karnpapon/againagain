(function(t){function n(n){for(var r,u,i=n[0],o=n[1],d=n[2],l=0,f=[];l<i.length;l++)u=i[l],a[u]&&f.push(a[u][0]),a[u]=0;for(r in o)Object.prototype.hasOwnProperty.call(o,r)&&(t[r]=o[r]);c&&c(n);while(f.length)f.shift()();return s.push.apply(s,d||[]),e()}function e(){for(var t,n=0;n<s.length;n++){for(var e=s[n],r=!0,i=1;i<e.length;i++){var o=e[i];0!==a[o]&&(r=!1)}r&&(s.splice(n--,1),t=u(u.s=e[0]))}return t}var r={},a={app:0},s=[];function u(n){if(r[n])return r[n].exports;var e=r[n]={i:n,l:!1,exports:{}};return t[n].call(e.exports,e,e.exports,u),e.l=!0,e.exports}u.m=t,u.c=r,u.d=function(t,n,e){u.o(t,n)||Object.defineProperty(t,n,{enumerable:!0,get:e})},u.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},u.t=function(t,n){if(1&n&&(t=u(t)),8&n)return t;if(4&n&&"object"===typeof t&&t&&t.__esModule)return t;var e=Object.create(null);if(u.r(e),Object.defineProperty(e,"default",{enumerable:!0,value:t}),2&n&&"string"!=typeof t)for(var r in t)u.d(e,r,function(n){return t[n]}.bind(null,r));return e},u.n=function(t){var n=t&&t.__esModule?function(){return t["default"]}:function(){return t};return u.d(n,"a",n),n},u.o=function(t,n){return Object.prototype.hasOwnProperty.call(t,n)},u.p="/";var i=window["webpackJsonp"]=window["webpackJsonp"]||[],o=i.push.bind(i);i.push=n,i=i.slice();for(var d=0;d<i.length;d++)n(i[d]);var c=o;s.push([0,"chunk-vendors"]),e()})({0:function(t,n,e){t.exports=e("56d7")},1:function(t,n){},"20b9":function(t,n,e){},"29c3":function(t,n,e){"use strict";var r=e("20b9"),a=e.n(r);a.a},"52a3":function(t,n,e){"use strict";var r=e("eae8"),a=e.n(r);a.a},"56d7":function(t,n,e){"use strict";e.r(n);e("cadf"),e("551c"),e("097d");var r,a,s=e("2b0e"),u=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{attrs:{id:"app"}},[e("router-view")],1)},i=[],o=(e("5c0b"),e("2877")),d={},c=Object(o["a"])(d,u,i,!1,null,null,null),l=c.exports,f=e("8c4f"),p=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"container"},[t._m(0),e("div",{staticClass:"scroll-area"},[e("div",{staticClass:"codeblock-wrapper"},t._l(t.codes,function(t,n){return e("div",{key:n,staticClass:"codeblock"},[e("Codeblock",{attrs:{dataDetails:t}})],1)}),0)]),e("Footer")],1)},P=[function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"row"},[e("div",{staticClass:"title-wrapper"},[e("div",{staticClass:"headline-wrapper"},[e("h1",{staticClass:"headline"},[t._v("Again again (2019)")]),e("div",{staticClass:"breakline"}),e("h1",[t._v("TBC's Interpretation.")])]),e("p",{staticClass:"lead"},[t._v("Cadson Demak & The ███████")])])])}],h=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"sourcescode"},[e("div",{staticClass:"exerpt-wrapper",on:{click:function(n){return t.toggleRun(t.dataDetails.def)}}},[e("pre",{class:{run:t.isCodeExecuted}},[t._v("      "),t._v("\n        "),e("code",[t._v(t._s(t.dataDetails.exerpt))]),t._v("\n      ")])])])},b=[],m=e("4bea"),v=e.n(m),x=function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"my-canvas-wrapper"},[e("canvas",{ref:"my-canvas"}),t._t("default")],2)},w=[],y={data:function(){return{provider:{context:null}}},provide:function(){return{provider:this.provider}},mounted:function(){this.provider.context=this.$refs["my-canvas"].getContext("2d"),this.$refs["my-canvas"].width=this.$refs["my-canvas"].parentElement.clientWidth,this.$refs["my-canvas"].height=this.$refs["my-canvas"].parentElement.clientHeight}},_=y,q=(e("e75e"),Object(o["a"])(_,x,w,!1,null,"635721b8",null)),g=q.exports,k=(e("6c7b"),e("c5f6"),function(t,n){return Math.floor(n.canvas.width/100*t)}),C=function(t,n){return Math.floor(n.canvas.height/100*t)},j={inject:["provider"],props:{x1:{type:Number,default:0},y1:{type:Number,default:0},x2:{type:Number,default:0},y2:{type:Number,default:0},value:{type:Number,defualt:0},color:{type:String,default:"#F00"}},data:function(){return{oldBox:{x:null,y:null,w:null,h:null}}},computed:{calculatedBox:function(){var t=this.provider.context,n={x:k(this.x1,t),y:C(this.y1,t),w:k(this.x2-this.x1,t),h:C(this.y2-this.y1,t)};return this.oldBox=n,n}},render:function(){if(this.provider.context){var t=this.provider.context,n=this.oldBox,e=this.calculatedBox;t.beginPath(),t.clearRect(n.x,n.y,n.w,n.h),t.clearRect(e.x,e.y-42,e.w,100),t.rect(e.x,e.y,e.w,e.h),t.fillStyle=this.color,t.fill()}}},M=j,O=Object(o["a"])(M,r,a,!1,null,null,null),E=O.exports,$=v()(),S={name:"Codeblock",data:function(){return{isCodeExecuted:!1,b:"",chartValues:[{val:24,color:"red"},{val:32,color:"#0f0"},{val:66,color:"rebeccapurple"}]}},mounted:function(){var t=this,n=1,e=Math.floor(Math.random()*this.chartValues.length);setInterval(function(){Math.random()>.995&&(n*=-1),Math.random()>.99&&(e=Math.floor(Math.random()*t.chartValues.length)),t.chartValues[e].val=Math.min(Math.max(t.chartValues[e].val+.5*n,0),100)},16)},created:function(){},destroyed:function(){},components:{MyCanvas:g,MyDrawer:E},props:{dataDetails:Object},computed:{},methods:{toggleRun:function(t){this.isCodeExecuted=!this.isCodeExecuted,this.isCodeExecuted?this.send("playPattern",t):this.send("stopPattern",t)},send:function(t,n){$.emit(t,n)}}},B=S,D=(e("29c3"),Object(o["a"])(B,h,b,!1,null,"074d2cc0",null)),V=D.exports,N=function(){var t=this,n=t.$createElement;t._self._c;return t._m(0)},T=[function(){var t=this,n=t.$createElement,e=t._self._c||n;return e("div",{staticClass:"footer-container"},[e("div",{staticClass:"wrapper"},[e("div",{staticClass:"details"},[t._v("\n      this project is integrating between\n      "),e("p",{staticClass:"underline"},[t._v("SuperCollider")]),t._v("and\n      "),e("p",{staticClass:"underline"},[t._v("Vue.js")])]),e("div",{staticClass:"credits"},[e("span",{staticClass:"icon"},[e("a",{attrs:{target:"blank",href:"https://github.com/karnpapon"}},[e("i",{staticClass:"fab fa-github"})])]),e("span",{staticClass:"icon"},[e("a",{attrs:{target:"blank",href:"https://github.com/karnpapon"}},[e("i",{staticClass:"fab fa-youtube"})])])])])])}],F={name:"Footer",data:function(){return{}},methods:{},components:{}},R=F,I=(e("912d"),Object(o["a"])(R,N,T,!1,null,"a6c18b6a",null)),z=I.exports,J=(e("33fc"),[{title:"exerpt-00",def:"main_kick",exerpt:"\n      Pbindef(\\main_kick,\n       \\instrument,\\kick,\n       \\dur, Pseq([Pseq([1,1,1,0.75],1),Pseq([1.25,1,1,0.75],inf)],inf),\n       \\freq, Pstutter(16,Pexprand(1000,20000,inf)),\n       \\detune, 0,\n       \\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),\n       \\atk, 0,\n       \\sus, 0,\n       \\rel, Pexprand(0.02,0.04),\n       \\c1, -4,\n       \\amp, 0.5,\n       \\pan, Pseq([1,-1],inf),\n       \\out, 0,\n       \\rout, ~dbus,\n       \\rsend, -30,\n      ).play(t,quant:1);\n    "},{title:"exerpt-00",def:"bass",exerpt:"\n      Pbindef(\\bass,\n       \\instrument,\\osc,\n       \\dur, 0.5,\n       \\atk, 0.001,\n       \\sus, 0,\n       \\rel, 0.5,\n       \\c0, 0,\n       \\detune, 0.18,\n       \\c1, Pwhite(5,10).neg, //brightness\n       \\buf, Prand(~wt_buf[4..9], inf),\n       \\midinote, Pseq([\n          Pn([53 - 24],32),\n          Pn([50 - 24],32),\n          Pn([58 - 24],32),\n          Pn([43 - 12],26),\n          Pn([48 - 12],6),\n        ],inf),\n       \\amp, 0.3,\n       \\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),\n       \\out, 0,\n       \\rout, ~rbus,\n       \\rsend, -20,\n      ).play(t, quant:1);\n    "},{title:"exerpt-00",def:"chords",exerpt:"\n    Pbindef(\\chords,\n     \\instrument,\\osc,\n     \\dur, 4,\n     \\atk, 0.001,\n     \\sus, 0.5,\n     \\rel, Pseq([Prand([3,5])], inf),\n     \\c0, 0,\n     \\c1, Pwhite(1,10).neg,\n     \\detune, 0.3,\n     \\buf, Prand(~wt_buf[4..9], inf),\n     \\midinote, Pseq([\n        Pn(p1,4),\n        Pn(p2,4),\n        Pn(p3,4),\n        Pn(p4,4),\n      ],inf),\n     \\amp, Pseq([Pgeom(0.1,-1.dbamp,4)],inf),\n     \\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),\n     \\out, 0,\n     \\rout, ~rbus,\n     \\rsend, -10,\n    ).play(t, quant:1);  \n    "},{title:"exerpt-00",def:"melodyhook",exerpt:"\n      Pbindef(\\melodyhook,\n       \\instrument,\\osc,\n       \\dur, Pseq([\n          Pseq([0.5,0.5,0.25,0.5,0.25]), // 3.75\n          Pseq([0.75,0.5, 0.25, 0.5]) // 4\n        ],inf),\n       \\atk, 0.001,\n       \\sus, 0.05,\n       \\rel, 1.55,\n       \\c0, 2,\n       \\c1, Pwhite(5,10).neg,\n       \\detune, 0.13,\n       \\buf, Prand(~wt_buf[4..9], inf),\n       \\midinote, Pseq([Prand([57,57,57,53,53,48,50,48,50]) + Pwrand([0,12,-12,24,36],[9,21,2,13,10].normalizeSum)] ,inf),\n       \\amp, 0.095,\n       \\out,  0,\n       \\rout, ~rbus,\n       \\rsend, -20,\n      ).play(t, quant:1);\n    "},{title:"exerpt-00",def:"pad",exerpt:"\n    Pbindef(\\pad,\n     \\instrument,\\osc,\n     \\dur, Pseq([Prand([2,4,16,8])],inf),\n     \\atk, 0.4,\n     \\sus, 0,\n     \\rel, 0.25,\n     \\c0, Pexprand(1,2),\n     \\c1, Pexprand(1,2).neg,\n     \\detune, Pfunc({rrand(0.15,0.4)}!3),\n     \\buf, Prand(~wt_buf[0..3], inf),\n     \\degree, 4,\n     \\midinote, 48 + 12,\n     \\amp, 0.35,\n     \\pan, Pwhite(-0.4,0.4),\n     \\out, 0,\n     \\rsend, -10,\n    ).play(t, quant: 1);\n    "},{title:"exerpt-00",def:"rhythms",exerpt:"\n    Pdef(\\rhythms,\n\t\tPwrand([\n\t\t\tPbind(\n\t\t\t\\instrument,\\osc,\n\t\t\t\\dur,Pseq([1/8],4),\n\t\t\t\\freq, Pstutter(4, Prand([\n\t\t\t\t\tPexprand(10000,20000,1),\n\t\t\t\t\tPexprand(100,200,1),\n\t\t\t\t\tPexprand(1,2,1)\n\t\t\t\t],inf)),\n\t\t\t\\detune, 10,\n\t\t\t\\buf, Pstutter(4, Prand(~wt_buf[5..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pstutter(8, Pexprand(0.01,0.06)),\n\t\t\t\\c1, exprand(8,20).neg,\n\t\t\t\\amp, Pgeom(0.9, -6.dbamp, 4) * Pstutter(4,Pexprand(0.3,1)),\n\t\t\t\\pan, Pwhite(-0.6,0.6),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-30,-15),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\kick,\n\t\t\t\\dur, Pseq([1/4],2),\n\t\t\t\\freq, Pstutter(2, Pexprand(1,200)),\n\t\t\t\\detune, Pstutter(2, Pexprand(1,100)),\n\t\t\t\\buf, Pstutter(2, Prand(~wt_buf[8..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pstutter(2, Pexprand(0.01,0.2)),\n\t\t\t\\c1, -10,\n\t\t\t\\amp, Pgeom(0.4, -3.dbamp, 2)  * Pexprand(0.4,1),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-30,-15),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\osc,\n\t\t\t\\dur, Pseq([1/2,1/4,1/4],1),\n\t\t\t\\freq, Pstutter(6, Pexprand(1000,2000)),\n\t\t\t\\detune, 100,\n\t\t\t\\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, Pseq([1/3,0,0],1),\n\t\t\t\\rel, Pseq([0,Pexprand(0.01,0.3,2)],1),\n\t\t\t\\c1, -12,\n\t\t\t\\amp, Pseq([0.1,0.5,0.3],1),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~rbus,\n\t\t\t\\rsend, Pwhite(-30,-18),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\kick,\n\t\t\t\\dur, Pseq([1/4,1/2,1/4],1),\n\t\t\t\\freq, Pstutter(6, Pexprand(100,2000)),\n\t\t\t\\detune, 100,\n\t\t\t\\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, Pseq([0,1/3,0],1),\n\t\t\t\\rel, Pseq([Pexprand(0.01,0.3,1),0,Pexprand(0.01,0.3,1)],1),\n\t\t\t\\c1, -12,\n\t\t\t\\amp, Pseq([0.5,0.1,0.4],1),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-30,-18),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\osc,\n\t\t\t\\dur, Pseq([1/6],6),\n\t\t\t\\freq, Pstutter(6, Pexprand(1,200)),\n\t\t\t\\detune, Pstutter(6, Pexprand(1,100)),\n\t\t\t\\buf, Pstutter(6, Prand(~wt_buf[8..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pstutter(6, Pexprand(0.01,0.1)),\n\t\t\t\\c1, -10,\n\t\t\t\\amp, Pgeom(0.7, -4.dbamp, 6)  * Pexprand(0.4,1),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-30,-18),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\kick,\n\t\t\t\\dur, Prand([\n\t\t\t\t\tPseq([1/2],2),\n\t\t\t\t\tPseq([1],2),\n\t\t\t\t\tPseq([1,1/2,1/2],1),\n\t\t\t\t\tPseq([2],1),\n\t\t\t\t],1),\n\t\t\t\\freq, Pstutter(2, Pexprand(1,200)),\n\t\t\t\\detune, Pstutter(2, Pexprand(1,100)),\n\t\t\t\\buf, Pstutter(2, Prand(~wt_buf[8..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pstutter(2, Pexprand(0.01,0.2)),\n\t\t\t\\c1, -10,\n\t\t\t\\amp, 0.5,\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, Pwhite(-20,-10),\n\t\t\t),\n\n\t\t\tPbind(\n\t\t\t\\instrument,\\kick,\n\t\t\t\\dur, Prand([\n\t\t\t\t\tPseq([1/16],16),\n\t\t\t\t\tPseq([1/16],8)\n\t\t\t\t],1),\n\t\t\t\\freq, Pstutter(16,Pexprand(1000,20000,inf)),\n\t\t\t\\detune, 0,\n\t\t\t\\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),\n\t\t\t\\atk, 0,\n\t\t\t\\sus, 0,\n\t\t\t\\rel, Pexprand(0.02,0.04),\n\t\t\t\\c1, -4,\n\t\t\t\\amp, 0.13,\n\t\t\t\\pan, Pseq([1,-1],inf),\n\t\t\t\\out, 0,\n\t\t\t\\rout, ~dbus,\n\t\t\t\\rsend, -30,\n\t\t\t)\n\t\t],\n\t\t[40,18,3,3,15,25,5].normalizeSum, inf)\n\t)\n    "}]),A={name:"Index",data:function(){return{codes:[],b:""}},created:function(){this.codes=J},methods:{},mounted:function(){},components:{Codeblock:V,Footer:z}},H=A,W=(e("52a3"),Object(o["a"])(H,p,P,!1,null,"dabe00f4",null)),G=W.exports;s["a"].use(f["a"]);var K=new f["a"]({mode:"history",routes:[{path:"/",component:G}]}),L=e("2f62");s["a"].use(L["a"]);var Q=new L["a"].Store({state:{},mutations:{},actions:{}});s["a"].config.productionTip=!1,new s["a"]({router:K,store:Q,render:function(t){return t(l)}}).$mount("#app")},"5c0b":function(t,n,e){"use strict";var r=e("5e27"),a=e.n(r);a.a},"5e27":function(t,n,e){},"5f96":function(t,n,e){},"912d":function(t,n,e){"use strict";var r=e("b8ce"),a=e.n(r);a.a},b8ce:function(t,n,e){},e75e:function(t,n,e){"use strict";var r=e("5f96"),a=e.n(r);a.a},eae8:function(t,n,e){}});
//# sourceMappingURL=app.73db661c.js.map