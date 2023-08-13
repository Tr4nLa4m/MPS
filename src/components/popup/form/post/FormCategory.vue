<script setup>
import {
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
const { success, error, warning } = useMessages();
const emit = defineEmits(["closeModal", "updated"]);
const categories = computed(() => store.state[ModulePost].categories);
const props = defineProps({
  mode: {
    type: Number,
    default: MConstant.FormMode.Add,
  },
  category: {
    type: Object,
    default: {},
  },
});
const employee = computed(() => store.state[ModuleContext]?.employee);
const isEditMode = () => props.mode == MConstant.FormMode.Edit;
// PROJECT SELECT
const master = reactive({
  Data: models.createAddPostCategoryParam(),
});

onMounted(async () => {
  await getCategories();

  bindInitMasterData();
});

const bindInitMasterData = () => {
  if (isEditMode()) {
    master.Data = props.category;
  }

  master.Data.ProjectID = route.params.ProjectID;
};

const getCategories = async () => {
  let param = {
    data: {
      ProjectID: route.params.ProjectID,
    },
  };
  let res = await store.dispatch(ModulePost + "/getCategoriesByProject", param);
};

const btnSave_click = async () => {
  let data = cloneDeep(master.Data);
  let { isValid, errMsg } = validateData(data);
  if (!isValid) {
    warning(errMsg);
    return;
  }

  let action = '/insertCategory';

  let onFailure = () => error("Có lỗi xảy ra");
  let onSuccess = () => success("Thêm danh mục thành công");
  
  if(isEditMode()){
    action = '/updateCategory';
    onSuccess = () => success("Sửa danh mục thành công");
  }

  let param = {
    data,
    onSuccess,
    onFailure,
  };

  let res = await store.dispatch(ModulePost + action, param);
  emit("updated");
  closeModal();
};

const validateData = (data) => {
  let res = {
    errMsg: "",
    isValid: true,
  };

  if (!data.CategoryName) {
    res.isValid = false;
    res.errMsg = "Tên danh mục không được để trống !";
    return res;
  }

  let listCategoryName = categories.value.map(x => x.CategoryName);

  if (listCategoryName.includes(data.CategoryName)) {
    res.isValid = false;
    res.errMsg = "Tên danh mục đã tồn tại";
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
            <div class="text-xl">
              {{ isEditMode ? "Sửa danh mục" : "Thêm danh mục" }}
            </div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-mt16 m-pl8 m-pr8">
          <div class="m-mt8">
            <div class="form-label m-pb4">
              Tên danh mục: <span class="danger">*</span>
            </div>
            <MInput
              v-model="master.Data.CategoryName"
              :placeholder="'Tên danh mục'"
              :customClass="'m-m0 input-xl text-large'"
              inputClass="m-pl16 m-pr16"
            />
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
.form-reopen-issue--wrapper {
  width: 620px;
}

.issue-form-info {
  background-color: var(--background-comment);
}
</style>
