SynthDef(\distortion) { |in=0, out=0, amount=0.99, amp=0.07|
  var input, amCoef, newOut;
  amCoef= 2*amount/(1-amount);
  input = HPF.ar(In.ar(in, 2), 400)*5;
  newOut = MidEQ.ar(LPF.ar((1+amCoef)*input/(1+(amCoef*input.abs)), [3800, 3900])*0.5, 120, 0.7, 8);
  Out.ar(out, newOut * amp);
};