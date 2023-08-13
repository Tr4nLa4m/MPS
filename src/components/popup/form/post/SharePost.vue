<script setup>
import {
  ModuleIssue,
  ModulePost,
  ModuleProject,
  ModuleContext,
} from "@/store/moduleConstant";
import { onMounted } from "vue";
import { computed } from "vue";
import { reactive, inject } from "vue";
import { useStore } from "vuex";
import { useRoute } from "vue-router";
import { cloneDeep } from "lodash";
import { useMessages } from "@/utils/uses/base/useMessages";
import MConstant, { DEPARTMENT_KEY_PREFIX } from "@/common/consts/MConstant";
import commonFn from "@/utils/helper/commonFn.js";

const store = useStore();
const route = useRoute();
const models = inject("Model");
const { success, error , warning} = useMessages();
const emit = defineEmits(["closeModal", "sharePost"]);
const props = defineProps({
  post: {
    type: Object,
    default: {},
  },
});
const employee = computed(() => store.state[ModuleContext]?.employee);
// PROJECT SELECT
const userProjects = computed(() => store.state[ModuleProject].projects);
const getUserProjects = computed(() => {
  if (userProjects.value.length == 0) {
    return [];
  }
  let projectData = cloneDeep(userProjects.value);
  projectData.forEach((project) => {
    if (project.ProjectID == props.post.ProjectID) {
      project["disabled"] = true;
      return;
    }
  });

  let departmentProjects = commonFn.getDepartmentProject(projectData);
  return departmentProjects;
});


const master = reactive({
  Post: {},
  ProjectID: null,
});

onMounted(async () => {
  await getProjects();

  bindInitMasterData();
});

const bindInitMasterData = () => {
  master.Post = props.post;
  master.ProjectID = getDefaultDepartmentProject();
};

const getDefaultDepartmentProject = () => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  for (let index = 0; index < rawDepartmentProjects.length; index++) {
    const projects = rawDepartmentProjects[index].Projects;
    if (projects.length > 0) {
      let initProject = projects.find((project) => project.IsInitProject);
      if (initProject) return initProject.ProjectID;
    }
  }

  return "";
};

const getProjects = async () => {
  // lấy danh sách các dự án
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);
};

const btnSave_click = async () => {
  let data = cloneDeep(master);
  let { isValid, errMsg } = validateData(data);
  if (!isValid) {
    warning(errMsg);
    return;
  }

  let onFailure = () => error("Có lỗi xảy ra");

  let param = {
    data,
    onSuccess: () => success("Chia sẻ bài viết thành công"),
    onFailure,
  };

  let res = await store.dispatch(ModulePost + "/sharePost", param);

  closeModal();
};

const validateData = (data) => {
  let res = {
    errMsg: "",
    isValid: true,
  };

  if (!data.ProjectID) {
    res.isValid = false;
    res.errMsg = "Dự án không được để trống !";
    return res;
  }

  return res;
};

const closeModal = () => {
  emit("closeModal");
};
</script>

<template>
  <VModal customClass="form-reopen-issue">
    <template #default>
      <div class="form-reopen-issue--wrapper">
        <div class="form-header line-bottom">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">Chia sẻ bài viết</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-mt16 m-pl8 m-pr8">
          <div class="m-pt16 m-pb16 text-center issue-form-info">
            <div class="text-link">
              Mọi thông tin dự án trong bài viết sẽ được chia sẻ đến dự án khác
            </div>
          </div>

          <div class="m-mr8 m-mt16">
            <span class="">Bài viết : </span>
            <span class="text-bold">{{ post.Title }}</span>
          </div>

          <div class="flex-1 m-mr8 m-mt16">
            <div class="form-label m-pb4">
              Chọn dự án: <span class="danger">*</span>
            </div>
            <MTreeSelect
              :data="getUserProjects"
              v-model="master.ProjectID"
              class="m-select"
              label-field="ProjectName"
              key-field="ProjectID"
              children-field="Projects"
              placeholder="Chọn dự án"
              :isExpandAll="true"
              :enableChange="true"
            />
          </div>
        </div>

        <div class="form-footer">
          <div class="flex-row-end flex-align-center">
            <div class="" @click="closeModal">
              <div class="text-link-v3">Huỷ</div>
            </div>

            <MButton
              :text="'Chia sẻ'"
              :title="'Chia sẻ'"
              :classCustom="'m-button-m detail-issue-btn m-ml16'"
              :classText="'m-mr8 m-ml8'"
              @click="btnSave_click"
            />
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>
.form-reopen-issue--wrapper {
  width: 620px;
}

.issue-form-info {
  background-color: var(--background-comment);
}
</style>
