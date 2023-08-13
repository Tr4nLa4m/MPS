<script setup>
import { inject, computed, ref, reactive, onMounted } from "vue";
import { useStore } from "vuex";
import {
  ModuleProject,
  ModuleContext,
  ModulePhase,
} from "@/store/moduleConstant";
import MConstant, {
  DEPARTMENT_KEY_PREFIX,
  GUID_EMPTY,
} from "@/common/consts/MConstant";
import Editor from "@tinymce/tinymce-vue";
import { cloneDeep, some } from "lodash";
import { useMessages } from "@/utils/uses/base/useMessages";
import { useRoute } from "vue-router";
import commonFn from "@/utils/helper/commonFn.js";

const store = useStore();
const route = useRoute();
const models = inject("Model");
const emit = defineEmits(["closeModal", "updatedPhase"]);
const { success, error } = useMessages();
const employee = computed(() => store.state[ModuleContext]?.employee);
const phase = computed(() => store.state[ModulePhase]?.phase);
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

const props = defineProps({
  mode: {
    type: Number,
    default: MConstant.FormMode.Add,
  },
  phase: {
    type: Object,
    default: {
      Data: {}
    },
  },
});

const isEditMode = () => {
  return props.mode == MConstant.FormMode.Edit;
};

const hasCurrentProject = () => {
  return route.params.ProjectID ;
}

const master = reactive({
  Data: models.createAddPhaseParam(),
});

const getDefaultDepartmentProject = () => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  for (let index = 0; index < rawDepartmentProjects.length; index++) {
    const project = rawDepartmentProjects[index];
    if (project.Projects?.length > 0) {
      return project.Projects[0].ProjectID;
    }
  }
  return "";
};

//#region Lifecycle hooks
onMounted(async () => {
  if(!isEditMode()){
    await getProjects();
  }

  await bindInitMasterData();
});

const getProjects = async () => {
  // lấy danh sách các dự án
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);
};

const getPhaseInfo = async () => {
  // lấy danh sách các dự án
  let param = {
    data: {
      PhaseID: props.phase.Data?.PhaseID,
    }
  };
  await store.dispatch(ModulePhase + "/getPhase", param);
};

const bindInitMasterData = async () => {
    if (isEditMode()) {
        await getPhaseInfo();
        bindCurrentPhaseData();
    }

  if (!isEditMode()) {
    if(hasCurrentProject()){
      master.Data.ProjectID = route.params.ProjectID;
    }else{
      getDefaultDepartmentProject();
    }
  }
};

const bindCurrentPhaseData = () => {
  master.Data = cloneDeep(phase.value);
  master.Data.StartDate = commonFn.getTimestamp(phase.value.StartDate);
  master.Data.EndDate = commonFn.getTimestamp(phase.value.EndDate);
};


const btnSave_click = async () => {
  let data = collectData();
  let action = "/insertPhase";
  let onSuccess = () => {
    success("Thêm mới giai đoạn thành công")
    emit("updatedPhase");
  };
  let onFailure = () => error("Có lỗi xảy ra khi thêm mới giai đoạn");

  if (isEditMode()) {
    action = "/updatePhase";
    onSuccess = () => {
      success("Sửa bài viết thành công");
      emit("updatedPhase");
    };
  }

  let param = {
    data,
    onSuccess,
    onFailure,
  };

  await store.dispatch(ModulePhase + action, param);

  closeModal();
};

const collectData = () => {
    let data = cloneDeep(master.Data);
    data.StartDate = new Date(data.StartDate);
    data.EndDate = new Date(data.EndDate);
    return data;
}

const closeModal = () => {
  emit("closeModal");
};
</script>

<template>
  <VModal customClass="form-phase">
    <template #default>
      <div class="form-phase--wrapper">
        <div class="form-header line-bottom m-pb8">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">{{ "Thêm giai đoạn" }}</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <n-scrollbar trigger="hover" style="max-height: 520px">
          <div class="form-body">
            <div class="m-mt8">
              <div class="form-label m-pb4">
                Tên giai đoạn: <span class="danger">*</span>
              </div>
              <MInput
                v-model="master.Data.PhaseName"
                :placeholder="'Tên giai đoạn'"
                :customClass="'m-m0 input-xl text-large'"
                inputClass="m-pl16 m-pr16"
              />
            </div>

            <div class="flex-row m-pb8">
              <div class="flex-1 m-mr8">
                <div class="form-label m-pb4">
                  Chọn dự án: <span class="danger">*</span>
                </div>
                <MTreeSelect
                  :data="departmentProjects"
                  v-model="master.Data.ProjectID"
                  class="m-select"
                  label-field="ProjectName"
                  key-field="ProjectID"
                  children-field="Projects"
                  placeholder="Dự án"
                  :isExpandAll="true"
                  :enableChange="true"
                  :disabled="isEditMode() || hasCurrentProject()"
                />
              </div>

              <div class="flex-1 flex-row">
                <div class="project-date m-ml8">
                  <div class="form-label m-pb4">Từ ngày:</div>
                  <n-date-picker
                    v-model:value="master.Data.StartDate"
                    type="date"
                    format="dd/MM/yyyy"
                    placeholder="Từ ngày"
                  />
                </div>

                <div class="project-date m-ml8">
                  <div class="form-label m-pb4">Đến ngày:</div>
                  <n-date-picker
                    v-model:value="master.Data.EndDate"
                    type="date"
                    format="dd/MM/yyyy"
                    placeholder="Đến ngày"
                  />
                </div>
              </div>
            </div>

            <div class="m-pb8">
              <div class="form-label m-pb8">Mô tả:</div>
              <n-input
                v-model:value="master.Data.Description"
                type="textarea"
                placeholder="Mô tả"
              />
            </div>
          </div>
        </n-scrollbar>

        <div class="form-footer">
          <div class="flex-row-end">
            <div class="m-mr8">
              <MButton
                text="Huỷ bỏ"
                class="m-button-l m-pl16 m-pr16 btn-transparent radius-8"
                @click="closeModal"
              />
            </div>
            <div class="">
              <MButton
                text="Lưu"
                class="m-button-l m-pl16 m-pr16 radius-8"
                @click="btnSave_click"
              />
            </div>
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>
.form-phase--wrapper {
  width: 820px;
}

.form-phase--wrapper .form-body {
  padding: 0 8px;
}
</style>
