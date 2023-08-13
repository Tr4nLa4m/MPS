<script setup>
import { onMounted , computed} from "vue";
import HeaderLayout from "@/views/layouts/HeaderLayout.vue";
import SideBarLayout from "@/views/layouts/SideBarLayout.vue";
import { useStore } from "vuex";
import { ModuleProject, ModuleContext } from "@/store/moduleConstant";
import useEventBus from "@/utils/uses/base/useEventBus";
import { GlobalEventName } from "@/utils/helper/eventBus";

const store = useStore();

const departmentProjects = computed(() => store.getters[ModuleProject + '/departmentProjects']);
const employee = computed(() => store.state[ModuleContext]?.employee);

const getProjects = async () => {
  let param = {
    EmployeeID : employee?.value.EmployeeID
  }
  let res = await store.dispatch(ModuleProject + '/getProjectByEmployee', param);
}

const getEmployeeProjectPermission = async () => {
  let param = {
    data: {
      EmployeeID : employee?.value.EmployeeID
    }
  }

  await store.dispatch(ModuleContext + '/getEmployeeProjectPermission', param);
}

const eventBus = useEventBus(GlobalEventName.loadProjectSidebar, async () => await getProjects());

onMounted(async () => {
  
  await getProjects();

  await getEmployeeProjectPermission();
});
</script>

<template>
  <HeaderLayout/>

  <div class="container m-dashboard">
    <SideBarLayout v-if="departmentProjects" :projects="departmentProjects" />
  </div>
</template>

<style scoped></style>
