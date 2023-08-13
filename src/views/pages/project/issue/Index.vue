<script setup>
import { ModuleConfig, ModuleContext } from "@/store/moduleConstant";
import MSideBarLayout from "@/views/layouts/MSideBarLayout.vue";
import { computed } from "vue";
import { ref } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import MConstant from "@/common/consts/MConstant";

const store = useStore();
const route = useRoute();
const currentTabName = ref("");
const userPermissions = computed(() => {
  let projectID = route.params.ProjectID;
  if(!projectID){
    return [];
  }
  return store.getters[ModuleContext + '/getUserProjectPermission'](projectID);
});
const getIsActiveTab = computed(() => (tab) => {
  let routeName = route.name;
  if (route.name == "issue-detail") {
    return tab.routeName == currentTabName.value;
  }
  if (tab.routeName == routeName) {
    currentTabName.value = routeName;
    return true;
  }
  return false;
});

const sidebarIssueTab = [
  {
    id: "AllIssue",
    name: "Tất cả vấn đề",
    routeName: "allIssues",
    toPath: { name: "allIssues" },
    icon: "mi-issue-tab-all",
    permission: MConstant.ProjectPermissions.Project.Project_Read_Issue
  },
  {
    id: "MyIssue",
    name: "Vấn đề đã tạo",
    toPath: { name: "myIssue" },
    routeName: "myIssue",
    icon: "mi-issue-tab-my-issue",
    permission: MConstant.ProjectPermissions.Project.Project_Read_Issue
  },
  {
    id: "MyRelateIssue",
    name: "Vấn đề liên quan",
    toPath: { name: "issue-relates" },
    routeName: "issue-relates",
    icon: "mi-relate-issue-tab",
    permission: MConstant.ProjectPermissions.Project.Project_Read_Issue
  },
  {
    id: "WatchIssue",
    name: "Vấn đề theo dõi",
    routeName: "watchIssue",
    toPath: { name: "watchIssue" },
    icon: "mi-issue-tab-watch",
    permission: MConstant.ProjectPermissions.Project.Project_Read_Issue
  },
  {
    id: "RecentlyIssue",
    name: "Vấn đề gần đây",
    routeName: "issue-recently",
    toPath: { name: "issue-recently" },
    icon: "mi-show-detail m-bg-white",
    permission: MConstant.ProjectPermissions.Project.Project_Read_Issue
  },
  {
    id: "ConfigIssue",
    name: "Thiết lập",
    routeName: "watch1Issue",
    toPath: { name: "watchIssue" },
    icon: "mi-setting m-bg-white",
    permission: MConstant.ProjectPermissions.Issue.Issue_Config
  },
];

const getUserIssueTab = computed(() => {
  let arrPermissionCode = userPermissions.value.map((x) => x.PermissionCode);
  return sidebarIssueTab.filter((option) => arrPermissionCode.includes(option.permission) || !option.permission);
})

const issueContentWidth = ref(
  window.innerWidth - store.state[ModuleConfig].issueSidebarWidth
);

const onUpdateSidebarWidth = (sidebarWidth) => {
  store.dispatch(ModuleConfig + "/setIssueSidebarWidth", sidebarWidth);
  issueContentWidth.value = window.innerWidth - sidebarWidth;
};
</script>

<template>
  <div class="flex-row">
    <MSideBarLayout :enableSidebarClick="true" @collapse="onUpdateSidebarWidth">
      <template #default>
        <div class="m-tab-list">
          <router-link
            v-for="tab in getUserIssueTab"
            :to="tab.toPath"
            class="m-tab-item m-pt8 m-pb8"
            :class="getIsActiveTab(tab) ? 'active' : ''"
          >
            <div class="m-tab-item-wrapper d-flex flex-align-center">
              <div class="mi-24 m-mr16" :class="[tab.icon]"></div>
              <div class="">{{ tab.name }}</div>
            </div>
          </router-link>
        </div>
      </template>
    </MSideBarLayout>

    <div class="project-container" :style="{ width: issueContentWidth + 'px' }">
      <router-view></router-view>
    </div>
  </div>
</template>

<style></style>
