/**
 * Define functions to handle websocket messages.
 *
 * The functions are exported at the bottom of this file as
 * `socketEventHandlers`
 *
 * Each of those functions are registered as event handlers
 * for websocket messages.
 *
 * You implement a function here (eg. `noteOn` below)
 *
 * The client (in the browser) calls:
 *
 *    socket.emit(noteOn, {x: 0.5, y: 0.3});
 *
 * and the `noteOn` is called here with the socket
 * (for an invidual connected user),
 * and the data object that the client sent with `.emit`
 *
 * In these handlers you can respond back to the client with:
 *
 *    socket.emit('name', returnData);
 *
 * or broadcast to all connected clients with:
 *
 *    socket.broadcast.emit('name', returnData);
 *
 * The client then needs to register a handler for 'name'.
 */

import { resolve } from "path";
import { server, map, msg, lang } from "supercolliderjs";

const context = {
  users: {}
};

export function bootServer() {
  return server.boot({ numInputBusChannels: 0 }).then(s => {
    lang.boot({ debug: false }).then(function(sclang) {
      context.lang = sclang;

      sclang
        .executeFile(resolve(__dirname, "./sc/init.scd"))
        .then(function(answer) {
          console.log("init = " + answer);
        }, console.error);
    });

    // context.server = s;

    // let { allpassTone, verb, distortion, master, kick , player } = context.server.synthDefs({
    //   allpassTone: {
    //     path: resolve(__dirname, './sc/allpassTone.scd')
    //   },
    //   kick: {
    //     path: resolve(__dirname, './sc/kick.scd')
    //   },
    //   player: {
    //     path: resolve(__dirname, './sc/player.scd')
    //   },
    //   verb: {
    //     path: resolve(__dirname, './sc/verb.scd')
    //   },
    //   distortion: {
    //     path: resolve(__dirname, './sc/distortion.scd')
    //   },
    //   master: {
    //     path: resolve(__dirname, './sc/master.scd')
    //   },
    // });

    // context.bus = context.server.audioBus(2);
    // context.spawnGroup = context.server.group();
    // context.rbus = context.server.audioBus(2);
    // context.dbus = context.server.audioBus(2);

    // context.allpassTone = allpassTone
    // context.kick = kick
    // context.player = player
    // context.distortion = distortion
    // context.verb = verb
    // context.master = master

    // context.server.synth(context.distortion, {in: context.bus.id, out: context.bus.id });
    // context.server.synth(context.verb, {in: context.rbus.id, out: context.bus.id });
    // context.server.synth(context.master, { in: context.bus.id, out: 0 }, -1, msg.AddActions.TAIL);
  });
}

function connect(socket) {
  console.log(`Connecting user ${socket.id}`);
  context.users[socket.id] = {};
}

function disconnect(socket) {
  let user = context.users[socket.id];
  if (user) {
    // releaseSynth(user);
    // remove user
    delete context.users[socket.id];
    context.lang.write(`
      Pbindef(\\main_kick).stop;
      Pbindef(\\pad).stop;
      Pbindef(\\chords).stop;
      Pbindef(\\melodyhook).stop;
      Pdef(\\rhythms).stop;
      Pbindef(\\bass).stop;
    `);
    console.log(`Removing user ${socket.id}`);
  }
}

const freqMap = map.exp({ minval: 100, maxval: 5000 });
const panMap = map.linear({ minval: -1, maxval: 1 });

function playPattern(socket, data) {
  console.log("data = ", data);
  switch (data) {
    case "main_kick":
      context.lang.write(`
        Pbindef(\\main_kick,
          \\instrument, \\kick,
          \\dur, Pseq([Pseq([1,1,1,0.75],1),Pseq([1.25,1,1,0.75],inf)],inf),
          \\freq, Pstutter(16,Pexprand(1000,20000,inf)),
          \\detune, 0,
          \\buf, Pstutter(16, Prand(~wt_buf[0..9],inf)),
          \\atk, 0,
          \\sus, 0,
          \\rel, Pexprand(0.02,0.04),
          \\c1, -4,
          \\amp, 0.5,
          \\pan, Pseq([1,-1],inf),
          \\out, 0,
          \\rout, ~dbus,
          \\rsend, -30,
        ).play(t, quant: 1);
      `);
      break;

    case "bass":
      context.lang.write(`
        Pbindef(\\bass,
          \\instrument, \\osc,
          \\dur, 0.5,
          \\atk, 0.001,
          \\sus, 0,
          \\rel, 0.5,
          \\c0, 0,
          \\detune, 0.18,
          \\c1, Pwhite(5,10).neg, //brightness
          \\buf, Prand(~wt_buf[4..9], inf),
          \\midinote, Pseq([
            Pn([53 - 24],32),
            Pn([50 - 24],32),
            Pn([58 - 24],32),
            Pn([43 - 12],26),
            Pn([48 - 12],6),
          ],inf),
          \\amp, 0.3,
          \\pan, Pwhite(0.01,0.3) * Pseq([1,-1],inf),
          \\out, 0,
          \\rout, ~rbus,
          \\rsend, -20,
        ).play(t, quant:1);
      `);
      break;

    case "pad":
      context.lang.write(`
        Pbindef(\\pad,
          \\instrument, \\osc,
          \\dur, Pseq([Prand([2,4,16,8])],inf),
          \\atk, 0.4,
          \\sus, 0,
          \\rel, 0.25,
          \\c0, Pexprand(1,2),
          \\c1, Pexprand(1,2).neg,
          \\detune, Pfunc({rrand(0.15,0.4)}!3),
          \\buf, Prand(~wt_buf[0..3], inf),
          \\degree, 4,
          \\midinote, 48 + 12,
          \\amp, 0.35,
          \\pan, Pwhite(-0.4,0.4),
          \\out, 0,
          \\rsend, -10,
        ).play(t, quant: 1);
      `);
      break;

    case "chords":
      context.lang.write(`
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
      `);
      break;

    case "melodyhook":
      context.lang.write(`
        Pbindef(\\melodyhook,
          \\instrument, \\osc,
          \\dur, Pseq([
            Pseq([0.5,0.5,0.25,0.5,0.25]), 
            Pseq([0.75,0.5, 0.25, 0.5]) 
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
      `);
      break;
    case "rhythms":
      context.lang.write(`
        Pdef(\\rhythms,
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
	).play(t, quant: 1);
      `);
      break;
  }

  // let synth = context.server.synth(context.allpassTone, {
  //   freq: freqMap(data.y),
  //   ffreq: freqMap(data.x),
  //   out: context.rbus.id,
  //   pan: panMap(data.x),
  //   gate: 1
  // }, context.spawnGroup);

  // let synth = context.server.synth(context.player, {
  //   out: 0
  // }, context.spawnGroup)

  // context.users[socket.id].synth = synth;
}

function stopPattern(socket, data) {
  switch (data) {
    case "main_kick":
      context.lang.write(`Pbindef(\\main_kick).stop;`);
      break;
    case "pad":
      context.lang.write(`Pbindef(\\pad).stop;`);
      break;
    case "chords":
      context.lang.write(`Pbindef(\\chords).stop;`);
      break;
    case "melodyhook":
      context.lang.write(`Pbindef(\\melodyhook).stop;`);
      break;
    case "rhythms":
      context.lang.write(`Pdef(\\rhythms).stop;`);
      break;
    case "bass":
      context.lang.write(`Pbindef(\\bass).stop;`);
      break;
  }
  // let user = context.users[socket.id];
  // if (user) {
  //   releaseSynth(user);
  // }
}

// function noteSlide(socket, data) {
//   console.log("noteSlide", data);
//   let user = context.users[socket.id];
//   if (user && user.synth) {
//     user.synth.then(syn => {
//       syn.set({
//         freq: freqMap(data.y),
//         ffreq: freqMap(data.x),
//         pan: panMap(data.x)
//       });
//     });
//   }
// }

// function releaseSynth(user) {
//   if (user.synth) {
// What was stored is a `Promise` for a `Synth`,
// so use `.then` to get the resolved actual `Synth`.

// This would immediately kill the synth:
// synth.then((syn) => syn.free());

// This will set the gate to 0 which will release the `EnvGen`
// (envelope generator). Then the `Synth` will free itself
// because its `doneAction` is 2 — free the `Synth` when `EnvGen`
// is done.
//     user.synth.then(syn => syn.set({ gate: 0 }));
//     delete user.synth;
//   }
// }

export const socketEventHandlers = {
  connect,
  disconnect,
  playPattern,
  stopPattern
  // noteSlide
};
