SynthDef('kick', {
  arg out=0, amp=0.1, pan=0;
  var env0, env1, env1m, sig;

  env0 =  EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4]), doneAction:2);
  env1 = EnvGen.ar(Env.new([110, 59, 29], [0.005, 0.29], [-4, -5]));
  env1m = env1.midicps;

  sig = LFPulse.ar(env1m, 0, 0.5, 1, -0.5);
  sig = sig + WhiteNoise.ar(1);
  sig = LPF.ar(sig, env1m*1.5, env0);
  sig = sig + SinOsc.ar(env1m, 0.5, env0);

  sig = sig * 1.2;
  sig = sig.clip2(1);

  Out.ar(out, Pan2.ar(sig * amp));
});