<script setup>
import { inject, computed, ref, h, reactive, onMounted } from "vue";
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
import { cloneDeep, some } from "lodash";
import DatePickerCard from "@/components/cards/DatePicker.vue";
import EmployeeCard from "@/components/cards/Employee.vue";

const store = useStore();
const models = inject("Model");
const emit = defineEmits(["closeModal", "chooseIssues"]);
const employee = computed(() => store.state[ModuleContext]?.employee);
const issues = computed(() => store.state[ModulePhase]?.issueToPhase);
const masterData = ref([]);
const issueColumns = ref([
  {
    type: "selection",
  },
  {
    title: "Loại",
    key: "IssueType",
    width: 36,
    fixed: "left",
    render(row, index) {
      return h("div", { class: "card-issue-avt", title: row.IssueTypeName }, [
        h("img", { src: row.IssueTypeAvatar }),
      ]);
    },
  },
  {
    title: "Mã vấn đề",
    key: "IssueCode",
    width: 70,
    fixed: "left",
    render(row, index) {
      let onClick = () => {
        goToDetailIssue(row.IssueID);
      };
      return h(
        "div",
        { class: "text-hover-primary", onClick: onClick },
        row.IssueCode
      );
    },
  },
  {
    title: "Tiêu đề",
    key: "IssueName",
    width: 300,
    render(row, index) {
      let onClick = () => {
        goToDetailIssue(row.IssueID);
      };
      return h(
        "div",
        { class: "text-hover-primary", onClick: onClick },
        row.IssueName
      );
    },
  },
  {
    title: "Trạng thái",
    key: "IssueStatusName",
    width: 80,
  },
  {
    title: "Người xử lý",
    key: "AssigneeName",
    render(row, index) {
      return h("div", { class: "text-link-v2" }, row.AssigneeName);
    },
    width: 120,
  },
]);
const rowKey = (row) => row.IssueID;

const props = defineProps({
  projectID: {
    type: String,
    default: "",
  },
});


//#region Lifecycle hooks
onMounted(async () => {
  await getIssueToPhase();

  await bindInitMasterData();
});

const getIssueToPhase = async () => {
  // lấy danh sách các dự án
  let param = {
    data: {
      ProjectID: props.projectID,
    },
  };
  await store.dispatch(ModulePhase + "/getIssueToPhase", param);
};

const bindInitMasterData = async () => {};

const btnSave_click = async () => {
  let data = collectData();
  emit("chooseIssues", data);

  closeModal();
};

const collectData = () => {
  let data = cloneDeep(masterData.value);
  return data;
};

const handleChooseIssue = (rowKeys) => {
  let listTasks = issues.value.filter((item) => rowKeys.includes(item.IssueID));
  masterData.value = listTasks;
};

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
            <div class="text-xl">{{ "Thêm vấn đề từ dự án" }}</div>

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
              <!-- <div class="form-label m-pb4">
                Tên giai đoạn: <span class="danger">*</span>
              </div>
              <MInput
                v-model="master.Data.PhaseName"
                :placeholder="'Tên giai đoạn'"
                :customClass="'m-m0 input-xl text-large'"
                inputClass="m-pl16 m-pr16"
              /> -->
            </div>

            <div>
              <n-data-table
                id="resizeMe"
                class="text-medium table-2"
                :columns="issueColumns"
                :data="issues"
                :max-height="230"
                :min-height="50"
                :single-line="false"
                :row-key="rowKey"
                @update:checked-row-keys="handleChooseIssue"
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
  width: 1020px;
}

.form-phase--wrapper .form-body {
  padding: 0 8px;
}
</style>
