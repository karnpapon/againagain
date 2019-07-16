(
var pat1;
var nrt_buff1,nrt_buff2,nrt_buff3,nrt_buff4,nrt_buff5,nrt_buff6,nrt_buff7,nrt_buff8,nrt_buff9,nrt_buff10;
var arr=Array.new;

pat1 = Score([
	// load buffer.
	// [0.0, 10.do({ arg num; arr = arr.add(Buffer(nil,2048, 1, num)); })],
	// [0.0, ~nrt_buff = arr.collect({ arg ar, idx;  ar.allocMsg({ arg buf; buf.setnMsg(0, ~wt_sig[ idx ].asWavetable); }) }) ],
	[0.0, nrt_buff1=Buffer( nil, 2048, 1, 0 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 0 ].asWavetable) } ) ],
	[0.0, nrt_buff2=Buffer( nil, 2048, 1, 1 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 1 ].asWavetable) } ) ],
	[0.0, nrt_buff3=Buffer( nil, 2048, 1, 2 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 2 ].asWavetable) } ) ],
	[0.0, nrt_buff4=Buffer( nil, 2048, 1, 3 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 3 ].asWavetable) } ) ],
	[0.0, nrt_buff5=Buffer( nil, 2048, 1, 4 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 4 ].asWavetable) } ) ],
	[0.0, nrt_buff6=Buffer( nil, 2048, 1, 5 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 5 ].asWavetable) } ) ],
	[0.0, nrt_buff7=Buffer( nil, 2048, 1, 6 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 6 ].asWavetable) } ) ],
	[0.0, nrt_buff8=Buffer( nil, 2048, 1, 7 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 7 ].asWavetable) } ) ],
	[0.0, nrt_buff9=Buffer( nil, 2048, 1, 8 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 8 ].asWavetable) } ) ],
	[0.0, nrt_buff10=Buffer( nil, 2048, 1, 9 ).allocMsg( { arg buf; buf.setnMsg(0, ~wt_sig[ 9 ].asWavetable) } ) ],
]);

[45, 59, 61, 68].midicps.do{ arg n; pat1.add([0.5, Synth.basicNew(\osc, s).newMsg(args: [freq: n, buf: 3, dur: 2, atk: 4, rel: 8])]);};
[44, 59, 63, 66].midicps.do{ arg n; pat1.add([8, Synth.basicNew(\osc, s).newMsg(args: [freq: n, buf: 3, dur: 2, atk: 4, rel: 8])]);};
[43, 55, 57, 59, 64].midicps.do{ arg n;pat1.add([16, Synth.basicNew(\osc, s).newMsg(args: [freq: n, buf: 3, dur: 2, atk: 4, rel: 8])]);};
[42, 54, 59, 61, 63].midicps.do{ arg n;pat1.add([24, Synth.basicNew(\osc, s).newMsg(args: [freq: n, buf: 3, dur: 2, atk: 4, rel: 8])]);};


x = Pbindef(\hard_kick,
		\instrument, \gabber,
		\dur, Pseq([
			Pseq([0.25],16),
			Pseq([0.25],16),
			Pseq([0.25],16),
			Pseq([0.125],4),
		],8),
		\amp, 0.1,
		\rel, 1,
		\out, ~mbus
).asScore(8);

pat1.add([2, x.play ]);

pat1.add([64, [\c_set, 0, 0]]);

// pat1.play;

pat1.recordNRT(
	outputFilePath: "~/Desktop/NRT.wav".standardizePath,
	options: ServerOptions.new.numOutputBusChannels_(2),
	duration: 32,
);
)

Pbindef(\hard_kick,
		\instrument, \gabber,
		\dur, Pseq([
			Pseq([0.25],16),
			Pseq([0.25],16),
			Pseq([0.25],16),
			Pseq([0.125],4),
		],inf),
		\amp, 0.1,
		\rel, 1,
		\out, ~mbus
	).play(t, quant: 1);

Pbindef(\hard_kick).stop;

s.plotTree

