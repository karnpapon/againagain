(
SynthDef(\chk, {
	var sig, env;

	env = Env.perc(0.01, \release.kr(1)).kr(gate:1, doneAction:2);
	sig = WhiteNoise.ar;
	sig = BLowPass.ar(sig, \filtFreq.kr(1200));
	sig = env * sig;
	sig = Pan2.ar(sig, \pan.kr(0));

	Out.ar(0, sig);
}).add;
)

(

Pdef(\beats, {
	Pbind(
		\instrument, \chk,
		\dur, Pkey(\dur) / 4 * Pseq([1,Pconst(1, Prand([0.25, 0.5], inf))]).trace,
	)
});

Pdef(\beatSequence,
	Pbind(
		\type, \phrase,
		\instrument, \beats,
		\dur, 4
)).play;

)