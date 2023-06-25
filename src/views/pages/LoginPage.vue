<script setup>
import { onMounted, ref } from "vue";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";
import { useStore, mapActions } from "vuex";
import { ModuleUser } from "@/store/moduleConstant";

let username = ref("");
let password = ref("");
const tfUsername = ref(null);

const store = useStore();
const { goToDashboard } = useRoutePath();

const btnLogin_click = async (event) => {
  let data = {
    Username: username.value,
    Password: password.value,
  };

  // if(window._bypassLogin){
  //   debugger
  //   goToDashboard();
  // }

  const user = await store.dispatch( ModuleUser +  "/login", data);
  if(user){
    
  }
  goToDashboard();
};
</script>

<template>
  <div class="m-login-wrapper" itemid="pnContainer">

    <!-- Login Form  -->
    <div class="m-login-form">
      <div class="m-login-form__header">
        <!-- <span class="m-login-title">MISA Promotion Process</span> -->
        <img src="@/assets/logo/logo1.svg" />
      </div>

      <div class="m-login-form__body">
        <MInput
          v-model="username"
          :require="true"
          :name="'username'"
          :placeholder="'Tên tài khoản'"
          :textMessage="'Tài khoản không được để trống'"
          ref="tfUsername"
          class="input-xl"
        />

        <MInput
          v-model="password"
          :require="true"
          :type="'password'"
          :name="'password'"
          :placeholder="'Mật khẩu'"
          :textMessage="'Mật khẩu không được để trống'"
          class="input-xl"
        />

        <div class="text-left flex m-mb16 fs-14">
          <router-link to="/forgot-password">Quên mật khẩu</router-link>
          <div class="flex-1"></div>
        </div>

        <div class="m-row-input m-pt16 text-center">
          <MButton
            :text="'Đăng nhập'"
            :title="'Đăng nhập'"
            :tag="'Login'"
            :classCustom="'m-button-xl m-w100'"
            @click="btnLogin_click"
          />
        </div>
      </div>

      <!-- <div class="m-login-form__footer">Copyright © 2020 MISA JSC</div> -->
    </div>
    <!-- End Login Form  -->

    <div class="m-login-form-note">
      Lưu ý: sử dụng tài khoản MISAJSC để đăng nhập
    </div>
  </div>
</template>

<style>
@import url(../../assets/style/pages/login-page.css);
.m-main-layout *,
.m-main-layout div,
.m-main-layout button {
  font-family: Roboto, Helvetica, Arial, sans-serif !important;
}

</style>
