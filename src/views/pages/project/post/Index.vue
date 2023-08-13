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
const currentTabName = ref('');
const userPermissions = computed(() => {
  let projectID = route.params.ProjectID;
  if(!projectID){
    return [];
  }
  return store.getters[ModuleContext + '/getUserProjectPermission'](projectID);
});
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

const postTabs = [
    {
        id: 'AllPost',
        name: 'Tất cả bài viết',
        routeName: 'allPosts',
        toPath: {name :'allPosts' },
        icon: 'mi-issue-tab-all',
        permission: MConstant.ProjectPermissions.Project.Project_Read_Post
    },
    {
        id: 'MyPost',
        name: 'Bài viết của tôi',
        toPath: {name :'myPosts' },
        routeName: 'myPosts',
        icon: 'mi-issue-tab-my-issue',
        permission: MConstant.ProjectPermissions.Project.Project_Read_Post
    },
    {
        id: 'Bookmarks',
        name: 'Bài viết đã lưu',
        routeName: 'bookmarks',
        toPath: {name :'bookmarks' },
        icon: 'mi-issue-tab-watch',
        permission: MConstant.ProjectPermissions.Project.Project_Read_Post
    },
    {
        id: 'ConfigPost',
        name: 'Thiết lập',
        routeName: 'config',
        toPath: {name :'config' },
        icon: 'mi-setting m-bg-white',
        permission: MConstant.ProjectPermissions.Post.Post_Config
    }
];

const getUserPostTabs = computed(() => {
  let arrPermissionCode = userPermissions.value.map((x) => x.PermissionCode);
  return postTabs.filter((option) => arrPermissionCode.includes(option.permission) || !option.permission);
})

const issueContentWidth = ref(window.innerWidth - store.state[ModuleConfig].issueSidebarWidth);

const onUpdateSidebarWidth = (sidebarWidth) => {
  store.dispatch(ModuleConfig + '/setIssueSidebarWidth', sidebarWidth);
  issueContentWidth.value = window.innerWidth - sidebarWidth
}

</script>

<template>
  <div class="flex-row">
    <MSideBarLayout :enableSidebarClick="true" @collapse="onUpdateSidebarWidth"> 
      <template #default>
        <div class="m-tab-list">
          <router-link v-for="tab in getUserPostTabs" :to="tab.toPath" class="m-tab-item m-pt8 m-pb8" :class="getIsActiveTab(tab) ? 'active' : ''">
            <div class="m-tab-item-wrapper d-flex flex-align-center">
              <div class="mi-24 m-mr16" :class="[tab.icon]"></div>
              <div class="">{{  tab.name }}</div>
            </div>
          </router-link>
 
        </div>
      </template>
    </MSideBarLayout>

    <div class="project-container" :style="{ width : issueContentWidth + 'px'}">
      <router-view></router-view>
    </div>
  </div>
</template>

<style></style>
