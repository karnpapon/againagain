SynthDef(\osc, {
  arg buf=0, freq=200, detune=0.2,
  amp=0.2, pan=0, out=0, rout=0, rsend=(-20),
  atk=0.01, sus=1, rel=0.01, c0=1, c1=(-1);
  var sig, env, detuneCtrl;
  env = EnvGen.ar(
    Env([0,1,1,0],[atk,sus,rel],[c0,0,c1]),
    doneAction:2
  );

  //array of eight Oscs with uniquely detune frequencies
  //and unique initial phase offsets
  detuneCtrl = LFNoise1.kr(0.1!8).bipolar(detune).midiratio;
  sig = Osc.ar(buf, freq * detuneCtrl, {Rand(0,2pi)}!8);
  sig = Splay.ar(sig); //spread 8 signals over stereo field
  sig = LeakDC.ar(sig); //remove DC bias
  sig = Balance2.ar(sig[0], sig[1], pan, amp); //L/R balance (pan)
  sig = sig * env;
  Out.ar(out, sig);
  Out.ar(rout, sig * rsend.dbamp); //"post-fader" send to reverb
}).add;