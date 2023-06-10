<template>
  <NConfigProvider :themeOverrides="themeOverrides">
    <div class="m-main-layout">
      <router-view></router-view>
    </div>
  </NConfigProvider>
</template>

<script>
import { defineComponent } from "vue";
import { NConfigProvider } from "naive-ui";

export default defineComponent({
  name: "MainLayout",
  components: { NConfigProvider },
  setup() {
    const themeOverrides = {
      common: {
        primaryColor: '#238de6'
      },
      Tabs: {
        style: ({ theme }) => ({
          "--n-bar-color": "#000",
        }),
      },
    };

    return {
      themeOverrides,
    };
  },
});
</script>

<style>
.m-main-layout * {
  font-family: "GoogleSans-Medium", Helvetica, Arial, sans-serif;
}
</style>
