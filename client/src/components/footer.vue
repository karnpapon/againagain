<template>
  <div class="footer-container">
    <div class="wrapper">
      <div class="details">
        this project is integrating between
        <p class="underline">SuperCollider</p>and
        <p class="underline">Vue.js</p>
      </div>
      <div class="credits">
        <span class="icon">
          <a target="blank" href="https://github.com/karnpapon">
            <i class="fab fa-github"></i>
          </a>
        </span>
        <span class="icon">
          <a target="blank" href="https://github.com/karnpapon">
            <i class="fab fa-youtube"></i>
          </a>
        </span>
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
  :hover {
    cursor: pointer;
    color: $main-colorize-color;
  }
}

.underline {
  text-decoration: underline;
  margin: 0 5px;
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
