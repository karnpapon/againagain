SynthDef('master', {
		arg in, gate=1, out=0;
		var input = In.ar(in, 2);
		var shaped = Compander.ar(input, input, -8.dbamp, 1, 0.75, 0.1, 0.3);
		var limited = Limiter.ar(shaped, -1.dbamp);
		var releaser = DetectSilence.ar(gate + input, doneAction: 2);
		Out.ar(out, limited);
	});