j = (
Pbindef(\bass,
		\instrument, \osc,
		\dur, 0.5,
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
	)
);

v.stop;

j.stop;

s.plotTree;

(
d
d.play(TempoClock.new(120/60), quant: 1);
)

d.stop

// -----------------------------------------------------------------
// score.
// -----------------------------------------------------------------

z = j.asScore(16.0);
z.play(clock:TempoClock.new(120/60), quant:1 );



(
// TempoClock.default.tempo = 2;
c = Ppar([Pbindef(\testnrt,
	\instrument, \gabber,
	\dur, 0.25,
	\out, 0,
),

 Pbindef(\tttt,
	\instrument, \kick,
	\dur, 0.35,
	\amp, 0.25,
	\out, 0,
)]);
// n.render("~/Desktop/nnnn.aif".standardizePath, 4.0);
// c.stop;
// c.render("~/Desktop/nnnn.aif".standardizePath, 4.0);
)

Pbindef(\tttt).stop;
n.play;


z = c.asScore(4.0);


z.render("~/Desktop/ddddtfdf.aif".standardizePath, 4.0);

Score.recordNRT(p,"~/nrt-test", Platform.defaultTempDir ++ "helpNRT.aiff", options: o); // synthesize

o = ServerOptions.new.numOutputBusChannels = 2; // mono output
Score.recordNRT(g, "/tmp/help-oscFile", "~/Desktop/helpNRT.aiff".standardizePath, options: o); // synthesize



// ---

(
r = Pbindef(\testnrt,
	\instrument, \gabber,
	\dur, 0.25,
	\out, 0,
);

v = Pbindef(\tttt,
	\instrument, \osc,
	\dur, 10,
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
	\out, 0,
	\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
	// \rsend, -10,
);
// SynthDescLib.read;
/*
;
Pbindef(\tttt).play;*/
// x.add([0.0, [\d_recv, SynthDescLib.global[\default].def.asBytes]]);
v.clock = 4;
d = v.asScore(10, timeOffset: 0.001);
// v.asScore(10, timeOffset: 0.001);

d.score.postcs;
// d.play;
// d.stop;


/*d.recordNRT(
	outputFilePath: "~/Desktop/nrt.aiff".standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: ServerOptions.new.numOutputBusChannels_(2),
	duration: 10
);*/
//
// v.recordNRT(
// 	outputFilePath: "~/Desktop/nrt2.aiff".standardizePath,
// 	sampleRate: 44100,
// 	headerFormat: "AIFF",
// 	sampleFormat: "int16",
// 	options: ServerOptions.new.numOutputBusChannels_(2),
// 	duration: 10
// );
)

Pbindef(\hard_kick).play(t);
// this works fine.
(
[ 45, 59, 61, 68 ].midicps.do{arg n;
	Synth.new(\osc, [
		\atk, 4,
		\rel, 4,
		\freq, n,
		\buf, 1,
		\amp, 0.1,
		\out, 0
])}
)

~wt_buf.do(_.free);
~wt_nrtbuf.do(_.free);

Server.local = Server(\nrt);
s = Server.local;
Server.internal;
Server.default;

a = Synth(\osc);
NodeWatcher.register(a,true);

s.plotTree;

Server.all;

Server.quitAll;

SynthDescLib.global.read().browse;



~wt_buf.do(_.query);

~wt_nrtbuf = Buffer.allocConsecutive(10, s, 2048, 1, {
		arg buf, index;
		buf.setnMsg(0, ~wt_sig[index].asWavetable);
	});

// render NRT.
(
var pat1 = Score([
	[0.0,(x = Synth.basicNew(\osc, s)).newMsg(args: [freq: 45.midicps, buf: ~wt_buf[1], dur: 2, atk: 4, rel: 8])],
	[0.0,(x = Synth.basicNew(\osc, s)).newMsg(args: [freq: 59.midicps, buf: ~wt_buf[1], dur: 2, atk: 4, rel: 8])],
	[0.0,(x = Synth.basicNew(\osc, s)).newMsg(args: [freq: 61.midicps, buf: ~wt_buf[1], dur: 2, atk: 4, rel: 8])],
	[0.0,(x = Synth.basicNew(\osc, s)).newMsg(args: [freq: 68.midicps, buf: ~wt_buf[2], dur: 2, atk: 4, rel: 8])],
	[8, [\c_set, 0, 0]]
]);
pat1.play;
)

[ 0, Buffer( nil, 2048, 1, 0 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 0 ].asWavetable) } ) ]


~arr = Array.new
~wt_nrt = Array.new

~arr.clean

Buffer.free

b
c

(
var pat1 = Score([
	[0.0, b=Buffer.new( nil, 2048, 1, 0 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 0 ].asWavetable) } ) ],
	[0.0, c=Buffer.new( nil, 2048, 1, 1 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 6 ].asWavetable) } ) ],
	[0.0, d=Buffer.new( nil, 2048, 1, 2 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 3 ].asWavetable) } ) ],
	[0.0, (x = Synth.basicNew(\osc, s)).newMsg(args: [freq: 52.midicps, buf:2, dur: 2, atk: 4, rel: 8])],
	[8, [\c_set, 0, 0]]
]);

pat1.play;

/*pat1.recordNRT(
	outputFilePath: "~/Desktop/NRT.wav".standardizePath,
	options: ServerOptions.new.numOutputBusChannels_(2),
	duration: 16,
	);*/
)

s.plotTree


Server.allRunningServers


(


g = Score([
	[0.1,[\s_new, \varsawPerc, 1001, 0, 0, \freq, 45.midicps, \detune, 0.1, \amp, 0.5, \lpfMul, 0, \lpfAdd, 400, \atk, 4, \rel, 4]],
	[16, [\c_set, 0, 0]]
]);

g.postcs;

g.recordNRT(
	outputFilePath: "~/Desktop/nrt.aiff".standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: ServerOptions.new.numOutputBusChannels_(2),
	duration: 16,
	action: { "done".postln };
);
)



// backup

(
var pat1;
pat1 = Score([
	[0.1,
		[\s_new, \osc, 1001, 0, 0, \freq, 45.midicps, \atk, 4,\rel, 8,\buf, ~wt_buf[1],\amp, 0.2,\out, 0],
		[\s_new, \osc, 1002, 0, 0, \freq, 59.midicps, \atk, 4,\rel, 8,\buf, ~wt_buf[1],\amp, 0.2,\out, 0],
		[\s_new, \osc, 1003, 0, 0, \freq, 61.midicps, \atk, 4,\rel, 8,\buf, ~wt_buf[1],\amp, 0.2,\out, 0],
	],
	[4, [\c_set, 0, 0]] // finish
]);

pat1.postcs;

pat1.recordNRT(
	outputFilePath: "~/Desktop/NRT00.wav".standardizePath,
	sampleRate: 44100,
	headerFormat: "wav",
	sampleFormat: "int16",
	options: ServerOptions.new.numOutputBusChannels_(2),
	duration: 4,
	action: { "done".postln };
);
)