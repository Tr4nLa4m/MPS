<template>
  <NConfigProvider :themeOverrides="themeOverrides">
    <div class="m-main-layout">
      <router-view></router-view>
    </div>
  </NConfigProvider>

  <MLoader />
</template>

<script>
import { defineComponent, onMounted } from "vue";
import { NConfigProvider } from "naive-ui";
import  MLoader  from '@/components/loader/MLoader.vue';

export default defineComponent({
  name: "MainLayout",
  components: { NConfigProvider, MLoader },
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

    onMounted(() => {
      console.log(1);
    });

    return {
      themeOverrides,
    };
  },
});
</script>

<style>
.m-main-layout * {
  font-family: "GoogleSans-Regular", Arial, Helvetica, sans-serif !important;
}
</style>
