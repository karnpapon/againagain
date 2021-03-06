const exerpedData = [
  {
    title: "exerpt-00",
    def: "lpf_kick",
    path: "./stem-for-web/stem-for-web_nkick00.mp3",
    exerpt: `
      Pbindef(\\normal_kick,
      \\instrument, \\kick,
      \\dur, Pseq([Pseq([1,1,1,0.75],1),Pseq([1.25,1,1,0.75],inf)],inf),
      \\freq, Pstutter(16,Pexprand(1000,20000,inf)),
      \\detune, 0,
      \\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),
      \\atk, 0,
      \\sus, 0,
      \\filterFreq, Pseries(50,2, 100),
      \\rel, Pexprand(0.02,0.04),
      \\c1, -4,
      \\amp, 0.8,
      \\pan, Pseq([1,-1],inf),
      \\rsend, -30,
    );
    `
  },
  {
    title: "exerpt-00",
    def: "bass",
    path: "./stem-for-web/bass00-16bit.wav",
    exerpt:`
      Pbindef(\\bass,
       \\instrument,\\osc,
       \\dur, 0.25,
       \\atk, 0.001,
       \\sus, 0,
       \\rel, 0.5,
       \\c0, 0,
       \\detune, 0.18,
       \\c1, Pwhite(5,10).neg, //brightness
       \\buf, Prand(~wt_buf[4..9], inf),
       \\midinote, Pseq([
          Pn([53 - 24],64),
          Pn([50 - 24],64),
          Pn([58 - 24],64),
          Pn([43 - 12],64),
        ],inf),
       \\amp, 0.3,
       \\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
       \\out, 0,
       \\rout, ~rbus,
       \\rsend, -20,
      ).play(t, quant:1);
    `
  },
  {
    title: "exerpt-00",
    def: "chords",
    path: "./stem-for-web/stem-for-web_chd01.mp3",
    exerpt: `
    Pbindef(\\chords,
      \\instrument, \\osc,
      \\dur, 4,
      \\atk, 0.001,
      \\sus, 0.5,
      \\rel, Pseq([Prand([3,5])], inf),
      \\c0, 0,
      \\c1, Pwhite(1,10).neg,
      \\detune, 0.3,
      \\buf, Prand(~wt_buf[4..9], inf),
      \\midinote, Pseq([
        Pn([41,53,57,64,67],4),
        Pn([38,48,60,64,67],4),
        Pn([46,58,62,65,67],4),
        Pn([36,55,58,60,67],4),
      ],inf),
      \\amp, Pseq([Pgeom(0.1,-1.dbamp,4)],inf),
      \\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
      \\out, 0,
      \\rout, ~rbus,
      \\rsend, -10,
    ).play(t, quant:1);
    `
  },
  {
    title: "exerpt-00",
    def: "gtr",
    path: "./stem-for-web/stem-for-web_gtr00.mp3",
    exerpt: `
      Pbindef(\\synth_dec,
       \\instrument,\\osc,
       \\dur, Pseq([
          Pseq([0.5,0.5,0.25,0.5,0.25]), // 3.75
          Pseq([0.75,0.5, 0.25, 0.5]) // 4
        ],inf),
       \\atk, 0.001,
       \\sus, 0.05,
       \\rel, 1.55,
       \\c0, 2,
       \\c1, Pwhite(5,10).neg,
       \\detune, 0.13,
       \\buf, Prand(~wt_buf[4..9], inf),
       \\midinote, Pseq([Prand([57,57,57,53,53,48,50,48,50]) + Pwrand([0,12,-12,24,36],[9,21,2,13,10].normalizeSum)] ,inf),
       \\amp, 0.095,
       \\out,  0,
       \\rout, ~rbus,
       \\rsend, -20,
      ).play(t, quant:1);
    `
  },
  {
    title: "exerpt-00",
    def: "arppegg",
    path: "./stem-for-web/arp00-16bit.wav",
    exerpt: `
    Pbindef(\\arp,
    	\\instrument, \\fatsaw,
      \\amp, 0.6,
      \\attack, 0.01,
      \\decay, 0.3,
      \\sustain, 0.1,
      \\release, 0.4,
      \\time, Ptime(inf),
      \\filterFreqStart, 300,
      \\midinote, Pseq(~parser.asMidi("f3 a3 f4 e4 c4 a3 c4 d4 g3 c4 a3 d3"), inf),
      \\dur, 0.25,
      \\out, ~mbus
    ).play(t, quant: 1);
    `
  },
  {
    title: "exerpt-00",
    def: "rhythms",
    path: "./stem-for-web/stem-for-web_gkick00.mp3",
    exerpt: `
    Pdef(\\hard_rhythms,
		Pwrand([
			Pbind(
			\\instrument,\\osc,
			\\dur,Pseq([1/8],4),
			\\freq, Pstutter(4, Prand([
					Pexprand(10000,20000,1),
					Pexprand(100,200,1),
					Pexprand(1,2,1)
				],inf)),
			\\detune, 10,
			\\buf, Pstutter(4, Prand(~wt_buf[5..9],inf)),
			\\atk, 0,
			\\sus, 0,
			\\rel, Pstutter(8, Pexprand(0.01,0.06)),
			\\c1, exprand(8,20).neg,
			\\amp, Pgeom(0.9, -6.dbamp, 4) * Pstutter(4,Pexprand(0.3,1)),
			\\pan, Pwhite(-0.6,0.6),
			\\out, 0,
			\\rout, ~dbus,
			\\rsend, Pwhite(-30,-15),
			),

			Pbind(
			\\instrument,\\kick,
			\\dur, Pseq([1/4],2),
			\\freq, Pstutter(2, Pexprand(1,200)),
			\\detune, Pstutter(2, Pexprand(1,100)),
			\\buf, Pstutter(2, Prand(~wt_buf[8..9],inf)),
			\\atk, 0,
			\\sus, 0,
			\\rel, Pstutter(2, Pexprand(0.01,0.2)),
			\\c1, -10,
			\\amp, Pgeom(0.4, -3.dbamp, 2)  * Pexprand(0.4,1),
			\\out, 0,
			\\rout, ~dbus,
			\\rsend, Pwhite(-30,-15),
			),

			Pbind(
			\\instrument,\\osc,
			\\dur, Pseq([1/2,1/4,1/4],1),
			\\freq, Pstutter(6, Pexprand(1000,2000)),
			\\detune, 100,
			\\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),
			\\atk, 0,
			\\sus, Pseq([1/3,0,0],1),
			\\rel, Pseq([0,Pexprand(0.01,0.3,2)],1),
			\\c1, -12,
			\\amp, Pseq([0.1,0.5,0.3],1),
			\\out, 0,
			\\rout, ~rbus,
			\\rsend, Pwhite(-30,-18),
			),

			Pbind(
			\\instrument,\\kick,
			\\dur, Pseq([1/4,1/2,1/4],1),
			\\freq, Pstutter(6, Pexprand(100,2000)),
			\\detune, 100,
			\\buf, Pstutter(6, Prand(~wt_buf[2..5],inf)),
			\\atk, 0,
			\\sus, Pseq([0,1/3,0],1),
			\\rel, Pseq([Pexprand(0.01,0.3,1),0,Pexprand(0.01,0.3,1)],1),
			\\c1, -12,
			\\amp, Pseq([0.5,0.1,0.4],1),
			\\out, 0,
			\\rout, ~dbus,
			\\rsend, Pwhite(-30,-18),
			),

			Pbind(
			\\instrument,\\osc,
			\\dur, Pseq([1/6],6),
			\\freq, Pstutter(6, Pexprand(1,200)),
			\\detune, Pstutter(6, Pexprand(1,100)),
			\\buf, Pstutter(6, Prand(~wt_buf[8..9],inf)),
			\\atk, 0,
			\\sus, 0,
			\\rel, Pstutter(6, Pexprand(0.01,0.1)),
			\\c1, -10,
			\\amp, Pgeom(0.7, -4.dbamp, 6)  * Pexprand(0.4,1),
			\\out, 0,
			\\rout, ~dbus,
			\\rsend, Pwhite(-30,-18),
			),

			Pbind(
			\\instrument,\\kick,
			\\dur, Prand([
					Pseq([1/2],2),
					Pseq([1],2),
					Pseq([1,1/2,1/2],1),
					Pseq([2],1),
				],1),
			\\freq, Pstutter(2, Pexprand(1,200)),
			\\detune, Pstutter(2, Pexprand(1,100)),
			\\buf, Pstutter(2, Prand(~wt_buf[8..9],inf)),
			\\atk, 0,
			\\sus, 0,
			\\rel, Pstutter(2, Pexprand(0.01,0.2)),
			\\c1, -10,
			\\amp, 0.5,
			\\out, 0,
			\\rout, ~dbus,
			\\rsend, Pwhite(-20,-10),
			),

			Pbind(
			\\instrument,\\kick,
			\\dur, Prand([
					Pseq([1/16],16),
					Pseq([1/16],8)
				],1),
			\\freq, Pstutter(16,Pexprand(1000,20000,inf)),
			\\detune, 0,
			\\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),
			\\atk, 0,
			\\sus, 0,
			\\rel, Pexprand(0.02,0.04),
			\\c1, -4,
			\\amp, 0.13,
			\\pan, Pseq([1,-1],inf),
			\\out, 0,
			\\rout, ~dbus,
			\\rsend, -30,
			)
		],
		[40,18,3,3,15,25,5].normalizeSum, inf)
	).play(t, quant:1);
    `
  },
  
];

export { exerpedData };
