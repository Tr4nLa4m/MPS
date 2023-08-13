<script setup>
import { onMounted } from "vue";
import HeaderProjectLayout from "@/views/layouts/HeaderProjectLayout.vue";
import { useRoute, useRouter } from "vue-router";
import { useStore } from "vuex";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";
import { ModuleProject , ModuleConfig} from "@/store/moduleConstant";

const route = useRoute();
const store = useStore();
const { goTo404} = useRoutePath();

let projectID = route.params?.ProjectID;
onMounted(async () => {
  let param = {
    ProjectID: projectID
  };

  let project = await store.dispatch(ModuleProject + "/getProjectById", param);
  if (!project) {
    goTo404();
  }

  let params = {
    TabPath: route.name,
  };
  console.log(1);
  store.dispatch(ModuleConfig + "/setActiveProjectTab", params);
});

</script>

<template>
  <HeaderProjectLayout />
  <div class="container">
    <router-view></router-view>
  </div>
</template>

<style scoped></style>
