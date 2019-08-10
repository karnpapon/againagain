(

///////////////////
///// CHORDS //////
///////////////////

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
);

Pbindef(\chords,
	\instrument, \osc,
	\dur, Pseq([4],inf),
	\atk, 0.001,
	\sus, 0.5,
	\rel, Pseq([Prand([3,5])], inf),
	\c0, 0,
	\c1, Pwhite(1,10).neg,
	\detune, Pstutter(6, Pexprand(0.1,0.8)),
	\buf, ~wt_buf[6],
	\midinote, Pseq([
		Pn([41,53,57,64,67],3),
		Pn(\,1),
		Pn([38,48,60,64,67],3),
		Pn(\,1),
	],inf),
	\amp, Pseq([Pgeom(0.12,-1.dbamp,4)],inf),
	\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
	// \out, ~mbus,
	\rout, ~rbus,
	\rsend, -10,
);



///////////////////
////// BASS ///////
///////////////////

Pbindef(\bass,
	\instrument, \osc,
	\dur, Pseq([0.5], inf),
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
);

///////////////////
///// SAMPLE //////
///////////////////

Pbindef(\female_chorus2,
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
);

Pbindef(\female_chorus,
	\instrument, \player,
	\stretch, 4,
	\dur, 16,
	\mul, 2,
	\rate, 1,
	\buf, ~pbfm,
	\out, ~mbus,
);

///////////////////
///// MELODY //////
///////////////////

Pbindef(\melody,
	\instrument, \osc,
	\dur, Pseq([16,1/4,1/4,1/4,1/4],inf),
	\atk, 0.01,
	\sus, 0.03,
	\rel, 2,
	\c0, 1,
	\c1, 1,
	\detune, 0.2,
	\buf, Pseq([~wt_buf[5]],inf),
	\midinote, Pseq([39+2,51+2,55+2,62+2,65+2]+ 12,inf),
	\amp, 0.12,
	\out, ~mbus,
	\rout, ~rbus,
);


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
		Pseq([\,57,53,Prand([48,69,72,\])],inf),
	],inf) + 12,
	\amp, 0.25,
	\out, ~dbus,
	\rout, ~rbus,
	\rsend, -10,
);


///////////////////
///// RYTHMIC /////
///////////////////

Pbindef(\hard_kick,
	\instrument, \gabber,
	\dur, Pseq([0.25], inf),
	\amp, 0.1,
	\rel, 1,
	\tlo, 0,
	\thigh, 0.5,
	\out, ~mbus
);

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
)



s.scope
///////////////////
/// COMPOSITION ///
///////////////////
(
// s.record(path: "~/Desktop/out.wav".standardizePath);
{
	1.wait;
	x={FreeVerb.ar(CombN.ar(VarSaw.ar(LFSaw.ar(32,0,12,8),0,LFSaw.ar([18,12],0,1/64,1/64)).sin/2,1,1,2))}.play;
	a={Out.ar(5,LFPar.ar(1)|LFPar.ar(5)+RLPF.ar(x=Pan2.ar(InFeedback.ar(5),SinOsc.ar(5.5)),3e3,LFPar.ar(1/25)/2+1.7));x*LFPar.ar(99)}.play;
	16.wait;
	/*Synth(\osc, [\rel, 4,\freq, 41.midicps,\buf, ~wt_buf[3],\amp, 0.1,\out, 0]);
	0.25.wait;
	Synth(\osc, [\rel, 4,\freq, 53.midicps,\buf, ~wt_buf[3],\amp, 0.1,\out, 0]);
	0.25.wait;
	Synth(\osc, [\rel, 4,\freq, 57.midicps,\buf, ~wt_buf[3],\amp, 0.1,\out, 0]);
	0.25.wait;
	Synth(\osc, [\rel, 4,\freq, 64.midicps,\buf, ~wt_buf[3],\amp, 0.1,\out, 0]);
	0.25.wait;
	Synth(\osc, [\rel, 4,\freq, 67.midicps,\buf, ~wt_buf[3],\amp, 0.1,\out, 0]);
	1.wait;*/

	/*Pbindef(\hard_kick, \filterFreq, Pseries(200,10), \dur, Pseq([Pseq([0.25],56),Pseq([0.125],4)],inf), \f, Pstutter(6, Pexprand(50,100))).play(t);
	14.5.wait;
	Pbindef(\hard_kick).stop;
	1.5.wait;*/

	x.release;
	a.release;
	Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \dur, 0.25, \tlo,0.5).play(t);
	Pbindef(\chords).play(t);
	0.5.wait;
	Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \tlo, 0).play(t);
	31.wait;
	Pbindef(\hard_kick).stop;
	Pbindef(\chords).stop;
	1.wait;

	x = {b=LocalBuf(9e4,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(12,3e4,4e4)),9e4);BufWr.ar(Saw.ar([8,9]),b,i);(BufRd.ar(2,b,i)/2 )* 0.25}.play;
	1.wait;

	x.release;
	Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \dur, 0.25, \tlo,0.5).play(t);
	Pbindef(\chords).play(t);
	Pbindef(\pad).play(t);
	Pbindef(\bass).play(t);
	Pbindef(\melody).play(t);
	Pbindef(\ambi).play(t);
	1.wait;
	Pbindef(\hard_kick, \filterFreq, 1550, \f, 50, \tlo, 0);
	31.wait;
	// add female_chorus
	Pbindef(\female_chorus).play(t);
	31.75.wait;
	Pbindef(\female_chorus).stop;
	Pbindef(\hard_kick).stop;
	Pbindef(\chords).stop;
	Pbindef(\pad).stop;
	Pbindef(\bass).stop;
	Pbindef(\melody).stop;
	Pbindef(\ambi).stop;
	0.25.wait;

	Pbindef(\chords, \amp, Pseq([Pgeom(0.15,-1.dbamp,4)],inf)).play(t);
	Pdef(\hard_rhythms).play(t);
	Pbindef(\pad).play(t);
	Pbindef(\melody).play(t);
	Pbindef(\ambi).play(t);
	Pbindef(\bass,
		\dur, 0.25,
		\midinote, Pseq([
			Pn([53 - 24],64),
			Pn([50 - 24],64),
			Pn([58 - 24],64),
			Pn([43 - 12],64),
	],inf)).play(t);
	64.wait;

	x = Synth(\distortion, [\amp, 0.2,\amount, 0.5]);
	32.wait;

	x.set(\amount, 0.99,\amp, 0.2);
	32.wait;

	x.free;
	Pbindef(\chords).stop;
	8.wait;
	Pbindef(\bass).stop;
	Pdef(\hard_rhythms).stop;
	8.wait;
	Pbindef(\pad).stop;
	Pbindef(\melody).stop;
	Pbindef(\ambi).stop;
	8.wait;
	// s.stopRecording;
}.fork;
)

s.plotTree;