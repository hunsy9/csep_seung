<template>
  <div class="profileBox">
    <template v-if="!isAuthenticated">
            <span style="font-size: 14px; font-weight: 600">
              안전한 서비스 이용을 위해 로그인을 해주세요
            </span>
      <div class="loginBtn" @click="handleLoginBtnClick('login')">
        <Icon type="android-lock" size="20"></Icon>
        <span>로그인</span>
      </div>
      <div class="profileBoxFooter">
        <span @click.stop="handleLoginBtnClick('register')">회원가입</span>
        <span @click.stop="goResetPassword">비밀번호 찾기</span>
      </div>
    </template>
    <template v-else>
      <div class="authenticatedBox">
        <div class="authenticatedBody">
          <div class="userAvatarWrapper">
            <img class="avatar" :src="profile.avatar"/>
          </div>
          <div class="userInfoWrapper">
                  <span>
                    {{ user.username + '님' }}
                  </span>
            <template v-if="!isAdminRole">
              <br>
              <span>{{ profile.school }}</span>
              <br>
              <span>{{ profile.major }}</span>
            </template>
            <template v-else>
              <br>
              <span v-if="isAdminRole">관리자({{ user.admin_type }})</span>
            </template>
          </div>
          <div class="logoutBtn">
                  <span @click="goRouter('logout')">
                    로그아웃
                  </span>
          </div>
        </div>
        <div class="authenticatedFooter">
          <span @click="goRouter('user-home')"><router-link
            :to="{name:'user-home', params:{username:user.username}}">{{ $t('m.MyHome') }}</router-link></span>
          <router-link :to="{name:'user-setting'}">정보수정</router-link>
          <span v-if="isAdminRole" @click="goRouter('admin')">관리</span>
          <span v-else @click="alertUndeveloped" class="unclickable">내 강의</span>
          <!--          <span @click="goRouter('profile-setting')"><router-link-->
          <!--              :to="{name:'default-setting'}">{{ $t('m.Settings') }}</router-link></span>-->
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import api from '@oj/api'
import {mapActions, mapGetters} from "vuex";
import {getTierImageSrc} from "../../../../utils/constants";

export default {
  name: 'HomeProfileBox',
  data() {
    return {}
  },
  methods: {
    alertUndeveloped() {
      this.$error('개발중인 기능입니다.')
    },
    getTierImageSrc,
    ...mapActions(['getProfile', 'changeModalStatus']),
    handleLoginBtnClick(mode) {
      console.log("setting complete!")
      this.changeModalStatus({
        visible: true,
        mode: mode
      })
    },
    handleRoute(route) {
      this.$router.push({name: route});
    },
    goResetPassword() {
      this.changeModalStatus({visible: false});
      this.$router.push({name: "apply-reset-password"});
    },
    goRouter(routeName) {
      if (routeName && routeName.indexOf('admin') < 0) {
        this.$router.push({name: routeName})
      } else {
        window.open('/admin/')
      }
    }
  },
  computed: {
    ...mapGetters(['website', 'modalStatus', 'user', 'isAuthenticated', 'isAdminRole']),
    ...mapGetters(['profile']),
  }
}
</script>

<style scoped lang="less">
.profileBox {
  background-color: var(--box-background-color);
  border-radius: 7px;
  border: 1px solid #dedede;
  width: 100%;
  text-align: center;
  padding: 15px 20px 15px 20px;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);

  .loginBtn {
    cursor: pointer;
    color: white;
    border-radius: 5px;
    height: 60px;
    line-height: 60px;
    background-color: #32306b;
    margin: 23px 0;

    span {
      margin-left: 10px;
      font-weight: 650;
      font-size: 15px;
    }
  }

  .profileBoxFooter {
    display: flex;
    justify-content: right;


    span {
      cursor: pointer;
    }

    span:nth-child(1) {
      margin-right: 10px;
    }
  }
}

.profileBox:hover {
  border: 1px solid #cccccc;
}

.authenticatedBox {

  @avatar-radius: 50%;

  .avatar {
    width: 100%;
    height: auto;
    max-width: 100%;
    display: block;
    border-radius: @avatar-radius;
    box-shadow: 0px 0px 1px 0px;
  }

  .authenticatedBody {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin-bottom: 20px;

    .userAvatarWrapper {
      width: 27%;
      height: 100%;
    }

    .userInfoWrapper {
      width: 40%;
      text-align: left;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;

      span:first-child {
        font-size: 15px;
        font-weight: 600;
      }
    }

    .logoutBtn {
      cursor: pointer;
      width: 70px;
      padding: 5px 0;
      border-radius: 7px;
      color: white;
      background-color: rgba(34, 33, 72, 0.82);
    }
  }

  .authenticatedFooter {
    display: flex;
    background-color: var(--pale-point-color);
    border-radius: 5px;
    justify-content: space-around;
    align-items: center;
    height: 40px;
    color: var(--ps-content-text-color);

    a {
      color: var(--ps-content-text-color);
      font-weight: 600;

      &:hover {
        font-weight: 500;
      }
    }

    span {
      cursor: pointer;
      font-weight: 600;

      &.unclickable {
        cursor: not-allowed;
      }

      a {
        color: inherit;
      }
    }

    span:hover {
      font-weight: 500;
    }
  }
}


</style>
