(
Pdef.all.do(_.clear);
Pbindef.all.do(_.clear);
~wt_buf.do(_.free);
t.stop;
ServerTree.remove(~add_master);
ServerTree.remove(~add_reverb);
ServerTree.remove(~add_dist);

s = Server.local;
t = TempoClock.new(120/60).permanent_(true);
s.newBusAllocators;
~dbus = Bus.audio(s,2);
~rbus = Bus.audio(s,2);
~mbus = Bus.audio(s,2);

// ~pbfm = Buffer.read(s, "../audios/ch_female.wav" );
// ~pbm = Buffer.read(s, "/server/audios/ch_male.wav");
// ~pbgt = Buffer.read(s, "/server/audios/gtr.wav");


s.waitForBoot({


// -----------------------------------------------------------------
// Initialize.
// -----------------------------------------------------------------

	var p1,p2,p3,p4,p5;
	var md1,md2,md3,md4;

	md1 = Pseq([1,1,0.5,1,2]);
	md2 = Pseq([0.5,0.5,1,3]);
	md3 = Pseq([1,2]);
	md4 = Pseq([0.5,0.5,2]);

	p1 = [39+2,51+2,55+2,62+2,65+2];
	p2 = [36+2,46+2,58+2,62+2,65+2];
	p3 = [44+2,56+2,60+2,63+2,65+2];
	p4 = [34+2,53+2,56+2,58+2,65+2];

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

	SynthDef(\harp, { arg out = 0, freq = 440, amp = 0.1, pan = 0;
		var env, snd;
		env = Env.perc(level: amp).kr(doneAction: 2);
		snd = Pulse.ar(freq, 0.25, 0.75);
		snd = snd * env;
		Out.ar(out, Pan2.ar(snd, pan));
	}).add;


	SynthDef(\kick, {
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
	}).add;

	SynthDef(\player, {
		arg out = 0, buf = 0, rate = 1, start=0, mul = 1,rout=0, rsend=(-20);
		// rate = LFNoise2.kr(XLine.kr(1, 20, 60), 2);
		Out.ar(~mbus,PlayBuf.ar(2,buf,BufRateScale.kr(buf)*rate,startPos: start, doneAction: Done.freeSelf)*mul);
	}).add;

// -----------------------------------------------------------------
// Audio-processing.
// -----------------------------------------------------------------

	SynthDef(\distortion) { |in=0, out=0, amount=0.99, amp=0.45|
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
		OffsetOut.ar(out, limited)
	}).add;


	~add_dist = {Synth(\distortion, [\in, ~dbus, \out, ~mbus])};
	~add_reverb = {Synth(\reverb, [\in, ~rbus, \out, ~mbus], Server.default, \addToTail)};
	~add_master = {Synth(\master, [\in, ~mbus], Server.default, \addToTail)};
	ServerTree.add(~add_dist);
	ServerTree.add(~add_reverb);
	ServerTree.add(~add_master);
	s.freeAll;

	s.sync;
});
)


