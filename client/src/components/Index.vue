<template>
<div class="container">
    <div class="row">
        <div class="col-lg-12 text-center">
            <h1 class="mt-5">SuperCollider development.</h1>
            <p class="lead">frontend with Vue.js.</p>
            <button 
              @mousedown="send('noteOn',5.0,5.0)" 
              @mouseup="send('noteOff', 5.0, 5.0)">
                test audio
            </button>
        </div>
    </div>
</div>
</template>

<script>
import io from 'socket.io-client';
const socket = io();
export default {
    name: 'Index',
    methods: {
      send(eventType, x, y) {
        console.log(eventType, x, y);
        socket.emit(eventType, {
            x: 0.5,
            y: 0.3
        });
      }
    },
}
</script>

<style scoped lang="scss">
h3 {
    text-align: center;
}
</style>
