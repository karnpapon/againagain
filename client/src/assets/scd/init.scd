
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
~pbfmmono = Buffer.readChannel(s, "/Users/mac/Desktop/ch_female.wav", channels: [0]);
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
	~parser = TheoryNoteParser.new;
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

	SynthDef(\fatsaw, {
		| out=0, freq = 440, amp=0.1, gate=1, attack=0.01, decay=0.3, sustain=0.5, release=1, filterSpeed=100, filterFreqStart=300, filterFreqEnd=400, resonance=1, hfFilterFreq=1, hfFilterResonance=1 |
		var sig, env, filtFreq;
		env = EnvGen.ar(Env.adsr(attack, decay, sustain, release), gate, levelScale:0.5, doneAction:Done.freeSelf);
		sig = env*Splay.ar(LFSaw.ar(freq*[0.98,0.99,1.0,1.01,1.02],[LFNoise0.kr(2), LFNoise0.kr(1.9), LFNoise0.kr(2.1)]));
		filtFreq = LFSaw.kr(filterSpeed,iphase:1).range(filterFreqStart,filterFreqEnd);
		sig = RLPF.ar(sig, filtFreq, resonance);
		sig = RHPF.ar(sig, hfFilterFreq, hfFilterResonance);
		2.do({
			sig = AllpassN.ar(sig, 0.050, [0.050.rand, 0.050.rand], 1);
		});
		Out.ar(out, amp*sig.tanh);
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
		arg out=0, amp=0.1, pan=0, filterFreq=4000, rel=0.26;
		var env0, env1, env1m, sig;

		env0 =  EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, rel], [-4, -2, -4]), doneAction:2);
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
		var sig;
		// rate = LFNoise2.kr(XLine.kr(1, 20, 60), 2);
		sig = PlayBuf.ar(2,buf,BufRateScale.kr(buf)*rate,startPos: start, doneAction: 2)*mul;
		Out.ar(out,sig);
		Out.ar(rout, sig * rsend.dbamp);
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

	SynthDef(\stretchedFragments, { |out, bufnum, start, time = 1, stretch = 1, amp = 1, attack = 0.01, decay = 0.05|
		var sig = PlayBuf.ar(1, bufnum, rate: stretch.reciprocal, startPos: start), eg;
		sig = PitchShift.ar(sig, pitchRatio: stretch);
		eg = EnvGen.kr(Env.linen(attack, time, decay), sig.abs > 0, doneAction: Done.freeSelf);
		Out.ar(out, (sig * eg) ! 2)
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
		var shaped = Compander.ar(input, input, -6.dbamp, 1, 0.75, 0.1, 0.3);
		var limited = Limiter.ar(shaped, -4.dbamp);
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