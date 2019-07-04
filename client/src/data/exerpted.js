const exerpedData = [
  {
    title: "exerpt-00",
    exerpt: `(
        play {
            t = Impulse.ar(8/[5,4]);
            o = BPF.ar(LFNoise1.ar(1e4), 1e3, 1.2);
            p = WhiteNoise.ar(0.4) * Env([1,0,1,0,1,0.5], [1]/100).ar(0, t);
            o = (o + p) * Env.asr(1e-5, 1, 0.5, -10).ar(0, t);
            y = Decay.ar(TDelay.ar(t, 1), 2);
            o = o + GVerb.ar(o*0.5,99,9).sum + (2*SinOsc.ar(80*y,y*0.5pi,2*y).tanh) * 4;
            HPF.ar(o.softclip, 30)
        }
        `
  },
  {
    title: "exerpt-00",
    exerpt:
      "play{l=LocalIn.ar(8);o={|i|Pulse.ar(l[i]*16+95,0.9.rand)}!8;LocalOut.ar(o.reverse.tanh);w=BLowShelf.ar(_,47,1,_);p=BPeakEQ.ar(_,285,1,_);h=BHiShelf.ar(_,190,1,_);o=Splay.ar(o);o=h.(w.(p.(o,48),-48),-48);o=GVerb.ar(tanh(o)).flop.mean;LeakDC.ar(Limiter.ar(h.(w.(p.(o,-48),48),48)))} play{l=LocalIn.ar(8);o={|i|Pulse.ar(l[i]*16+95,0.9.rand)}!8;LocalOut.ar(o.reverse.tanh);w=BLowShelf.ar(_,47,1,_);p=BPeakEQ.ar(_,285,1,_);h=BHiShelf.ar(_,190,1,_);o=Splay.ar(o);o=h.(w.(p.(o,48),-48),-48);o=GVerb.ar(tanh(o)).flop.mean;LeakDC.ar(Limiter.ar(h.(w.(p.(o,-48),48),48)))}"
  },
  {
    title: "exerpt-00",
    exerpt: `
      play {
        n = 4;
        t = Decay.ar(Impulse.ar(1/6),SinOsc.kr(1/11,0,0.2,0.5));
        o = SinOsc.ar(200*(t+0.1),t*0.5pi,t*6).tanh;
        o = o + LocalIn.ar(n);
        o = n.collect {|i|
            d = 1/(i+1);
            x = o[n-1-i];
            DelayN.ar(OnePole.ar(x,0.25), d, d);
        };
        LocalOut.ar(tanh(LeakDC.ar(o)));
        Limiter.ar(Splay.ar(o));
    }`
  },
  {
    title: "exerpt-00",
    exerpt:
      "play{x=[0,0,7,5,-2,-3]++(12!6);d=Duty.kr(2,0,Dseq(Dshuf(x,2),inf));n=246*d.midiratio.lag(0.1);o={|i|Pulse.ar(n*(i%2*0.5+0.5)*rrand(0.99,1.001),LFDNoise1.kr(1/3,0.4,0.5))}!8;o=o.mean/4*(d<12);HPF.ar(GVerb.ar(o.sin+PinkNoise.ar(0.01),99,17).sin,30)}"
  },
  {
    title: "exerpt-00",
    exerpt:
      "play{d=DelayC;o=SinOsc;i=Impulse;t=i.kr(Duty.kr(1,0,Dseq(0.25!3++[2],inf)));f=55*3/TIRand.kr(2,8,t);l=LocalIn.ar;l=l+i.ar(o.ar(1/4,0,f/2,f));l=d.ar(l+t,1,1/(2*f)-ControlDur.ir);LocalOut.ar(LeakDC.ar(l).tanh);l=l+d.ar(l,0.2,o.ar(1,0,1e-3,0.1));GVerb.ar(sin(l+(8*t)*4)).sin}"
  },
  {
    title: "exerpt-00",
    exerpt: `
      play {
        n=85;
        d=Duty.kr(1,0,Drand([2,6,8],inf));
        a=Impulse.ar(d);
        o=Ringz.ar(OnePole.ar(a,0.9),n/2,3,3).sin;
        o=Pan2.ar(o+a,o);
        t=0;
        u=Splay.ar({|i|t=SinOsc.ar(n*i+1,t+o.sum.cubed)}.dup(9));
        ((2*o)+u).sin;
    }`
  }
];

export { exerpedData };
