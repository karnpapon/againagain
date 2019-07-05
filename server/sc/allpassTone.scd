SynthDef('allpassTone', { arg freq, ffreq, pan=0, gate, out=0;
    var sig, env;
    env = EnvGen.kr( Env.adsr(releaseTime:2), gate: gate, levelScale: 0.3, doneAction: 2 );
    sig = RLPF.ar(
        LFSaw.ar( Lag.kr(freq, 0.5), mul: env ),
        LFNoise1.kr(1, 36, 110).midicps,
        0.1
    );
    sig = Pan2.ar(sig, pan);
    6.do({ sig = AllpassN.ar(sig, 0.05, [0.05.rand, 0.05.rand], 4) });
    Out.ar(out, sig);
});
