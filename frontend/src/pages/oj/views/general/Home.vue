<template>
  <div class="mainBox">
    <div class="boxWrapper">
      <div class="left-container">
        <HomeBannerListBox/>
        <HomeNoticeBox/>
        <HomeProblemRecommendationBox/>
      </div>
      <div class="right-container">
        <HomeProfileBox/>
        <HomeRankingBox/>
        <Statistics/>
      </div>
    </div>
    <HomeStatusBox/>
    <HomeFamilySiteBanner/>
  </div>

</template>

<script>
/*eslint-disable*/
import Announcements from "./Announcements.vue";
import api from "@oj/api";
import time from "@/utils/time";
import {CONTEST_STATUS} from "@/utils/constants";
import {mapActions, mapGetters} from "vuex";
import HomeBannerListBox from "../home/HomeBannerListBox.vue";
import HomeNoticeBox from "../home/Notice/HomeNoticeBox.vue";
import HomeProblemRecommendationBox from "../home/HomeProblemRecommendationBox.vue";
import HomeRankingBox from "../home/HomeRankingBox.vue";
import HomeProfileBox from "../home/HomeProfileBox.vue";
import HomeStatusBox from "../home/HomeStatistics/HomeLanguages.vue";
import HomeFamilySiteBanner from "../home/HomeFamilySiteBanner/HomeFamilySiteBanner.vue"
import Statistics from "./HomeStatistics.vue";

export default {
  name: "home",
  components: {
    Statistics,
    HomeStatusBox,
    HomeProfileBox,
    HomeRankingBox,
    HomeProblemRecommendationBox,
    HomeFamilySiteBanner,
    HomeNoticeBox,
    HomeBannerListBox,
    Announcements
  },
  data() {
    return {
      contests: [],
      index: 0,
      listVisible: true,
      btnLoading: false,
    };
  },
  mounted() {
    let params = {status: CONTEST_STATUS.NOT_START};
    api.getContestList(0, 5, params).then(res => {
      this.contests = res.data.data.results;
    });
    this.init();
  },
  methods: {
    ...mapActions(['getProfile', 'changeModalStatus']),
    init() {
      if (this.isContest) {
        this.getContestAnnouncementList();
      }
    },
    getDuration(startTime, endTime) {
      return time.duration(startTime, endTime);
    },
    goContest() {
      this.$router.push({
        name: "contest-details",
        params: {contestID: this.contests[this.index].id}
      });
    },
  },
  computed: {
    ...mapGetters(['website', 'isAdminRole']),
    isContest() {
      return !!this.$route.params.contestID;
    },
    modalVisible: {
      get() {
        return this.modalStatus.visible
      },
      set(value) {
        this.changeModalStatus({visible: value})
      }
    }
  },
};
</script>

<style lang="less" scoped>
.mainBox {
  width: var(--global-width);
}

.boxWrapper {
  display: flex;
  justify-content: space-between;
}

.left-container {
  width: 67%;
  height: 100%;
}

.right-container {
  width: 30%;
  height: auto;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.contestBox {
  margin-top: 30px;
  padding-left: 3%;
  border: 0.5px solid #B6B6B6;
  padding-top: 1%;
  padding-right: 3%;
  background-color: #ffffff;
  border-radius: 7px;
  height: 200px;
}

.contest {
  &-title {
    font-style: italic;
    font-size: 21px;
  }

  &-content {
    padding: 0 70px 40px 70px;

    &-description {
      margin-top: 25px;
    }
  }
}
</style>
