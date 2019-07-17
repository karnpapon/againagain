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
import { exerpedData } from '../client/src/data/exerpted.js'

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
      Pbindef(\\melody).stop;
      Pdef(\\rhythms).stop;
      Pbindef(\\bass).stop;
    `);
    console.log(`Removing user ${socket.id}`);
  }
}

const freqMap = map.exp({ minval: 100, maxval: 5000 });
const panMap = map.linear({ minval: -1, maxval: 1 });

function playPattern(socket, data) {
  switch (data) {
    case "main_kick":
      context.lang.write(exerpedData[0].exerpt);
      break;
    case "bass":
      context.lang.write(exerpedData[1].exerpt);
      break;
    case "pad":
      context.lang.write(exerpedData[2].exerpt);
      break;
    case "chords":
      context.lang.write(exerpedData[3].exerpt);
      break;
    case "melodyhook":
      context.lang.write(exerpedData[4].exerpt);
      break;
    case "rhythms":
      context.lang.write(exerpedData[5].exerpt);
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
      context.lang.write(`Pbindef(\\pad).stop; Pbindef(\\melody).stop; `);
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
