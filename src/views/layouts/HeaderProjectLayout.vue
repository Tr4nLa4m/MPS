<script setup>
import MSplitButton from "@/components/button/MSplitButton.vue";
import { ref, inject, computed, h, onMounted } from "vue";
import { useRoutePath } from "@/utils/uses/router/useRoutePath.js";
import { useStore } from "vuex";
import {
  ModuleConfig,
  ModuleProject,
  ModuleContext,
} from "@/store/moduleConstant";
import MConstant, {
  DEPARTMENT_KEY_PREFIX,
  GUID_EMPTY,
} from "@/common/consts/MConstant";
import DropdownUserInfo from "@/components/dropdown/DropdownUserInfo.vue";
import { useModal } from "vue-final-modal";
import AddTaskForm from "@/components/popup/form/AddTask.vue";
import AddProjectForm from "@/components/popup/form/AddProject.vue";
import AddIssue from "@/components/popup/form/AddIssue.vue";
import AddPost from "@/components/popup/form/AddPost.vue";
import AddEmployee from "@/components/popup/form/AddEmployee.vue";
import AddDepartment from "@/components/popup/form/AddDepartment.vue";
import ConfigProjectForm from "@/components/popup/form/ConfigurationProject.vue";
import { useRoute } from "vue-router";
import DeleteConfirm from "@/components/popup/form/DeleteConfirm.vue";
import { useMessages } from "@/utils/uses/base/useMessages";
import { reactive } from "vue";
import { watch } from "vue";
import AuthenticationProject from "@/components/popup/form/AuthenticationProject.vue";

//#region Hàm hỗ trợ
const renderDropdownUser = () => {
  return h(DropdownUserInfo, {
    user: {
      Avatar: employee?.value.Avatar,
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
  };
};
//#endregion

//#region Khai báo biến
const CommonFn = inject("CommonFn");
const { goToProjectChild, getCurrentProjectTab, goToDashboard, goToProject } =
  useRoutePath();

const { success, error } = useMessages();

const store = useStore();
const route = useRoute();
const currentProject = reactive({
  ProjectID: null,
});

const project = computed(() => store.state[ModuleProject]?.project);
const projectTabs = computed(() => store.state[ModuleConfig]?.projectTabs);
const employee = computed(() => store.state[ModuleContext].employee);
const userPermissions = computed(() => {
  let projectID = project.value.ProjectID;
  if(!projectID){
    return [];
  }
  return store.getters[ModuleContext + '/getUserProjectPermission'](projectID);
});
const selectedTabName = getCurrentProjectTab(projectTabs.value)?.name;
const tab = ref(selectedTabName);
const departmentProjects = computed(() => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  return rawDepartmentProjects?.map((item) => {
    return {
      ...item,
      ProjectID: DEPARTMENT_KEY_PREFIX + item.DepartmentID,
      ProjectName: item.DepartmentName,
      disabled: true,
    };
  });
});

const dropdownAddTaskOptions = ref([
  {
    label: "Thêm dự án/nhóm",
    key: "AddProject",
  },
  {
    label: "Thêm phòng ban",
    key: "AddDepartment",
  },
  {
    label: "Thêm nhân viên vào phòng ban/dự án",
    key: "AddEmployee",
  },
  {
    label: "Thêm vấn đề mới vào dự án",
    key: "AddIssue",
  },
  {
    label: "Thêm bài viết mới vào dự án",
    key: "AddPost",
  },
]);

const AddTaskModal = useModal({
  component: AddTaskForm,
  attrs: {
    onCloseModal() {
      AddTaskModal.close();
    },
  },
});

const modalAddProject = useModal({
  component: AddProjectForm,
  attrs: {
    onCloseModal() {
      modalAddProject.close();
    },
  },
});

const modalAddEmployee = useModal({
  component: AddEmployee,
  attrs: {
    onCloseModal() {
      modalAddEmployee.close();
    },
  },
});

const modalAddIssue = useModal({
  component: AddIssue,
  attrs: {
    onCloseModal() {
      modalAddIssue.close();
    },
  },
});

const modalAddPost = useModal({
  component: AddPost,
  attrs: {
    onCloseModal() {
      modalAddPost.close();
    },
  },
});

const modalAddDepartment = useModal({
  component: AddDepartment,
  attrs: {
    onCloseModal() {
      modalAddDepartment.close();
    },
  },
});

const configProjectModal = useModal({
  component: ConfigProjectForm,
  attrs: {
    onCloseModal() {
      configProjectModal.close();
    },
  },
});

const authenProjectModal = useModal({
  component: AuthenticationProject,
  attrs: {
    onCloseModal() {
      authenProjectModal.close();
    },
  },
});

const deleteProjectConfirmModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá dự án/nhóm",
    content: `Sau khi xóa dự án/nhóm, tất cả dữ liệu công việc trong dự án/nhóm sẽ bị xóa và không thể khôi phục. Bạn có chắc chắn muốn xóa dự án không?`,

    onCloseModal() {
      deleteProjectConfirmModal.close();
    },

    async onDelete() {
      await deleteProject();
    },
  },
});

const dropdownUserOptiops = CommonFn.initDropdownOptions(renderDropdownUser);

const initProjectTabs = [
  {
    name : "Bảng",
    permission: null
  },
  {
    name : "Danh sách",
    permission: null
  },
  {
    name : "Giai đoạn",
    permission: MConstant.ProjectPermissions.Project.Project_Read_Phase
  },
  {
    name : "Tài liệu",
    permission: null
  },
  {
    name : "Vấn đề",
    permission: MConstant.ProjectPermissions.Project.Project_Read_Issue
  },
  {
    name : "Tri thức",
    permission: MConstant.ProjectPermissions.Project.Project_Read_Post
  },
  {
    name : "Báo cáo",
    permission: MConstant.ProjectPermissions.Report.Report_Read
  }
];

const getUserProjectTabs = computed(() => {
  let arrPermissionCode = userPermissions.value.map((x) => x.PermissionCode);
  return initProjectTabs.filter((option) => arrPermissionCode.includes(option.permission) || !option.permission);
})

const dropdownProjectOptions = [
  {
    label: "Thông tin dự án/nhóm",
    key: "key_projectInfo",
    icon: renderIcon("mi-infomation"),
    permission: MConstant.ProjectPermissions.Project.Project_Read_Info
  },
  {
    label: "Phân quyền",
    key: "key_authentication",
    icon: renderIcon("mi-edit-role"),
    permission: MConstant.ProjectPermissions.Project.Project_Edit_Info
  },
  {
    label: "Lưu trữ",
    key: "key_storageProject",
    icon: renderIcon("mi-project-archive"),
    permission: MConstant.ProjectPermissions.Project.Project_Delete
  },
  {
    label: "Rời khỏi dự án",
    key: "key_leaveProject",
    icon: renderIcon("mi-leave-project"),
    permission: null
  },
  {
    label: () => h("div", { class: "danger" }, "Xoá"),
    key: "key_deleteProject",
    icon: renderIcon("mi-delete-close"),
    permission: MConstant.ProjectPermissions.Project.Project_Delete
  },
];

const getDropdownProjectOptionsByUser = computed(() => {
  let arrPermissionCode = userPermissions.value.map((x) => x.PermissionCode);
  return dropdownProjectOptions.filter((option) => arrPermissionCode.includes(option.permission) || !option.permission);
})

//#endregion

//#region Hàm xử lý logic

const deleteProject = async () => {
  let param = {
    data: {
      ProjectID: project.value.ProjectID,
    },
    onSuccess: () => {
      goToDashboard();
      success(`Xoá dự án thành công!`);
    },
    onFailure: () => {
      error("Có lỗi xảy ra khi xoá dự án!");
    },
  };

  let res = await store.dispatch(ModuleProject + "/deleteProject", param);
  deleteProjectConfirmModal.close();
};

//#endregion

//#region Hàm sự kiện
const btnHome_click = () => {
  goToDashboard();
};

const btnAddTask_click = (event) => {
  try {
    AddTaskModal.open();
  } catch (error) {
    console.log(error);
  }
};

const btnTab_click = (tabName) => {
  let projectPath = CommonFn.getObjectValueByProps(
    MConstant.ProjectTab,
    "name",
    tabName,
    "path"
  );
  debugger;

  if (projectPath) {
    goToProjectChild(projectPath);
  }
};

const onOptionClick = (key) => {
  switch (key) {
    case "AddProject":
      modalAddProject.open();
      break;
    case "AddIssue":
      modalAddIssue.open();
      break;
    case "AddDepartment":
      modalAddDepartment.open();
      break;
    case "AddPost":
      modalAddPost.open();
      break;
    case "AddEmployee":
      modalAddEmployee.open();
      break;
    default:
      break;
  }
};

const btnSettingProject_click = (key, option) => {
  switch (key) {
    case "key_projectInfo":
      configProjectModal.open();
      break;
    case "key_deleteProject":
      deleteProjectConfirmModal.open();
      break;
    case "key_authentication":
      authenProjectModal.open();
      break;
    default:
      break;
  }
};

const selectProject_change = (value, options) => {
  goToProject(value);
  tab.value = "Bảng";
};
//#endregion

//#region Lifecycle hooks
onMounted(async () => {
  await getProjects();
  await setActiveTab();
  currentProject.ProjectID = project.value.ProjectID;
});

watch(
  () => project.value.ProjectID,
  (newVal, oldValue) => {
    if (newVal != oldValue) {
      currentProject.ProjectID = newVal;
    }
  }
);

const getProjects = async () => {
  // lấy danh sách các dự án
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);
};

const setActiveTab = async () => {
  let params = {
    TabPath: route.name,
  };
  let res = store.dispatch(ModuleConfig + "/setActiveProjectTab", params);
};

//#endregion
</script>

<template>
  <header>
    <div class="m-header d-flex flex-align-center">
      <div class="m-header-left">
        <div class="icon-wrapper pointer" @click="btnHome_click">
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

            <!-- <div class="name-project ellipsis m-mr4" :title="project.ProjectName">
              {{ project.ProjectName || "" }}
            </div>

            <div class="mi-16 mi-carret-down"></div> -->
            <MTreeSelect
              :data="departmentProjects"
              v-model="currentProject.ProjectID"
              class="m-select"
              customClass="project-header-select"
              label-field="ProjectName"
              key-field="ProjectID"
              children-field="Projects"
              placeholder="Dự án"
              :isExpandAll="true"
              :enableChange="true"
              @onChange="selectProject_change"
            />
          </div>
        </div>

        <n-dropdown
          trigger="click"
          :options="getDropdownProjectOptionsByUser"
          :show-arrow="true"
          @select="btnSettingProject_click"
          size="large"
        >
          <div
            class="icon-wrapper d-flex flex-align-center pointer m-pr24 m-pl24"
          >
            <div class="mi-24 mi-setting m-mr6 m-ml6"></div>
          </div>
        </n-dropdown>

        <div class="tab-panel m-ml16">
          <n-tabs
            type="bar"
            class="m-tabs header-tabs"
            v-model:value="tab"
            @update:value="btnTab_click"
          >
            <n-tab v-for="tab in getUserProjectTabs" :name="tab.name"></n-tab>
            <!-- <n-tab name="Danh sách"></n-tab>
            <n-tab name="Gantt"></n-tab>
            <n-tab name="Giai đoạn"></n-tab>
            <n-tab name="Tài liệu"></n-tab>
            <n-tab name="Vấn đề"></n-tab>
            <n-tab name="Tri thức"></n-tab>
            <n-tab name="Báo cáo"></n-tab> -->
          </n-tabs>
        </div>
      </div>

      <div class="m-header-right d-flex flex-align-center">
        <MSplitButton
          :text="'Thêm công việc'"
          :title="'Thêm công việc'"
          :classCustom="'m-button-m'"
          :leftIcon="'mi-24 mi-plus-white'"
          :options="dropdownAddTaskOptions"
          @onOptionClick="onOptionClick"
          @onClick="btnAddTask_click"
        />

        <div class="divider m-mr32 m-w1"></div>

        <div class="m-icon-btn mi-24 mi-search m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-notification m-mr32"></div>

        <!-- <div class="m-icon-btn mi-24 mi-question m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-book m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-show-detail m-mr32"></div> -->

        <n-dropdown
          trigger="click"
          :options="dropdownUserOptiops"
          :show-arrow="true"
        >
          <div class="m-icon-btn avatar m-mr8">
            <img :src="employee.Avatar" />
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

.project-header-select .n-base-selection {
  border: none !important;
  --n-border: 0 !important;
  --n-border-active: 0 !important;
  --n-border-focus: 0 !important;
  --n-border-hover: 0 !important;
}

.project-header-select .n-base-selection .n-base-selection-input__content {
  max-width: 240px;
  min-width: 200px;
}
</style>
