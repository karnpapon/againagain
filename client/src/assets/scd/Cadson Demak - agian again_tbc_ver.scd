
Server.default.options.outDevice = "Built-in Output";
s.options.numBuffers = 2048 * 16;
s.options.memSize = 8192 * 16;
s.options.maxNodes = 1024 * 32;
// s.options.numOutputBusChannels = 12;
s.options.numInputBusChannels = 0;

s.plotTree
ServerOptions.devices

// -----------------------------------------------------------------
// Initialize.
// -----------------------------------------------------------------

(
~pbfm = Buffer.read(s, "/Users/mac/Desktop/ch_female.wav");
~pbm = Buffer.read(s, "/Users/mac/Desktop/ch_male.wav");
~pbm2 = Buffer.read(s, "/Users/mac/Desktop/ch_male2.wav");
~pbgt = Buffer.read(s, "/Users/mac/Desktop/gtr.wav");
)

s.plotTree
(
Pdef.all.do(_.clear);
Pbindef.all.do(_.clear);
~wt_buf.do(_.free);
t.stop;
ServerTree.remove(~add_master);
ServerTree.remove(~add_reverb);
ServerTree.remove(~add_dist);
// Window.closeAll;

s = Server.local;
t = TempoClock.new(120/60).permanent_(true);
s.newBusAllocators;
~dbus = Bus.audio(s,2);
~rbus = Bus.audio(s,2);
~mbus = Bus.audio(s,2);

s.waitForBoot({

	/*var p1,p2,p3,p4,p5;
	var md1,md2,md3,md4;*/

	/*md1 = Pseq([1,1,0.5,1,2]);
	md2 = Pseq([0.5,0.5,1,3]);
	md3 = Pseq([1,2]);
	md4 = Pseq([0.5,0.5,2]);*/

	// p1 = [39+2,51+2,55+2,62+2,65+2];
	// p2 = [36+2,46+2,58+2,62+2,65+2];
	// p3 = [44+2,56+2,60+2,63+2,65+2];
	// p4 = [34+2,53+2,56+2,58+2,65+2];

	~wt_sig = 10.collect({
		arg i;
		var numSegs = i.linexp(0,9,4,40).round;

		Env(
			//env always begins and ends with zero
			//inner points are random from -1.0 to 1.0
			[0]++({1.0.rand}.dup(numSegs-1) * [1,-1]).scramble++[0],

			//greater segment duration variety in higher-index wavetables
			{exprand(1,i.linexp(0,9,1,50))}.dup(numSegs),

			//low-index wavetables tend to be sinusoidal
			//high index wavetables tend to have sharp angles and corners
			{[\sine,0,exprand(1,20) * [1,-1].choose].wchoose([9-i,3,i].normalizeSum)}.dup(numSegs)
		).asSignal(1024);
	});

	~wt_buf = Buffer.allocConsecutive(10, s, 2048, 1, {
		arg buf, index;
		buf.setnMsg(0, ~wt_sig[index].asWavetable);
	});

// -----------------------------------------------------------------
// SynthDef.
// -----------------------------------------------------------------

	//main wavetable synth by Eli Fieldsteel.
	SynthDef(\osc, {
		arg buf=0, freq=200, detune=0.2,
		amp=0.2, pan=0, out=0, rout=0, rsend=(-20),
		atk=0.01, sus=1, rel=0.01, c0=1, c1=(-1);
		var sig, env, detuneCtrl;
		env = EnvGen.ar(
			Env([0,1,1,0],[atk,sus,rel],[c0,0,c1]),
			doneAction:2
		);

		detuneCtrl = LFNoise1.kr(0.1!8).bipolar(detune).midiratio;
		sig = Osc.ar(buf, freq * detuneCtrl, {Rand(0,2pi)}!8);
		sig = Splay.ar(sig);
		sig = LeakDC.ar(sig);
		sig = Balance2.ar(sig[0], sig[1], pan, amp);
		sig = sig * env;
		Out.ar(out, sig);
		Out.ar(rout, sig * rsend.dbamp); //"post-fader" send to reverb
	}).add;


	// apply from David Granström.
	SynthDef(\gabber, {
		arg out=0, pan, atk=0.01, sus=0.5, rel=0.25,f=50, amp=0.25, filterFreq=1550, rroom=10, rtime=2, tlo=0, thigh=0.5;
		var sig, demand, decay, env;
		sig = Impulse.ar(1);
		env = EnvGen.ar(
			Env([0,1,1,0],[atk,sus,rel]),
			doneAction:2
		);
		sig = Decay.ar(sig, TRand.ar(tlo, thigh, sig)) * Pulse.ar(f * Decay.ar(sig, 0.1, 20, 1));
		sig = sig * env * amp ;
		sig = RLPF.ar(sig, filterFreq);
		sig = Pan2.ar(sig, TRand.ar(-1, 1, sig));
		// + GVerb.ar(FreqShift.ar(sig.sum, 300), rroom, rtime)
		Out.ar(out, LeakDC.ar(tanh((16*sig) )));
	}).add;


	SynthDef(\kick, {
		arg out=0, amp=0.1, pan=0, filterFreq=4000;
		var env0, env1, env1m, sig;

		env0 =  EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4]), doneAction:2);
		env1 = EnvGen.ar(Env.new([110, 59, 29], [0.005, 0.29], [-4, -5]));
		env1m = env1.midicps;

		sig = LFPulse.ar(env1m, 0, 0.5, 1, -0.5);
		sig = sig + WhiteNoise.ar(1);
		sig = LPF.ar(sig, env1m*1.5, env0);
		sig = sig + SinOsc.ar(env1m, 0.5, env0);

		sig = sig * 1.2;
		sig = RLPF.ar(sig, filterFreq);
		sig = sig.clip2(1);

		Out.ar(out, Pan2.ar(sig * amp));
	}).add;

	SynthDef(\player, {
		arg out = 0, buf = 0, rate = 1, start=0, mul = 1,rout=0, rsend=(-20);
		// rate = LFNoise2.kr(XLine.kr(1, 20, 60), 2);
		Out.ar(out,PlayBuf.ar(2,buf,BufRateScale.kr(buf)*rate,startPos: start, doneAction: Done.freeSelf)*mul);
	}).add;

	SynthDef.new(\play, {
		arg atk=0.001, sus=0.2, rel=0.06, c1=1, c2=(-1),
		buf=0, rate=1, spos=0, amp=1, pan=0, out=0;
		var sig, env;
		env = Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]).kr(2);
		sig = PlayBuf.ar(2, buf, rate, startPos:spos);
		sig = sig * env;
		sig = Pan2.ar(sig, pan, amp);
		Out.ar(out, sig);
	}).add;

// -----------------------------------------------------------------
// Audio-processing.
// -----------------------------------------------------------------

	SynthDef(\distortion) { |in=0, out=0, amount=0.6, amp=0.45|
		var input, amCoef, newOut;
		amCoef= 2*amount/(1-amount);
		input = HPF.ar(In.ar(in, 2), 400)*5;
		newOut = MidEQ.ar(LPF.ar((1+amCoef)*input/(1+(amCoef*input.abs)), [3800, 3900])*0.5, 120, 0.7, 8);
		Out.ar(out, newOut * amp);
	}.add;



	SynthDef(\reverb, {
		arg in=0, out=0, dec=6, lpf=1500;
		var sig;
		sig = In.ar(in, 2).sum;
		sig = DelayN.ar(sig, 0.03, 0.03);
		sig = CombN.ar(sig, 0.1, {Rand(0.01,0.099)}!32, dec);
		sig = SplayAz.ar(2, sig);
		sig = LPF.ar(sig, lpf);
		5.do{sig = AllpassN.ar(sig, 0.1, {Rand(0.01,0.099)}!2, 3)};
		sig = LPF.ar(sig, lpf);
		sig = LeakDC.ar(sig);
		Out.ar(out, sig);
	}).add;

	SynthDef(\master, {
		|in, gate=1, out=0|
		var input = In.ar(in, 2);
		var shaped = Compander.ar(input, input, -8.dbamp, 1, 0.75, 0.1, 0.3);
		var limited = Limiter.ar(shaped, -1.dbamp);
		var releaser = DetectSilence.ar(gate + input, doneAction: 2);
		Out.ar(out, limited)
	}).add;


	~add_dist = {Synth(\distortion, [\in, ~dbus, \out, ~mbus])};
	~add_reverb = {Synth(\reverb, [\in, ~rbus, \out, ~mbus], Server.default, \addToTail)};
	~add_master = {Synth(\master, [\in, ~mbus], Server.default, \addToTail)};
	ServerTree.add(~add_dist);
	ServerTree.add(~add_reverb);
	ServerTree.add(~add_master);
	s.freeAll;

	s.sync;
	/*s.plotTree;
	s.meter;*/


});
)

// -----------------------------------------------------------------
// Composition.
// -----------------------------------------------------------------

(
p = Pdef(\movement1,

	Pbindef(\pad,
		\instrument, \osc,
		\dur, Pseq([Prand([2,4,16,8])],inf),
		\atk, 0.4,
		\sus, 0,
		\rel, 0.25,
		\c0, Pexprand(1,2),
		\c1, Pexprand(1,2).neg,
		\detune, Pfunc({rrand(0.15,0.4)}!3),
		\buf, Prand(~wt_buf[0..3], inf),
		\degree, 4,
		\midinote, 48 + 12,
		\amp, 0.35,
		\pan, Pwhite(-0.4,0.4),
		\out, ~mbus,
		\rsend, -10,
	).play(t, quant: 1);

	 Pbindef(\chords,
	 	\instrument, \osc,
	 	\dur, 4,
	 	\atk, 0.001,
		\sus, 0.5,
	 	\rel, Pseq([Prand([3,5])], inf),
	 	\c0, 0,
	 	\c1, Pwhite(1,10).neg,
		\detune, Pstutter(6, Pexprand(0.1,0.8)),
	 	\buf, Prand(~wt_buf[4..9], inf),
	 	\midinote, Pseq([
	 		Pn([41,53,57,64,67],3),
			Pn(\,1),
	 		Pn([38,48,60,64,67],3),
			Pn(\,1),
	 	],inf),
	 	\amp, Pseq([Pgeom(0.15,-1.dbamp,4)],inf),
	 	\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
		// \out, ~mbus,
		\rout, ~rbus,
	 	\rsend, -10,
	).play(t, quant:1); //3.65 also works!

	// sampler--------------------------.

	/*Pbindef(\female_chorus,
		\instrument, \player,
		\stretch, 4,
		\dur, 16,
		\mul, 2,
		\rate, 1,
		\buf, ~pbfm,
		\out, ~mbus,
	).play(t, quant:1);*/


	/*Pbindef(\male_chorus,
		\instrument, \player,
		// \dur, Pseq([12,20],inf),
		\dur, 32,
		\mul, 0.1,
		\start, 30000,
		// \rate, 0.5,
		\buf, Pseq([
			// Pseq([~pbm, ~pbm2]),
			Pseq([~pbm]),
		],inf),
		\out, ~dbus,
	);*/

	/*Pbindef(\gt,
		\instrument, \player,
		\dur, 8,
		\mul, 2,
		\buf, ~pbgt,
		\out, 0,
	).play(t, quant:1);*/


	// bass --------------------------.

	Pbindef(\bass,
		\instrument, \osc,
		// \dur, 0.5,
		// \dur, Pstutter(
		// 	Pwrand([4,1,1,1,1],[5,5,3,10,5].normalizeSum, inf),
		// 	Pseq([1/2,1/4,1/4,1/2],inf)
		// ),
		\dur, 0.5,
		// \freq, Pstutter(6, Pexprand(1000,2000)),
		\atk, 0.001,
		\sus, 0,
		\rel, 0.5,
		\c0, 0,
		\detune, 0.18,
		\c1, Pwhite(5,10).neg, //brightness
		\buf, Prand(~wt_buf[4..9], inf),
		\midinote, Pseq([
			Pn([53 - 24],32),
			Pn([50 - 24],32),
			Pn([58 - 24],32),
			Pn([43 - 12],32),
			// Pn([48 - 12],32),
		],inf),
		\amp, 0.8,
		\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
		\out, ~mbus,
		\rout, ~rbus,
		\rsend, -20,
	).play(t, quant:1);


	Pbindef(\melody,
		\instrument, \osc,
		\dur, Pseq([16,1/4,1/4,1/4,1/4],inf),
		// \dur, 1,
		\atk, 0.01,
		\sus, 0.03,
		\rel, 2,
		\c0, 1,
		\c1, 1,
		\detune, 0.2,
		\buf, Pseq([~wt_buf[5]],inf),
		// \midinote, Pseq([Prand([p1,p2,p3,p4])] + 12,inf),
		\midinote, Pseq([39+2,51+2,55+2,62+2,65+2]+ 12,inf),
		\amp, 0.12,
		\out, ~mbus,
		\rout, ~rbus,
	).play(t, quant:1);


	Pbindef(\ambi,
		\instrument, \osc,
		\dur, Prand([
			Pseq([Prand([12]),2,1.5,0.5],1),
			Pseq([Prand([12]),1.5,1,1.5],1),
		],inf),
		\atk, 0.01,
		\sus, 0.3,
		\rel, 1.5,
		\c0, -2,
		\c1, -2,
		\detune, Pexprand(0.18,0.25),
		\buf, Pwrand([
			Pseq([~wt_buf[0]],4),
			Pseq([~wt_buf[1]],4),
			Pseq([~wt_buf[2]],4),
		],[9,3,1].normalizeSum,inf),
		\midinote, Pxrand([
			Pseq([\,57,53,Prand([48,69,72,\])],1),
		],inf) + 12,
		\amp, 0.5,
		\out, ~mbus,
		\rout, ~rbus,
		\rsend, -20,
	).play(t, quant:1);


	Pbindef(\melodyhook,
		\instrument, \osc,
		// \dur, Pbrown(lo:0.1,hi:1.0, step:0.125, length:inf),
		\dur, Pstutter(1,Pseq([
			Pseq([0.5,0.5,0.25,0.5,0.5]), // 3.75
			Pseq([0.5,0.5, 0.25, 0.5, \]) // 4
		],inf)),
		\atk, 0.001,
		\sus, 0.05,
		// \rel, Pstutter(8, Pexprand(0.01,1.6)),
		\rel, 1.55,
		\c0, 2,
		\c1, Pwhite(5,10).neg,
		\detune, 0.13,
		\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),
		\midinote, Pseq([57,57,57,53,53,48,50,48,50] ,inf) + 12,
		\amp, 0.5,
		// \out,  ~mbus,
		\rout, ~dbus,
		\rsend, -40,
	);

	/*Pbindef(\melodyhook, \dur, Pseq([
		Pseq([0.5,0.5,0.25,0.5,0.25]), // 3.75
		Pseq([0.75,0.5, 0.25, 0.5]) // 4
	],inf)).play(t, quant:1);
	Pbindef(\main_kick).play(t, quant:1);*/

	Pbindef(\main_kick,
		\instrument, \kick,
		\dur, Pseq([Pseq([1,1,1,0.75],1),Pseq([1.25,1,1,0.75],inf)],inf),
		\freq, Pstutter(16,Pexprand(1000,20000,inf)),
		\detune, 0,
		\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),
		\atk, 0,
		\sus, 0,
		\filterFreq, Pseries(50,2, 100),
		\rel, Pexprand(0.02,0.04),
		\c1, -4,
		\amp, 0.8,
		\pan, Pseq([1,-1],inf),
		// \out, ~mbus,
		// \rout, ~dbus,
		\rsend, -30,
	);

	Pbindef(\hard_kick,
		\instrument, \gabber,
		/*#[dur,amp], Ptuple([
			 Pseq([
				Pseq([0.25],48),
				Pseq([0.125],4),
		],1),
			Pseq([
				Pseq([0.1],34),
				Pseq([0.3],1),
				Pseq([0.1],16),
				Pseq([0.3],1),
			])
		],inf),*/
		\dur, Pseq([
			Pseq([0.25],16),
			Pseq([0.25],16),
			Pseq([0.25],16),
			Pseq([0.125],4),
		],inf),
		\amp, 0.1,
		\rel, 1,
		\out, ~mbus
		// \rel, Pseq([0.1,Pexprand(0.01,0.3,0.9)],inf),
	).play(t, quant: 1);

	/*Pdef(\rhythms,
		Pwrand([
			Pbind(
				\instrument, \osc,
				\dur,Pseq([1/8],4),
				\freq, Pstutter(4, Prand([
					Pexprand(10000,20000,1),
					Pexprand(100,200,1),
					Pexprand(1,2,1)
				],inf)),
				\detune, 10,
				\buf, Pstutter(4, Prand(~wt_buf[5..9],inf)),
				\atk, 0,
				\sus, 0,
				\rel, Pstutter(8, Pexprand(0.01,0.06)),
				\c1, exprand(8,20).neg,
				\amp, Pgeom(0.9, -6.dbamp, 4) * Pstutter(4,Pexprand(0.3,1)),
				\pan, Pwhite(-0.6,0.6),
				\out, 0,
				\rout, ~mbus,
				\rsend, Pwhite(-30,-15),
			),

			Pbind(
				\instrument, \kick,
				\dur, Pseq([1/4],2),
				\freq, Pstutter(2, Pexprand(1,200)),
				\detune, Pstutter(2, Pexprand(1,100)),
				\buf, Pstutter(2, Prand(~wt_buf[8..9],inf)),
				\atk, 0,
				\sus, 0,
				\rel, Pstutter(2, Pexprand(0.01,0.2)),
				\c1, -10,
				\amp, Pgeom(0.4, -3.dbamp, 2)  * Pexprand(0.4,1),
				\out, 0,
				\rout, ~mbus,
				\rsend, Pwhite(-30,-15),
			),

			Pbind(
				\instrument, \osc,
				\dur, Pseq([1/2,1/4,1/4],1),
				\freq, Pstutter(6, Pexprand(1000,2000)),
				\detune, 100,
				\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),
				\atk, 0,
				\sus, Pseq([1/3,0,0],1),
				\rel, Pseq([0,Pexprand(0.01,0.3,2)],1),
				\c1, -12,
				\amp, Pseq([0.4,0.8,0.3],1),
				\out, 0,
				\rout, ~rbus,
				\rsend, Pwhite(-30,-18),
			),

			Pbind(
				\instrument, \kick,
				\dur, Pseq([1/4,1/2,1/4],1),
				\freq, Pstutter(6, Pexprand(100,2000)),
				\detune, 100,
				\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),
				\atk, 0,
				\sus, Pseq([0,1/3,0],1),
				\rel, Pseq([Pexprand(0.01,0.3,1),0,Pexprand(0.01,0.3,1)],1),
				\c1, -12,
				\amp, Pseq([0.5,0.1,0.4],1),
				\out, 0,
				\rout, ~dbus,
				\rsend, Pwhite(-30,-18),
			),

			Pbind(
				\instrument, \osc,
				\dur, Pseq([1/6],6),
				\freq, Pstutter(6, Pexprand(1,200)),
				\detune, Pstutter(6, Pexprand(1,100)),
				\buf, Pstutter(6, Prand(~wt_buf[8..9],inf)),
				\atk, 0,
				\sus, 0,
				\rel, Pstutter(6, Pexprand(0.01,0.1)),
				\c1, -10,
				\amp, Pgeom(0.7, -4.dbamp, 6)  * Pexprand(0.4,1),
				\out, 0,
				\rout, ~dbus,
				\rsend, Pwhite(-30,-18),
			),

			Pbind(
				\instrument, \kick,
				\dur, Prand([
					Pseq([1/2],2),
					Pseq([1],2),
					Pseq([1,1/2,1/2],1),
					Pseq([2],1),
				],1),
				\freq, Pstutter(2, Pexprand(1,200)),
				\detune, Pstutter(2, Pexprand(1,100)),
				\buf, Pstutter(2, Prand(~wt_buf[8..9],inf)),
				\atk, 0,
				\sus, 0,
				\rel, Pstutter(2, Pexprand(0.01,0.2)),
				\c1, -10,
				\amp, 0.5,
				\out, 0,
				\rout, ~dbus,
				\rsend, Pwhite(-20,-10),
			),

			Pbind(
				\instrument, \kick,
				\dur, Prand([
					Pseq([1/16],16),
					Pseq([1/16],8)
				],1),
				\freq, Pstutter(16,Pexprand(1000,20000,inf)),
				\detune, 0,
				\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),
				\atk, 0,
				\sus, 0,
				\rel, Pexprand(0.02,0.04),
				\c1, -4,
				\amp, 0.23,
				\pan, Pseq([1,-1],inf),
				\out, 0,
				\rout, ~dbus,
				\rsend, -30,
			)
		],
		[40,18,3,3,15,25,5].normalizeSum, inf)
	);*/

	Pdef(\hard_rhythms,
		Pwrand([
			Pbind(
				\instrument, \gabber,
				\dur, Pseq([0.25],4),
				\filterFreq, 6000,
				\out, ~mbus,
			),

			Pbind(
				\instrument, \gabber,
				\dur, Pseq([1/4],2),
				\filterFreq, 6000,
				\out, ~mbus,
			),

			Pbind(
				\instrument, \osc,
				\dur, Pseq([1/2,1/4,1/4],1),
				\freq, Pstutter(6, Pexprand(1000,2000)),
				\detune, 100,
				\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),
				\atk, 0,
				\sus, Pseq([1/3,0,0],1),
				\rel, Pseq([0,Pexprand(0.01,0.3,2)],1),
				\c1, -12,
				\amp, Pseq([0.4,0.6],2),
				\out, 0,
				\rout, ~rbus,
				\rsend, Pwhite(-30,-18),
			),

			Pbind(
				\instrument, \gabber,
				\dur, Pseq([1/4,1/2,1/4],1),
				\filterFreq, 4000,
				\out, ~mbus,
			),

			Pbind(
				\instrument, \osc,
				\dur, Pseq([1/6],6),
				\freq, Pstutter(6, Pexprand(100,600)),
				\detune, Pstutter(6, Pexprand(1,100)),
				\buf, Pstutter(6, Prand(~wt_buf[8..9],inf)),
				\atk, 0,
				\sus, 0,
				\rel, Pstutter(6, Pexprand(0.01,0.1)),
				\c1, -10,
				\amp, Pgeom(0.7, -2.dbamp, 6)  * 1.2,
				\out, 0,
				\rout, ~mbus,
				\rsend, Pwhite(-30,-18),
			),

			Pbind(
				\instrument, \gabber,
				\dur, Prand([
					Pseq([1/2],2),
					Pseq([1],2),
					Pseq([1,1/2,1/2],1),
					Pseq([2],1),
				],1),
				\filterFreq, 4000,
				\out, ~mbus,
			),

			Pbind(
				\instrument, \gabber,
				\f, Pstutter(6, Pexprand(5,100)),
				\dur, Prand([
					Pseq([1/16],16),
					Pseq([1/16],8)
				],1),
				\filterFreq, 4000,
				\out, ~mbus,
			)
		],
		[50,18,3,3,15,25,5].normalizeSum, inf)
	)

// });

)
)


// -----------------------------------------------------------------
// score.
// -----------------------------------------------------------------

z = p.asScore(32.0);
z.play;


// -----------------------------------------------------------------
// control.
// -----------------------------------------------------------------


// comp#0 - FX.

(
x = Synth(\distortion, [
	\amp, 0.2,
	\amount, 0.5
]);
)

(
x.set(
	\amount, 0.99,
	\amp, 0.2,
);
)

x.free

// comp#1 - switch drum.
(
Pbindef(\hard_kick).stop;
Pdef(\hard_rhythms).play(t, quant:1);
// Pbindef(\melodyhook).play(t, quant: 1);
Pbindef(\female_chorus).stop;
Pbindef(\male_chorus).stop;
Pbindef(\bass,
	\dur, 0.25,
	\midinote, Pseq([
			Pn([53 - 24],64),
			Pn([50 - 24],64),
			Pn([58 - 24],64),
			Pn([43 - 12],64),
		],inf))
)

Quarks.gui


// -----------------------------------------------------------------
// development.
// -----------------------------------------------------------------


Server.default.record;
Server.default.stopRecording;

x.free;

s.meter;

~wt_sig.reverseDo(_.plot);

Pbind(\hard_rhythms, \filterFreq, 4000);

(
Pdef(\hard_rhythms).stop;
// Pbindef(\hard_kick, \dur, Pwrand([0.25, 0.75],[10,3].normalizeSum,inf) );
Pbindef(\hard_kick, \dur, 0.75);
)


(
Pdef(\rhythms).play(t, quant:1);
Pbindef(\female_chorus).stop;
)

Pdef(\rhythms).play(t, quant:1);
Pbindef(\ambi).stop;


Pbindef(\main_kick, \dur, 0.5);

Pdef(\hard_rhythms, \filterFreq, 4000);

Pbindef(\melodyhook, \amp, 0.5, \rout, ~dbus, \detune, 0.3);
Pbindef(\bass, \c1, 5);

Pbindef(\bass, \dur, 0.25);



(
Pbindef(\bass, \c1, Prand([
					Pseq([1/2],1),
					Pseq([1/4],2),
					Pseq([1,1/2,1/2],1),
					Pseq([1/4],1),
				],inf))
)



Pbindef(\bass, \c0, Pwhite(2,4));
Pbindef(\bass, \amp, 0.2);
Pbindef(\bass, \detune, 0.25);
Pbindef(\chords).fadeTime = 4;

Pbindef(\main_kick, \filterFreq, 1000);

s.plotTree;


// slow chords.
(
c = [
	Pn([ 45, 59, 61, 68 ]),
	Pn([ 44, 59, 63, 66 ]),
	Pn([ 43, 55, 57, 59, 64 ]),
	Pn([ 42, 54, 59, 61, 63 ])
];

p = Pseq(c);
q = p.asStream;

r = Routine({
4.do{
		q.midicps.do{arg n;
			Synth(\osc, [
				\atk, 4,
				\rel, 8,
				\buf, ~wt_buf[1],
				\freq, n,
				\amp, 0.5,
				\out, ~mbus,
				\rsend, -10,
		])}
	}
})
)


(
Pbindef(\sl,
	\instrument, \osc,
	\dur, 16,
	\atk, 4,
	\rel, 4,
	\buf, Prand(~wt_buf[0..3], inf),
	\midinote, Pseq([
		Pn([ 45, 59, 61, 68 ],1),
		Pn([ 44, 59, 63, 66 ],1),
		Pn([ 43, 55, 57, 59, 64 ],1),
		Pn([ 42, 54, 59, 61, 63 ],1)
	],inf),
	\amp, 0.25,
	\out, ~mbus,
	\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
	\rsend, -10,
).play(t, quant:1);
)

s.plotTree

(
var f, o;
g = [
    [0.1, [\s_new, \osc, 1000, 0, 0, \freq, 440]],
    [0.2, [\s_new, \osc, 1001, 0, 0, \freq, 660],
        [\s_new, \helpscore, 1002, 0, 0, \freq, 880]],
    [0.3, [\s_new, \helpscore, 1003, 0, 0, \freq, 220]],
    [1, [\c_set, 0, 0]] // finish
    ];
o = ServerOptions.new.numOutputBusChannels = 1; // mono output
Score.recordNRT(g, "~/Desktop/help-oscFile".standardizePath, "~/Desktop/helpNRT.aiff".standardizePath, options: o); // synthesize
)



(Pbindef(\female_chorus,
	\instrument, \play,
	\dur, 0.25,
	\atk, 0,
	\sus, Pwhite(0.01,0.1,inf),
	\rel, 0.1,
	\c1, 1,
	\c2, -1,
	\rate, 0.25,
	\spos, Pwhite(1000,50000,inf),
	\amp, 1.5,
	\buf, ~pbfm,
	\out, ~dbus,
	\rsend, -10
).play(t, quant:1);)



q.next;



s.meter;
// -----------------------------------------------------------------
// NOTE
// -----------------------------------------------------------------

// chd hook.
// 1) D#2,G2,A#2,D#3,G3,A#3,D4,F4 -> 39,43,46,51,55,58,62,65
// 2) D#2,G2,A#2,D#3,G3,A#3,D4,D#4 -> 39,43,46,51,55,58,62,63
// 3) C2,D#2,G2,A#2,G3,A#3,D4,F4 -> 36,39,43,46,55,58,62,65
// 4) C2,D#2,G2,A#2,G3,A#3,D4,D#4 -> 36,39,43,46,55,58,62,63

// 1) G#1,C2,D#2,G#2,G#3,C4,D#4,F4 -> 32,36,39,44,56,60,63,65
// 2) G#1,C2,D#2,G#2,G#3,C4,D#4,G4 -> 32,36,39,44,56,60,63,67
// 3) F2,G#2,C3,F3,G#3,C4,D#4,G4 -> 41,44,48,53,56,60,63,67
// 4) A#1,G#2,C3,F3,G#3,A#3,D#4,F4 -> 34,44,48,53,56,58,63,65


// intro melody lead.
// 1) F3,A3,F4,E4,C4, A3,C4,D4,G3, C4,A3, D3,G3,F3
// 53,57,65,64,60,
// 57,60,62,55
// 60,57
// 50,55,53

// last hook melody (gt lick based)
// A3,F3,C3,D3,A3,F3,C4,A#3,A3,A#3,F#3,C3

