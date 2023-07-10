<script setup>
import { h, inject, reactive, computed } from "vue";
import { NProgress } from "naive-ui";
import { useStore } from "vuex";
import { onMounted, ref } from "vue";
import { useRoute } from "vue-router";
import { ModuleTask, ModuleUser } from "@/store/moduleConstant";
import TaskView from "@/views/popup/form/TaskView.vue";
import { useModal } from "vue-final-modal";
import EmployeeCard from "@/components/cards/Employee.vue";
import DatePickerCard from "@/components/cards/DatePicker.vue";
import commonFn from "@/utils/helper/commonFn";

const store = useStore();
const route = useRoute();
const models = inject("Model");
const masterParam = reactive(models.createGetPagingTaskByEmployeeParam());
const employee = computed(() => store.state[ModuleUser]?.employee);
const totalRecord = ref(0);
const masterData = ref([]);
const projectID = ref(route.params.ProjectID);
const currentTaskID = ref("");

const quickFilter = reactive({
  text: "Tất cả công việc",
  value: "",
});

const statusFilter = reactive({
  text: "Trạng thái hoàn thành Tất cả",
  value: "",
});

const sortFilter = reactive({
  text: "Sắp xếp theo Ngày tạo (Tăng dần)",
  value: "",
});

const renderIcon = (icon) => {
  return () => {
    return h(
      "div",
      {
        class: "",
      },
      [h("div", { class: "mi-16 " + icon })]
    );
  };
};

const renderCustomHeader = (title) => {
  return () => {
    return h(
      "div",
      {
        class: "text-bold m-pl16 m-pt8 m-pb8",
      },
      [title]
    );
  };
};

const columns = ref([
  {
    title: () => h("div", { class: "mi-24 mi-modify-column" }),
    key: "#",
    width: 48,
    render(row, index) {
      return index + 1;
    },
  },
  {
    title: "Tên công việc",
    key: "TaskName",
    width: 400,
    resizable: true,
    ellipsis: true,
    // render(row, index) {
    //   const clickr = () => {
    //     openTaskView(row.TaskID);
    //   };
    //   return h("div", { onClick: clickr, class: "pointer m-w100" }, [
    //     row.TaskName,
    //   ]);
    // },
    cellProps: (row, index) => {
      return {
        style: "cursor: pointer;",
        onClick: () => {
          openTaskView(row.TaskID);
        },
      };
    },
  },
  {
    title: "Nhóm công việc",
    key: "TaskGroupName",
    width: 150,
  },
  {
    title: "Tình trạng công việc",
    key: "Progress",
    render(row, index) {
      return h("div", { class: "d-flex " }, [
        h(NProgress, {
          type: "circle",
          percentage: row.Progress,
          showIndicator: false,
          strokeWidth: 10,
        }),
        h("div", { class: "m-ml16" }, [`Hoàn thành ${row.Progress}%`]),
      ]);
    },
    width: 240,
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

  {
    title: "Thẻ",
    key: "The",
    width: 200,
  },

  {
    title: "Người tạo",
    key: "CreatorName",
    width: 240,
    render(row, index) {
      const item = {
        Avatar: row.CreatorAvatar,
        FullName: row.CreatorName,
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

  {
    title: "Ngày bắt đầu",
    key: "StartDate",
    width: 170,
    render(row, index) {
      let value = row.StartDate ? new Date(row.StartDate) : null;
      return h(DatePickerCard, { value });
    },
  },

  {
    title: "Ngày tạo",
    key: "CreatedDate",
    width: 170,
    render(row, index) {
      let value = row.CreatedDate ? new Date(row.CreatedDate) : null;
      return commonFn.formatDate(value);
    },
  },
]);

const pagination = reactive({
  page: 1,
  itemCount: 0,
  pageSize: 10,
  onChange: (page) => {
    pagination.page = page;
  },
});

const dropdownQuickFilterOptions = [
  {
    key: "header",
    type: "render",
    render: renderCustomHeader("Lọc nhanh"),
  },
  {
    label: "Tất cả công việc",
    key: "key_AllTask",
    icon: renderIcon("mi-grid-sort-A"),
    value: 1,
  },
  {
    label: "Việc của tôi",
    key: "key_MyTask",
    icon: renderIcon("mi-grid-sort-user"),
    value: 2,
  },
  {
    label: "Hạn tuần này",
    key: "key_DeadlineThisWeek",
    icon: renderIcon("mi-grid-sort-calendar"),
    value: 3,
  },
  {
    label: "Hạn tuần tới",
    key: "key_DeadlineNextWeek",
    icon: renderIcon("mi-grid-sort-nextweek"),
    value: 4,
  },
  {
    label: "Nhóm công việc",
    key: "key_TaskGroup",
    icon: renderIcon("mi-grid-sort-taskgroup"),
    children: [
      {
        label: "Cần thực hiện",
        key: "key_TaskGroup_ToDo",
        value: 5,
      },
      {
        label: "Đang thực hiện",
        key: "key_TaskGroup_Doing",
        value: 6,
      },
      {
        label: "Đã thực hiện",
        key: "key_TaskGroup_Done",
        value: 7,
      },
    ],
  },
];

const dropdownStatusOptions = [
  {
    label: "Tất cả",
    key: "key_All",
    value: 1,
  },
  {
    label: "Chưa hoàn thành",
    key: "key_NotDone",
    value: 2,
  },
  {
    label: "Đã hoàn thành",
    key: "key_Done",
    value: 3,
  },
];

const dropdownSortOptions = [
  {
    label: "Ngày tạo",
    key: "key_CreatedDate",
    children: [
      {
        label: "Tăng dần",
        key: "key_CreatedDate_ASC",
        value: 1
      },
      {
        label: "Giảm dần",
        key: "key_CreatedDate_DESC",
        value: 2
      },
    ],
  },
  {
    label: "Ngày bắt đầu",
    key: "key_StartDate",
    children: [
      {
        label: "Tăng dần",
        key: "key_StartDate_ASC",
        value: 3
      },
      {
        label: "Giảm dần",
        key: "key_StartDate_DESC",
        value: 4
      },
    ],
  },
  {
    label: "Hạn hoàn thành",
    key: "key_EndDate",
    children: [
      {
        label: "Tăng dần",
        key: "key_EndDate_ASC",
        value: 5
      },
      {
        label: "Giảm dần",
        key: "key_EndDate_DESC",
        value: 6
      },
    ],
  },
  {
    label: "Người thực hiện",
    key: "key_Performer",
    children: [
      {
        label: "Tăng dần",
        key: "key_Performer_ASC",
        value: 7
      },
      {
        label: "Giảm dần",
        key: "key_Performer_DESC",
        value: 8
      },
    ],
  },
  {
    label: "Nhóm công việc",
    key: "key_TaskGroup",
    children: [
      {
        label: "Tăng dần",
        key: "key_TaskGroup_ASC",
        value: 9
      },
      {
        label: "Giảm dần",
        key: "key_TaskGroup_DESC",
        value: 10
      },
    ],
  },
];

const taskViewModal = useModal({
  component: TaskView,
  attrs: {
    async onCloseModal(isEdited) {
      if (isEdited) {
        await getData();
      }
      taskViewModal.close();
    },

    async onDeleteTask(isEdited) {
      taskViewModal.close();
      await getData();
    },

    TaskID: currentTaskID,
  },
});

const openTaskView = (taskID) => {
  currentTaskID.value = taskID;
  taskViewModal.open();
};

const handleSelectQuickFilter = async (value, option) => {
  masterParam.QuickFilter = option.value;
  quickFilter.text = option.label;

  if (value.includes("key_TaskGroup")) {
    quickFilter.text = `Nhóm công việc (${option.label})`;
  }

  await getData();
};

const handleSelectStatusFilter = async (value, option) => {
  masterParam.TaskStatus = option.value;
  statusFilter.text = `Trạng thái hoàn thành ${option.label}`;

  await getData();

};

const handleSelectSortFilter = async (value, option) => {
  masterParam.SortTaskBy = option.value;
  sortFilter.text = `Sắp xếp theo`;
  let itemSort = dropdownSortOptions.find((item) => option.key.includes(item.key));
  if(itemSort){
    sortFilter.text = `Sắp xếp theo ${itemSort.label} (${option.label}) `
  }

  await getData();

};

const initMasterParam = () => {
  masterParam.QuickFilter = 1;
  masterParam.TaskStatus = 1;
  masterParam.SortTaskBy = 1;
  masterParam.ProjectID = projectID.value;
  masterParam.PageIndex = 1;
  masterParam.PageSize = 20;
  masterParam.EmployeeID = employee.value.EmployeeID;
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
  totalRecord.value = res.totalRecord;
  pagination.itemCount = res.totalRecord;
};
</script>

<template>
  <div class="grid grid-task">
    <div class="grid-task-filter d-flex">
      <div class="m-mr16">
        <MButton
          :text="'Lấy dữ liệu'"
          :title="'Lấy lại dữ liệu'"
          :classCustom="'m-button-m grid-filter-btn'"
          leftIcon="mi-24 mi-reload"
          :classText="'m-mr8 m-ml8'"
          @click="getData"
        />
      </div>

      <div class="m-mr24">
        <n-dropdown
          trigger="click"
          :options="dropdownQuickFilterOptions"
          :show-arrow="true"
          @select="handleSelectQuickFilter"
          size="large"
        >
          <MButton
            :text="quickFilter.text"
            :title="'Chọn loại công việc'"
            :tag="'TypeTask'"
            :classCustom="'m-button-m grid-filter-btn'"
            leftIcon="mi-16 mi-grid-filter"
            rightIcon="mi-16 mi-carret-down"
            :classText="'m-mr8 m-ml8'"
          />
        </n-dropdown>
      </div>

      <div class="m-mr24">
        <n-dropdown
          trigger="click"
          :options="dropdownStatusOptions"
          :show-arrow="true"
          @select="handleSelectStatusFilter"
          size="large"
        >
          <MButton
            :text="statusFilter.text"
            :title="'Chọn loại trạng thái hoàn thành công việc'"
            :tag="'TypeStatusTask'"
            :classCustom="'m-button-m grid-filter-btn'"
            leftIcon="mi-16 mi-grid-status-done"
            rightIcon="mi-16 mi-carret-down"
            :classText="'m-mr8 m-ml8'"
          />
        </n-dropdown>
      </div>

      <div class="m-mr24">
        <n-dropdown
          trigger="click"
          :options="dropdownSortOptions"
          :show-arrow="true"
          @select="handleSelectSortFilter"
          size="large"
        >
          <MButton
            :text="sortFilter.text"
            :title="'Chọn loại trạng thái hoàn thành công việc'"
            :tag="'TypeStatusTask'"
            :classCustom="'m-button-m grid-filter-btn'"
            leftIcon="mi-16 mi-grid-status-done"
            rightIcon="mi-16 mi-carret-down"
            :classText="'m-mr8 m-ml8'"
          />
        </n-dropdown>
      </div>
    </div>

    <n-data-table
      id="resizeMe"
      class="text-medium"
      :columns="columns"
      :data="masterData"
      :pagination="pagination"
      :max-height="486"
      :min-height="486"
      :single-line="false"
      :scroll-x="2200"
    />
  </div>
</template>

<style>
.grid-task {
  background: #fff;
  margin: 16px;
  position: absolute;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  overflow: hidden;
  padding-top: 6px;
  height: calc(100vh - 90px);
  max-width: calc(100vw - 32px);
}

.grid-task-filter {
  padding: 0 8px 8px;
}

.n-data-table .n-data-table-th {
  padding: 8px 12px !important;
}

.n-progress.n-progress--circle {
  width: 24px !important;
}

.grid-filter-btn {
  background-color: #fff !important;
  color: #1f1f1f !important;
  font-size: 13px !important;
  font-weight: 400 !important;
}
</style>
