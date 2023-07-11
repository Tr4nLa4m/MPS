<script setup>
import { onMounted , computed} from "vue";
import HeaderLayout from "@/views/layouts/HeaderLayout.vue";
import SideBarLayout from "@/views/layouts/SideBarLayout.vue";
import { useStore } from "vuex";
import { ModuleProject, ModuleUser } from "@/store/moduleConstant";

const store = useStore();

const departmentProjects = computed(() => store.getters[ModuleProject + '/departmentProjects']);
const employee = computed(() => store.state[ModuleUser]?.employee);

onMounted(async () => {
  
  let param = {
    EmployeeID : employee?.value.EmployeeID
  }
  let res = await store.dispatch(ModuleProject + '/getProjectByEmployee', param);
});
</script>

<template>
  <HeaderLayout/>

  <div class="container m-dashboard">
    <SideBarLayout v-if="departmentProjects" :projects="departmentProjects" />
  </div>
</template>

<style scoped></style>
