<script setup>
import { h, inject, reactive, computed, onMounted, ref } from "vue";
import { useStore } from "vuex";
import { ModuleTask, ModuleContext } from "@/store/moduleConstant";
import commonFn from "@/utils/helper/commonFn";
import EmployeeCard from "@/components/cards/Employee.vue";
import { useRoute } from "vue-router";
import DatePickerCard from "@/components/cards/DatePicker.vue";

const props = defineProps({
  initTab: {
    type: Number,
    default: 5,
  },
  data: {
    type: Object,
    default: {},
  },

  dateInfo: {
    type: Object,
    default: {
      EarliestStartDate: '',
      LatestEndDate: ''
    },
  },
});
const emit = defineEmits(["closeModal"]);

const tabs = [
  {
    name: "NumTaskDone",
    value: 5,
  },
  {
    name: "NumTaskDoneOverDeadline",
    value: 6,
  },
  {
    name: "NumTaskNotDone",
    value: 4,
  },
  {
    name: "NumTaskNotDoneOverDeadline",
    value: 7,
  },
];

const store = useStore();
const route = useRoute();
const models = inject("Model");
const masterParam = reactive(models.createGetPagingTaskByEmployeeParam());
const masterData = ref([]);
const employee = computed(() => store.state[ModuleContext]?.employee);
const projectID = ref(route.params.ProjectID);
const columns = ref([
  {
    title: "STT",
    key: "#",
    width: 48,
    render(row, index) {
      return index + 1;
    },
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

const getNumTask = (tabName) => {
  let data = props.data.Data;
  if (!data) {
    return 0;
  }

  return data[tabName];
};

const getDefaultTab = () => {
  let tabKey = props.initTab;
  let tab = tabs.find((item) => item.value == tabKey);

  return tab.name;
};

const getTabName = (tab) => {
  let tabName = tab.name;
  let res = "";
  switch (tabName) {
    case "NumTaskDone":
      res = `Hoàn thành trước hạn (${getNumTask(tabName)})`;
      break;
    case "NumTaskDoneOverDeadline":
      res = `Hoàn thành quá hạn (${getNumTask(tabName)})`;
      break;
    case "NumTaskNotDone":
      res = `Chưa hoàn thành (${getNumTask(tabName)})`;
      break;
    case "NumTaskNotDoneOverDeadline":
      res = `Quá hạn (${getNumTask(tabName)})`;
      break;

    default:
      break;
  }

  return res;
};

onMounted(async () => {
  initMasterParam();

  await getData();
});

const getData = async () => {
  let param = {
    data: masterParam,
    onFailure: () => {},
  };
  let res = await store.dispatch(ModuleTask + "/getTaskByProject", param);
  masterData.value = res.data;
};

const initMasterParam = () => {
  masterParam.QuickFilter = 1;
  masterParam.TaskStatus = props.initTab;
  masterParam.SortTaskBy = 1;
  masterParam.ProjectID = projectID.value;
  masterParam.PageIndex = 1;
  masterParam.PageSize = 100;
  masterParam.EmployeeID = employee.value.EmployeeID;
};

const handleBeforeSwitchTab = (activeTab, oldTab) => {
  let tab = tabs.find((item) => item.name == activeTab);
  masterParam.TaskStatus = tab.value;

  return true;
};

const handleUpdateTab = (tabName) => {
  getData();
};

const closeModal = () => {
  emit("closeModal");
};
</script>

<template>
  <VModal customClass="form-list-task-report">
    <template #default>
      <div class="form-list-task-report--wrapper">
        <div class="form-header m-pb8">
          <div class="flex-row flex-jsp m-pl8">
            <div class="">
              <div class="text-xl">{{ "Danh sách công việc" }}</div>
              <div class="">
                {{
                  `Từ ${commonFn.formatDate(
                    data.Data?.EarliestStartDate,
                    true
                  )} đến ${commonFn.formatDate(data.Data?.LatestEndDate, true)}`
                }}
              </div>
            </div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body">
          <div class="tabs">
            <n-tabs
              type="line"
              animated
              class="m-tabs"
              :default-value="getDefaultTab()"
              @before-leave="handleBeforeSwitchTab"
              @update:value="handleUpdateTab"
            >
              <n-tab-pane
                v-for="(tab, index) in tabs"
                :tab="getTabName(tab)"
                :name="tab.name"
              >
                <n-data-table
                  id="resizeMe"
                  class="text-medium table-2"
                  :columns="columns"
                  :data="masterData"
                  :max-height="486"
                  :min-height="480"
                  :single-line="false"
                />
              </n-tab-pane>
            </n-tabs>
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>
.form-list-task-report--wrapper {
  width: 850px;
}

.form-post--wrapper .form-body {
  padding: 0 8px;
}

.table-2 {
  --n-line-height: 20px !important;
}

.table-2 .n-data-table-th__title, .table-2 .n-data-table-th__ellipsis {
  font-family: "GoogleSans-Bold", Roboto, Helvetica, Arial, sans-serif !important;
}

.table-2 .n-data-table-td {
  padding: 10px 12px !important;
}
</style>
