<script setup>
import MSplitButton from "@/components/button/MSplitButton.vue";
import { ref, inject, computed, h, onMounted } from "vue";
import { useRoutePath } from "@/utils/uses/router/useRoutePath.js";
import { useStore } from "vuex";
import {
  ModuleConfig,
  ModuleProject,
  ModuleUser,
} from "@/store/moduleConstant";
import DropdownUserInfo from "@/views/pages/common/dropdown/DropdownUserInfo.vue";
import { useModal } from "vue-final-modal";
import AddTaskForm from "@/views/popup/form/AddTask.vue";
import ConfigProjectForm from "@/views/popup/form/ConfigurationProject.vue";
import { useRoute } from "vue-router";

const MConstant = inject("MConstant");
const CommonFn = inject("CommonFn");
const { goToProjectChild, getCurrentProjectTab, goToDashboard } =
  useRoutePath();

const store = useStore();
const route = useRoute();

const project = computed(() => store.state[ModuleProject]?.project);
const projectTabs = computed(() => store.state[ModuleConfig]?.projectTabs);
const user = computed(() => store.state[ModuleUser]?.user);
const employee = computed(() => store.state[ModuleUser]?.employee);
const selectedTabName = getCurrentProjectTab(projectTabs.value)?.name;

const { open, close } = useModal({
  component: AddTaskForm,
  attrs: {
    onCloseModal() {
      close();
    },
  },
});

const configProjectModal = useModal({
  component: ConfigProjectForm,
  attrs: {
    onCloseModal() {
      configProjectModal.close();
    },
  }
})

const renderDropdownUser = () => {
  return h(DropdownUserInfo, {
    user: {
      Avatar: user?.value.Avatar,
      FullName: employee?.value.FullName,
      Email: employee?.value.Email,
    },
  });
};

const renderIcon = (icon) => {
  return () => {
    return h(
    "div",
    {
      class: "",
    },
    [h("div", { class: "mi-24 " + icon })]
  );
  }
};

const dropdownUserOptiops = CommonFn.initDropdownOptions(renderDropdownUser);

const dropdownProjectOptions = [
  {
    label: "Thông tin dự án/nhóm",
    key: "key_projectInfo",
    icon: renderIcon("mi-infomation"),
  },
  {
    label: "Phân quyền",
    key: "key_authentication",
    icon: renderIcon("mi-edit-role"),
  },
  {
    label: "Lưu trữ",
    key: "key_storageProject",
    icon: renderIcon("mi-project-archive"),
  },
  {
    label: "Rời khỏi dự án",
    key: "key_leaveProject",
    icon: renderIcon("mi-leave-project"),
  },
  {
    label: () => h('div', {class : 'danger'}, "Xoá"),
    key: "key_deleteProject",
    icon: renderIcon("mi-delete-close"),
  },
];

const handleTabClick = (tabName) => {
  let projectPath = CommonFn.getObjectValueByProps(
    MConstant.ProjectTab,
    "name",
    tabName,
    "path"
  );

  if (projectPath) {
    goToProjectChild(projectPath);
  }
};

const handleSelectDropdownProject = (key, option) => {
  switch (key) {
    case 'key_projectInfo':
    configProjectModal.open();
      break;
  
    default:
      break;
  }
}

onMounted(() => {
  let params = {
    TabPath: route.name,
  };
  let res = store.dispatch(ModuleConfig + "/setActiveProjectTab", params);
});

const btnHome_click = () => {
  goToDashboard();
};

const onClickBtn = (event) => {
  try {
    open();
  } catch (error) {
    console.log(error);
  }
};
</script>

<template>
  <header>
    <div class="m-header d-flex flex-align-center">
      <div class="m-header-left">
        <div class="icon-wrapper" @click="btnHome_click">
          <div class="m-icon-btn mi-24 mi-home m-ml16 m-mr16 pointer"></div>
        </div>
      </div>

      <div class="d-flex flex-1 m-ml16 m-header-project">
        <div class="d-flex flex-align-center">
          <div class="project-select-wrapper d-flex flex-align-center pointer">
            <div class="icon-project flex-center m-mr8">
              <div class="icon-project-wrapper flex-center">
                <div class="mi-16 mi-project-personal m-bg-white"></div>
              </div>
            </div>

            <div class="name-project m-mr4">
              {{ project.ProjectName || "" }}
            </div>

            <div class="mi-16 mi-carret-down"></div>
          </div>
        </div>

        <n-dropdown
          trigger="click"
          :options="dropdownProjectOptions"
          :show-arrow="true"
          @select="handleSelectDropdownProject"
          size="large"
        >
        <div class="icon-wrapper d-flex flex-align-center m-pr24 m-pl24">
          <div class="mi-24 mi-setting m-mr6 m-ml6"></div>
        </div>
      </n-dropdown>

        <div class="tab-panel m-ml16">
          <n-tabs
            type="bar"
            class="m-tabs header-tabs"
            :default-value="selectedTabName"
            @update:value="handleTabClick"
          >
            <n-tab name="Bảng"></n-tab>
            <n-tab name="Danh sách"></n-tab>
            <n-tab name="Gantt"></n-tab>
            <n-tab name="Lịch"></n-tab>
            <n-tab name="Tài liệu & Liên kết"></n-tab>
          </n-tabs>
        </div>
      </div>

      <div class="m-header-right d-flex flex-align-center">
        <MSplitButton
          :text="'Thêm công việc'"
          :title="'Thêm công việc'"
          :classCustom="'m-button-m'"
          :leftIcon="'mi-24 mi-plus-white'"
          @onClick="onClickBtn"
        />

        <div class="divider m-mr32 m-w1"></div>

        <div class="m-icon-btn mi-24 mi-search m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-notification m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-question m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-book m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-show-detail m-mr32"></div>

        <n-dropdown
          trigger="click"
          :options="dropdownUserOptiops"
          :show-arrow="true"
        >
          <div class="m-icon-btn avatar m-mr8">
            <img :src="user.Avatar" />
          </div>
        </n-dropdown>
      </div>
    </div>
  </header>
</template>

<style>
@import url("@/assets/style/layouts/layout-header.css");



.header-tabs .n-tabs-tab__label {
  font-size: 15px !important;
}
</style>
