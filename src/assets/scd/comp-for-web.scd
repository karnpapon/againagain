
(
{
	s.record(path: "~/Desktop/stems-for-web/gkick02.wav".standardizePath);
	Pdef(\hard_rhythms).play(t);
	64.wait;
	s.stopRecording;
}.fork;
)

	// Pbindef(\bass).stop;
	//
	// Pbindef(\fsaw).play(t);
	// x.release;
	// 15.875.wait;
	//
	// Pbindef(\fsaw).stop;
	// 0.125.wait;
	//
	//
	// Pbindef(\normal_kick).stop;
	// Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \dur, 0.25, \tlo,0.5).play(t);
	// Pbindef(\chords,\atk, 0.001,\buf, ~wt_buf[6],\amp, Pseq([Pgeom(0.25,-2.dbamp,1)],inf) * 0.4).play(t);
	// 0.5.wait;
	// Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \tlo, 0).play(t);
	// 31.5.wait;
	// Pbindef(\hard_kick).stop;
	// Pbindef(\chords).stop;
	// Pbindef(\fsaw).stop;
	// 0.5.wait;
	//
	// x = {b=LocalBuf(90000.0,2).clear;i=Sweep.ar(BufRd.ar(2,b,Saw.ar(12,30000.0,40000.0)),90000.0);BufWr.ar(Saw.ar([8,9]),b,i);(BufRd.ar(2,b,i)/2 )* 0.25}.play;
	// 0.5.wait;
	//
	// Pbindef(\gt).play(t);
	// 0.5.wait;
	//
	// x.release;
	// Pbindef(\hard_kick, \filterFreq, 1000, \f, 50, \dur, 0.25, \tlo,0.5).play(t);
	// Pbindef(\chords, \midinote, Pseq([Pn([41,53,57,64,67],3),Pn(\,1),Pn([38,48,60,64,72],3),Pn(\,1)],inf)).play(t);
	// Pbindef(\pad).play(t);
	// Pbindef(\fsaw, \amp, 0.25, \filterFreqStart, 2000, \dur, Pseq([0.5], inf), \midinote, Pseq([Pn([53 - 12],32),Pn([50 - 12],32),Pn([58 - 12],32),Pn([43],32)],inf),\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf) ).play(t);
	// // Pbindef(\melody, \group, j, \rout, ~rbus, \amp, 0.1).play(t);
	// Pbindef(\bass).play(t);
	// Pbindef(\ambi, \group, k, \rout, ~dbus, \rsend, -20, \amp, 0.3).play(t);
	// 1.wait;
	// Pbindef(\hard_kick, \filterFreq, 1550, \f, 50, \tlo, 0);
	// 31.wait;
	// // add female_chorus
	// Pbindef(\chords, \amp, Pseq([Pgeom(0.25,-2.dbamp,1)],inf) * 0.55);
	// Pbindef(\female_chorus, \group, g, \rout, ~rbus).play(t);
	// 31.75.wait;
	//
	// Pbindef(\hard_kick).stop;
	// Pbindef(\chords).stop;
	// Pbindef(\pad).stop;
	// // Pbindef(\fsaw).stop;
	// Pbindef(\bass).play(t);
	// // Pbindef(\melody).stop;
	// Pbindef(\ambi).stop;
	// 0.25.wait;
	//
	// Pbindef(\chords, \amp, Pseq([Pgeom(0.15,-1.dbamp,4)],inf)).play(t);
	// Pdef(\hard_rhythms).play(t);
	// // Pbindef(\fsaw, \release, 0.125, \decay, 0.1, \dur, 0.5, \midinote, Pseq([Pn([53 - 12],64),Pn([50 - 12],64),Pn([58 - 12],64),Pn([43],64)],inf) ).play(t);
	// Pbindef(\bass,
	// 	\dur, 0.25,
	// 	\midinote, Pseq([
	// 		Pn([53 - 24],64),
	// 		Pn([50 - 24],64),
	// 		Pn([58 - 24],64),
	// 		Pn([43 - 12],64),
	// ],inf)).play(t);
	// Pbindef(\female_chorus).stop;
	// Pbindef(\pad).play(t);
	// Pbindef(\melody).play(t);
	// Pbindef(\ambi).play(t);
	// Pbindef(\fsaw).stop;
	// 32.wait;
	//
	// Pbindef(\gt).stop;
	// Pbindef(\fsaw, \amp, 0.53, \filterFreqStart, 1500, \dur, Pseq([0.25], inf), \midinote, Pseq(~parser.asMidi("f3 a3 f4 e4 c4 a3 c4 d4 g3 c4 a3 d3"), inf)).play(t);
	// 32.wait;
	//
	// Pbindef(\fsaw,\filterFreqStart, 500);
	// Pbindef(\male_vox, \group, g, \rout, ~rbus).play(t);
	// 64.wait;
	//
	// x.free;
	// Pbindef(\bass).stop;
	// Pdef(\hard_rhythms).stop;
	// Pbindef(\pad).stop;
	// Pbindef(\melody).stop;
	// 16.wait;
	// Pbindef(\fsaw).stop;
	// Pbindef(\chords).stop;
	// Pbindef(\ambi).stop;
	// 16.wait;
	// Pbindef(\male_vox).stop;
	// 4.stop;

s.plotTree;