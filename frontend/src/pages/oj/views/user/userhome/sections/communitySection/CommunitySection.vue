<script>
export default {
  name : 'community-section',
  props: {
  }
}
</script>

<template>
  <section>
    <h1 class="main-title">커뮤니티</h1>
  </section>
</template>

<style scoped lang="less">
section {
  border : 1px solid #dedede;
  border-radius: 7px;
  transition : all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  padding : 20px;
  h1 {
    text-align : left;
    margin-bottom: 10px;
  }
}
</style>
