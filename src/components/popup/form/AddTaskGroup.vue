<script setup>
import MConstant, { PERMISSION_KEY_PREFIX } from "@/common/consts/MConstant";
import { ModuleContext, ModuleProject, ModuleTask } from "@/store/moduleConstant";
import { useMessages } from "@/utils/uses/base/useMessages";
import { includes, cloneDeep } from "lodash";
import models from "@/utils/helper/models";
import { onMounted, ref, watch } from "vue";
import { reactive } from "vue";
import { computed } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import commonFn from "@/utils/helper/commonFn";

const store = useStore();
const route = useRoute();
const emits = defineEmits(["closeModal", "updated"]);
const { success, warning, error } = useMessages();
const props = defineProps({
  mode: {
    type: String,
    default: MConstant.FormMode.Add,
  },
  taskGroup: {
    type: Object,
    default: {},
  },
});
const master = reactive({
  Data: models.createAddTaskGroupParam(),
});

const formConfig = ref({
  title: "Thêm nhóm công việc",
});

const tfTaskGroupName = ref(null);

const taskGroups = computed(() => store.state[ModuleProject].taskGroups);

const projectPermissons = computed(
  () => store.getters[ModuleProject + "/roleProjects"]
);

const isEditMode = () => {
  return props.mode == MConstant.FormMode.Edit;
};

onMounted(async () => {
  await getTaskGroups();

  if (isEditMode()) {
    bindMasterData();
  } else {
    bindInitMasterData();
  }
});

const getTaskGroups = async () => {
  let param = {
    data: {
      ProjectID: route.params.ProjectID,
    },
  };
  // lấy danh sách các nhóm công việc
  await store.dispatch(ModuleProject + "/getTaskGroups", param);
};

const bindInitMasterData = () => {
  master.Data.ProjectID = route.params.ProjectID;
};

const bindMasterData = () => {
  master.Data = cloneDeep(props.taskGroup);
};

const btnSave_click = async () => {
  let data = collecData();
  let { isValid, errMsg } = validateData(data);
  if (!isValid) {
    warning(errMsg);
    return;
  }
  let actionName = "/insertTaskGroup";
  let successMsg = "Thêm mới nhóm công việc thành công";
  let errorMsg = "Có lỗi xảy ra khi thêm mới nhóm công việc";

  if (isEditMode()) {
    successMsg = "Sửa nhóm công việc thành công";
    errorMsg = "Có lỗi xảy ra khi sửa nhóm công việc";
    actionName = "/updateTaskGroup";
  }

  let param = {
    data,
    onSuccess: () => success(successMsg),
    onFailure: () => error(errorMsg),
  };

  await store.dispatch(ModuleTask + actionName, param);
  emits("updated");
  closeModal();
};

const collecData = () => {
  let data = cloneDeep(master.Data);
  return data;
};

const validateData = (data) => {
  let res = {
    errMsg: "",
    isValid: true,
  };

  if (!data.TaskGroupName) {
    res.isValid = false;
    res.errMsg = "Tên nhóm công việc không được để trống !";
    tfTaskGroupName.value.invalid();
    return res;
  }

  let taskGroupsName = taskGroups.value.map((item) => item.TaskGroupName);

  if (taskGroupsName.includes(data.TaskGroupName)) {
    res.isValid = false;
    res.errMsg = "Tên nhóm công việc đã tồn tại trong dự án";
    return res;
  }

  return res;
};

const closeModal = () => {
  emits("closeModal");
};
</script>

<template>
  <VModal customClass="form-task-group">
    <template #default>
      <div class="form-task-group--wrapper">
        <div class="form-header m-pb16 m-pl8 m-pr8">
          <div class="flex-row flex-jsp">
            <div class="text-xl">{{ formConfig.title }}</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-pl8 m-pr8">
          <div class="flex-row">
            <div class="flex-1 m-mr8">
              <div class="form-label m-pb4">
                Tên nhóm công việc: <span class="danger">*</span>
              </div>
              <MInput
                ref="tfTaskGroupName"
                :require="true"
                :placeholder="'Nhập tên nhóm công việc'"
                :customClass="'m-m0 input-l'"
                inputClass="m-pl16 m-pr16"
                v-model="master.Data.TaskGroupName"
              />
            </div>
          </div>
        </div>

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
.form-task-group--wrapper {
  width: 400px;
}
</style>
