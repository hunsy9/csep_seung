<template>
  <div class="home-family-site-banner-box">
    <h3>
      {{ $t('m.FamilySites') }}
    </h3>
    <div class="home-family-site-banner-content-wrapper">
      <template v-for="(item) in FamilySiteContentSrc">
        <FamilySiteContent :content="item"/>
      </template>
    </div>
  </div>
</template>

<script>
import FamilySiteContent from "./FamilySiteContent.vue";
import {FamilySiteContentSrc} from "../../../../../utils/constants";

export default {
  name: 'HomeFamilySiteBanner',
  computed: {
    FamilySiteContentSrc() {
      return FamilySiteContentSrc
    }
  },
  components: {FamilySiteContent},
}
</script>

<style scoped lang="less">
.home-family-site-banner-box {
  width: 100%;
  float: right;
  margin-top: 20px;
  padding: 20px;

  border-radius: 7px;
  margin-bottom: 20px;
  background-color: #F3F6FF;
  overflow: hidden;
  border: 1px solid #DEDEDE;

  h3 {
    font-size: 18px;
    font-weight: 700;
    color: var(--ps-content-text-color)
  }
  .home-family-site-banner-content-wrapper{
    padding-left: 20px;
    display: flex;
    justify-content: space-between;
  }
}
</style>
