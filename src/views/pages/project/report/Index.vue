<script setup>
import { ModuleConfig } from "@/store/moduleConstant";
import MSideBarLayout from "@/views/layouts/MSideBarLayout.vue";
import { computed } from "vue";
import { ref } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";

const store = useStore();
const route = useRoute();
const currentTabName = ref('');
const reportSidebarWidth = store.state[ModuleConfig].reportSidebarWidth;
const contentWidth = ref(window.innerWidth - reportSidebarWidth);

const getIsActiveTab = computed(() => (tab) =>{
  let routeName = route.name;
  if(route.name == 'post-detail'){
    return tab.routeName == currentTabName.value;
  }
  if(tab.routeName == routeName){
    currentTabName.value = routeName;
    return true;
  }
  return false;
})

const sidebarIssueTab = [
    {
        id: 'overviewProject',
        name: 'Tổng quan dự án',
        routeName: 'projectOverviewReport',
        toPath: {name :'projectOverviewReport' },
    },
    {
        id: 'projectTaskByEmployeeReport',
        name: 'Số lượng công việc theo người thực hiện',
        toPath: {name :'projectTaskByEmployeeReport' },
        routeName: 'projectTaskByEmployeeReport',
    }
]

const onUpdateSidebarWidth = (sidebarWidth) => {
  store.dispatch(ModuleConfig + '/setReportSidebarWidth', sidebarWidth);
  contentWidth.value = window.innerWidth - sidebarWidth
}

</script>

<template>
  <div class="flex-row">
    <MSideBarLayout :enableSidebarClick="true" @collapse="onUpdateSidebarWidth" :minWidth="reportSidebarWidth"> 
      <template #default>
        <div class="m-tab-list">
          <router-link v-for="tab in sidebarIssueTab" :to="tab.toPath" class="m-tab-item m-pt8 m-pb8" :class="getIsActiveTab(tab) ? 'active' : ''">
            <div class="m-tab-item-wrapper d-flex flex-align-center">
              <div class="">{{  tab.name }}</div>
            </div>
          </router-link>
 
        </div>
      </template>
    </MSideBarLayout>

    <div class="project-container" :style="{ width : contentWidth + 'px'}">
      <router-view></router-view>
    </div>
  </div>
</template>

<style>
.tab-content {
  background-color: #fff;
  margin: 16px 8px;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 8px 0;
  height: calc(100vh - 90px);
}
</style>
