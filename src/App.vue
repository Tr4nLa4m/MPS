<template>
  <n-message-provider>
    <MainLayout />

    <ModalsContainer />
  </n-message-provider>
</template>

<script>
import MainLayout from "./views/layouts/MainLayout.vue";
import { ModalsContainer } from "vue-final-modal";
import { defineComponent } from "vue";
export default defineComponent({
  name: "App",
  components: {
    ModalsContainer,
    MainLayout,
  },
});
</script>

<style></style>
