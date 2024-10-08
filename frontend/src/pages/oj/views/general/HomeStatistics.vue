<script>

import {defineComponent} from "vue";
import SolvedProblems from "../home/HomeStatistics/SolvedProblems.vue";
import HeldContests from "../home/HomeStatistics/HeldContests.vue";
import TotalProblems from "../home/HomeStatistics/TotalProblems.vue";
import api from "../../api";

export default defineComponent({
  components: {TotalProblems, HeldContests, SolvedProblems},
  mounted() {
    this.init()
  },
  methods: {
    init() {
      this.loadStatistics()
    },
    loadStatistics() {
      api.getStatistics().then(res => {
        this.statistics.totalProblems = res.data.data.total_problem_length
        this.statistics.solvedProblems = res.data.data.accepted_problem_length
        this.statistics.heldContests = res.data.data.ended_contest_length
      })
    },
    statSelect(index) {
      this.statIndex = index
    },
    statExtendedClass(index) {
      return this.statIndex === index ? 'extended' : ''
    },
    statExtended(index) {
      return this.statIndex === index
    }
  },
  data() {
    return {
      statIndex: -1,
      statistics: {
        totalProblems: 512,
        solvedProblems: 120,
        heldContests: 36
      },
      statTimer: setTimeout(() => {
        this.statIndex = 0
      }, 0)
    }
  },
})
</script>

<template>
  <div class="statistics">
    <div :class="`statistics-contents ${statExtendedClass(0)}`" @mouseenter="statSelect(0)">
      <router-link :to="{name:'problem-list'}">
      <h3>
        {{ $t('m.NumberOfProblems') }}
      </h3>
      </router-link>
      <TotalProblems :extended="statExtended(0)" :total-problems="this.statistics.totalProblems"/>
    </div>
    <hr/>
    <div :class="`statistics-contents ${statExtendedClass(1)}`" @mouseenter="statSelect(1)">
      <h3>
        {{ $t('m.NumberOfSolvedProblems') }}
      </h3>
      <SolvedProblems :extended="statExtended(1)" :solved-problems="this.statistics.solvedProblems"/>
    </div>
    <hr/>
    <div :class="`statistics-contents ${statExtendedClass(2)}`" @mouseenter="statSelect(2)">
      <router-link :to="{name:'contest-list'}">
      <h3>
        {{ $t('m.NumberOfHeldContests') }}
      </h3>
      </router-link>
      <HeldContests :extended="statExtended(2)" :held-contests="this.statistics.heldContests"/>
    </div>
  </div>
</template>

<style scoped lang="less">

h3 {
  font-size: 18px;
  padding: 15px 0;
  font-weight: 650;
  color: var(--ps-content-text-color)
}

.statistics {
  display: flex;
  flex-direction: column;
  width: 100%;
  padding: 0 20px 15px 20px;
  border: 1px solid var(--container-border-color);
  border-radius: var(--container-border-radius);
  background-color: var(--box-background-color);
  --statistics-extend-height: 200px;
  height: 380px;

  &.hover {
    border-color: var(--cont)
  }


  .statistics-contents {
    height: 52.5px;
    transition: height 0.3s ease-in-out;
    overflow: hidden;
    display: flex;
    flex-direction: column;

    &.extended {
      height: 258px;
    }
  }
}

hr {
  border: 0;
  height: 1px;
  background-color: var(--container-border-color);
  margin: 0;
}
</style>
