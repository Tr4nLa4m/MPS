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
const emit = defineEmits(["closeModal", "chooseTasks"]);
const employee = computed(() => store.state[ModuleContext]?.employee);
const tasks = computed(() => store.state[ModulePhase]?.taskToPhase);
const masterData = ref([]);
const taskColumns = ref([
{
    type: 'selection',
    
  },
  {
    title: "Tên công việc",
    key: "TaskName",
    width: 300,
    resizable: true,
    ellipsis: true,
    cellProps: (row, index) => {
      return {
        style: "cursor: pointer;",
        onClick: () => {
          openTaskView(row.TaskID);
        },
      };
    },
    render(row, index) {
      return h("div", { class: "flex-row flex-align-center" }, [
        row.Status === 3
          ? h("div", {
              class: "mi-24 mi-green-done m-mr8",
            })
          : h("div"),
        h("div", row.TaskName),
      ]);
    },
  },
  {
    title: "Hạn hoàn thành",
    key: "EndDate",
    width: 170,
    render(row, index) {
      let value = row.EndDate ? new Date(row.EndDate) : null;
      return h(DatePickerCard, { value, enableDateOver: true });
    },
  },

  {
    title: "Người thực hiện",
    key: "PerformerName",
    width: 240,
    render(row, index) {
      const item = {
        Avatar: row.PerformerAvatar,
        FullName: row.PerformerName,
      };
      const clickr = () => {};
      return h(EmployeeCard, {
        onClick: clickr,
        clickable: true,
        item: item,
        class: "m-w100",
      });
    },
  },
]);
const rowKey = (row) => row.TaskID;


const props = defineProps({
  projectID: {
    type: String,
    default: ''
  }
});

const master = reactive({
  Data: models.createAddPhaseParam(),
});


//#region Lifecycle hooks
onMounted(async () => {
  await getTaskToPhase();

  await bindInitMasterData();
});

const getTaskToPhase = async () => {
  // lấy danh sách các dự án
  let param = {
    data: {
        ProjectID: props.projectID,
    }
  };
  await store.dispatch(ModulePhase + "/getTaskToPhase", param);
};

const bindInitMasterData = async () => {

};

const btnSave_click = async () => {
  let data = collectData();
  emit("chooseTasks", data);

  closeModal();
};

const collectData = () => {
  let data = cloneDeep(masterData.value);
  return data;
};

const handleChooseTask = (rowKeys) => {
  let listTasks = tasks.value.filter((item) => rowKeys.includes(item.TaskID));
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
            <div class="text-xl">{{ "Thêm công việc từ dự án" }}</div>

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
                :columns="taskColumns"
                :data="tasks"
                :max-height="230"
                :min-height="50"
                :single-line="false"
                :row-key="rowKey"
                @update:checked-row-keys="handleChooseTask"
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
