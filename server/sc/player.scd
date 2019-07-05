SynthDef(\player, {
		arg out = 0, buf = 0, rate = 1, start=0, mul = 1,rout=0, rsend=(-20);
		// rate = LFNoise2.kr(XLine.kr(1, 20, 60), 2);
		Out.ar(out,PlayBuf.ar(2,buf,BufRateScale.kr(buf)*rate,startPos: start, doneAction: Done.freeSelf)*mul);
	}).add;