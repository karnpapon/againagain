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
	\dur, 4,
	\atk, 0.001,
	\sus, 0.5,
	\rel, 3,
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
	\amp, Pseq([Pgeom(0.11,-2.dbamp,1)],inf),
	\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
	// \out, ~mbus,
	// \rout, ~rbus,
	\rsend, -15,
);

// Pbindef(\chords).play(t,quant:1);
// Pbindef(\ambi, \dur, 4,\rel, 4, \midinote, Pseq([Prand([57,53,48,50])],inf)).play(t, quant:1);
// Pbindef(\normal_kick, \rel, 1, \dur, Pseq([0.5,3.5],inf)).play(t, quant:1);

// 57,57,57,53,53,48,50,48,50

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

Pbindef(\stretch_female,
	\instrument, \stretchedFragments,
    \bufnum, ~pbfmmono,
    \start, Pwhite(0, (~pbfmmono.numFrames * 0.7).asInteger, inf),
    \delta, Pexprand(0.2, 1.5, inf),
    \time, Pkey(\delta),
    \stretch, Pexprand(1.0, 4.0, inf),
    \amp, 0.5,
    \attack, 0.1,
    \decay, 0.01
);

// Pbindef(\male_vox).play(t);

Pbindef(\female_chorus,
	\instrument, \player,
	\dur, 16,
	\mul, 2.25,
	\rate, 1,
	\buf, ~pbfm,
	\out, ~mbus,
);

Pbindef(\male_vox,
	\instrument, \player,
	\dur, 16,
	\mul, 0.25,
	\buf, Pseq([
		// Pseq([~pbm, ~pbm2]),
		Pseq([~pbm]),
	],inf),
	\out, ~mbus,
);


Pbindef(\gt,
	\instrument, \player,
	\dur, 8,
	\mul, 1.25,
	\buf, ~pbgt,
	\out, 0,
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
	\c0, -1,
	\c1, -3,
	\detune, 0.2,
	\buf, Prand(~wt_buf[4..9], inf),
	\midinote, Pseq([39+2,51+2,55+2,62+2,65+2]+ 12,inf),
	\amp, 0.1,
	\rout, ~rbus,
);

// Pbindef(\melody).play;


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
	\amp, 0.2,
	// \out, ~dbus,
	\rout, ~rbus,
	\rsend, -10,
);

Pbindef(\fsaw,
	\instrument, \fatsaw,
	\amp, 0.6,
	\attack, 0.01,
	\decay, 0.3,
	\sustain, 0.1,
	\release, 0.4,
	\time, Ptime(inf),
	\filterFreqStart, 300,
	// \resonance, Pfunc({ |ev| ev['time'].linexp(0,10,1,0.2); }),
	\midinote, Pseq(~parser.asMidi("f3 a3 f4 e4 c4 a3 c4 d4 g3 c4 a3 d3"), inf),
	\dur, 0.25,
	\out, ~mbus
);

// Pbindef(\fsaw).play(t);

Scale.directory;

///////////////////
///// RYTHMIC /////
///////////////////

Pbindef(\normal_kick,
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
	\dur, Pseq([0.25], inf),
	\amp, 0.1,
	\rel, 1,
	\tlo, 0,
	\thigh, 0.5,
	\out, ~mbus
);

Pbindef(
	\deter_rand_kick,
	\type, \phrase,
	\instrument, \deter_rand_beats,
	\dur, 2
);

Pdef(\deter_rand_beats, {
	Pbind(
		\instrument, \gabber,
		\dur, Pkey(\dur) / 8 * Pseq([1,Pconst(8, Prand([0.25, 0.5, 0.75], inf))]).trace,
	)
});


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
);

g = Group.new;
h = Group.new;
k = Group.new;
j = Group.new;
)

s.meter

// Pbindef(\ambi, \out, ~dbus);
// Pbindef(\female_chorus, \group, g)
// Pbindef(\female_chorus, \rout, ~rbus)
// Pbindef(\chords, \rout, 0)

///////////////////
/// COMPOSITION ///
///////////////////
(
s.record(path: "~/Desktop/out.wav".standardizePath);
{
	// 2.wait;
	x={FreeVerb.ar(CombN.ar(VarSaw.ar(LFSaw.ar(32,0,12,8),0,LFSaw.ar([18,12],0,1/64,1/64)).sin/2,1,1,2))}.play;
	Pbindef(\normal_kick, \amp, 0.5, \rel, 1, \dur, Pseq([0.5,3.5],inf)).play(t, quant:1);
	8.wait;
	Pbindef(\chords,
		\atk, 4,
		\group, h,
		\rout, ~rbus,
		\amp, Pseq([Pgeom(0.12,-2.dbamp,1)] * 0.5,inf),
		\midinote, Pseq([
		Pn([41,53,57+12,64,67] - 24,3),
		Pn(\,1),
		Pn([38,48+12,60+[12,0,24].choose,64,72] - 24,3),
		Pn(\,1),
	],inf)).play(t);
	30.wait;

	Pbindef(\chords).stop;
	2.wait;

	Pbindef(\fsaw).play(t);
	x.release;
	15.875.wait;

	Pbindef(\fsaw).stop;
	0.125.wait;

	Pbindef(\fsaw, \filterFreqStart, 1000).play(t);
	Pbindef(\normal_kick).stop;
	Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \dur, 0.25, \tlo,0.5).play(t);
	Pbindef(\chords,\atk, 0.001,\buf, ~wt_buf[6],\amp, Pseq([Pgeom(0.25,-2.dbamp,1)],inf) * 0.4).play(t);
	0.5.wait;
	Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \tlo, 0).play(t);
	31.5.wait;
	Pbindef(\hard_kick).stop;
	Pbindef(\chords).stop;
	Pbindef(\fsaw).stop;
	0.5.wait;

	x = {b=LocalBuf(90000.0,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(12,30000.0,40000.0)),90000.0);BufWr.ar(Saw.ar([8,9]),b,i);(BufRd.ar(2,b,i)/2 )* 0.25}.play;
	0.5.wait;

	Pbindef(\gt).play(t);
	0.5.wait;

	x.release;
	Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \dur, 0.25, \tlo,0.5).play(t);
	Pbindef(\chords, \midinote, Pseq([Pn([41,53,57,64,67],3),Pn(\,1),Pn([38,48,60,64,72],3),Pn(\,1)],inf)).play(t);
	Pbindef(\pad).play(t);
	Pbindef(\fsaw, \amp, 0.25, \filterFreqStart, 2000, \dur, Pseq([0.5], inf), \midinote, Pseq([Pn([53 - 12],32),Pn([50 - 12],32),Pn([58 - 12],32),Pn([43],32)],inf),\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf) ).play(t);
	// Pbindef(\melody, \group, j, \rout, ~rbus, \amp, 0.1).play(t);
	Pbindef(\bass).play(t);
	Pbindef(\ambi, \group, k, \rout, ~dbus, \rsend, -20, \amp, 0.3).play(t);
	1.wait;
	Pbindef(\hard_kick, \filterFreq, 1550, \f, 50, \tlo, 0);
	31.wait;
	// add female_chorus
	Pbindef(\chords, \amp, Pseq([Pgeom(0.25,-2.dbamp,1)],inf) * 0.55);
	Pbindef(\female_chorus, \group, g, \rout, ~rbus).play(t);
	31.75.wait;

	Pbindef(\hard_kick).stop;
	Pbindef(\chords).stop;
	Pbindef(\pad).stop;
	// Pbindef(\fsaw).stop;
	Pbindef(\bass).play(t);
	// Pbindef(\melody).stop;
	Pbindef(\ambi).stop;
	0.25.wait;

	Pbindef(\chords, \amp, Pseq([Pgeom(0.15,-1.dbamp,4)],inf)).play(t);
	Pdef(\hard_rhythms).play(t);
	// Pbindef(\fsaw, \release, 0.125, \decay, 0.1, \dur, 0.5, \midinote, Pseq([Pn([53 - 12],64),Pn([50 - 12],64),Pn([58 - 12],64),Pn([43],64)],inf) ).play(t);
	Pbindef(\bass,
		\dur, 0.25,
		\midinote, Pseq([
			Pn([53 - 24],64),
			Pn([50 - 24],64),
			Pn([58 - 24],64),
			Pn([43 - 12],64),
	],inf)).play(t);
	Pbindef(\female_chorus).stop;
	Pbindef(\pad).play(t);
	Pbindef(\melody).play(t);
	Pbindef(\ambi).play(t);
	Pbindef(\fsaw).stop;
	32.wait;

	Pbindef(\gt).stop;
	Pbindef(\fsaw, \amp, 0.53, \filterFreqStart, 1500, \dur, Pseq([0.25], inf), \midinote, Pseq(~parser.asMidi("f3 a3 f4 e4 c4 a3 c4 d4 g3 c4 a3 d3"), inf)).play(t);
	32.wait;

	Pbindef(\fsaw,\filterFreqStart, 500);
	Pbindef(\male_vox, \group, g, \rout, ~rbus).play(t);
	64.wait;

	x.free;
	Pbindef(\bass).stop;
	Pdef(\hard_rhythms).stop;
	Pbindef(\pad).stop;
	Pbindef(\melody).stop;
	16.wait;
	Pbindef(\fsaw).stop;
	Pbindef(\chords).stop;
	Pbindef(\ambi).stop;
	16.wait;
	Pbindef(\male_vox).stop;
	4.stop;
	s.stopRecording;
}.fork;
)

s.plotTree;