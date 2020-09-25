<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<style lang="scss">
#app {
  background-color: black;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

::-webkit-scrollbar {
  display: none;
}

html,
body {
  font-size: 14px !important;
  color: white;
  box-sizing: border-box !important;
  -webkit-font-smoothing: antialiased !important;
  margin: 0 !important;
  padding: 0 !important;
  height: 100% !important;
  width: 100% !important;
  -moz-osx-font-smoothing: grayscale !important;
  -webkit-font-smoothing: antialiased !important;
  /* font-smoothing: antialiased !important; */
}

* {
  box-sizing: border-box;
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

a, a:visited{
  color: white;
}

p,
h1,
i {
  color: white;
  font-weight: lighter;
}

pre {
  white-space: pre-wrap;
  word-wrap: break-word;
  padding: 20px;
  margin: unset;
}
</style>
