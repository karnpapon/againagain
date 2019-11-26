<template>
  <div class="footer-container">
    <div class="wrapper">
      <div class="details">
        <p class="underline">
          <a target="blank" href="https://supercollider.github.io/">SuperCollider</a>
        </p>and
        <p class="underline">
          <a target="blank" href="https://vuejs.org/">Vue.js</a>
        </p>and
        <p class="underline">
          <a target="blank" href="https://github.com/charlieroberts/marching">marching.js</a>
        </p>
        are integrated for this project.
      </div>
      <div class="credits">
        <span class="icon">
          <a target="blank" href="https://github.com/karnpapon/againagain">
            <i class="fab fa-github"></i>
          </a>
        </span>
        <!-- <span class="icon">
          <a target="blank" href="https://www.youtube.com/user/CadsonDemak">
            <i class="fab fa-youtube"></i>
          </a>
        </span> -->
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Footer",
  data() {
    return {};
  },
  methods: {},
  components: {}
};
</script>

<style scoped lang="scss">
@import "../assets/styles/_base.scss";

.footer-container {
  width: 100%;
  border-top: 1px solid white;
  padding: 20px;
  z-index: 5;
  margin-top: auto;
}

.footer-details {
  color: white;
}

.wrapper {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-between;
}

.details {
  display: flex;
  font-weight: bold;
  :hover {
    cursor: pointer;
    color: $main-colorize-color;
  }
}

.underline {
  text-decoration: underline;
  margin: 0 5px;
  a{ color: white;};

  :hover {
    color: $main-colorize-color !important;
  }

  :visited {
    color: white;
  }
}

.credits {
  text-align: end;
  align-items: center;
  display: flex;
  p {
    margin: unset;
  }

  :hover {
    color: $main-colorize-color;
  }
}

.icon {
  font-size: 20px;
  margin: 0 5px;
}
</style>
