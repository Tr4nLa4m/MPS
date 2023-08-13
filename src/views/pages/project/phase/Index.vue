<script setup>
import { ref, computed, onMounted, h, reactive } from "vue";
import { useModal } from "vue-final-modal";
import { useStore } from "vuex";
import AddPhaseForm from "@/components/popup/form/phase/AddPhase.vue";
import AddTaskToPhase from "@/components/popup/form/phase/AddTaskToPhase.vue";
import { useRoute } from "vue-router";
import models from "@/utils/helper/models";
import {
  ModuleProject,
  ModuleContext,
  ModulePhase,
} from "@/store/moduleConstant";
import DatePickerCard from "@/components/cards/DatePicker.vue";
import EmployeeCard from "@/components/cards/Employee.vue";
import MConstant from "@/common/consts/MConstant";
import DeleteConfirm from "@/components/popup/form/DeleteConfirm.vue";
import { useMessages } from "@/utils/uses/base/useMessages";
import AddIssueToPhase from "@/components/popup/form/phase/AddIssueToPhase.vue";
import MButton from "@/components/button/MButton.vue";
import { nextTick } from "vue";
import { NDropdown, NProgress } from "naive-ui";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";

const TASK_COLLAPSE = "1",
  ISSUE_COLLAPSE = "2";
const store = useStore();
const route = useRoute();
const { goToDetailIssue } = useRoutePath();
const { success, error } = useMessages();
const masterTaskData = reactive({});
const masterIssueData = reactive({});
const masterParam = models.createPhasePagingByProjectParam();
const employee = computed(() => store.state[ModuleContext]?.employee);
const phases = computed(() => store.state[ModulePhase]?.phases);
const currentPhase = reactive({
  Data: {},
});
const currentDeleteData = reactive({
  task: {},
  issue: {}
})
const phaseMode = ref(MConstant.FormMode.Add);
const addPhaseModal = useModal({
  component: AddPhaseForm,
  attrs: {
    mode: phaseMode,
    phase: currentPhase,
    onCloseModal() {
      addPhaseModal.close();
    },

    async onUpdatedPhase() {
      await getData();
    },
  },
});

const confirmDeletePhaseModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá giai đoạn",
    content:
      "Dữ liệu giai đoạn sẽ bị xóa khỏi hệ thống. Bạn có chắc chắn muốn xóa giai đoạn?",

    onCloseModal() {
      confirmDeletePhaseModal.close();
    },

    async onDelete() {
      await deletePhase();
    },
  },
});

const getTaskPhaseData = computed(() => (phase) => {
  if (!masterTaskData[phase.PhaseID]) {
    return [];
  }

  return masterTaskData[phase.PhaseID];
});

const getIssuePhaseData = computed(() => (phase) => {
  if (!masterIssueData[phase.PhaseID]) {
    return [];
  }

  return masterIssueData[phase.PhaseID];
});

const addTaskToPhaseModal = useModal({
  component: AddTaskToPhase,
  attrs: {
    projectID: route.params.ProjectID,
    onCloseModal() {
      addTaskToPhaseModal.close();
    },
    async onChooseTasks(tasks) {
      await insertTasksToPhase(tasks);
    },
  },
});

const addIssueToPhaseModal = useModal({
  component: AddIssueToPhase,
  attrs: {
    projectID: route.params.ProjectID,
    onCloseModal() {
      addIssueToPhaseModal.close();
    },
    async onChooseIssues(issues) {
      await insertIssuesToPhase(issues);
    },
  },
});

const deleteTaskPhaseConfirmModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá công việc khỏi giai đoạn",
    content:
      "Dữ liệu công việc sẽ bị xóa khỏi giai đoạn. Bạn có chắc chắn muốn xóa công việc?",

    onCloseModal() {
      deleteTaskPhaseConfirmModal.close();
    },

    async onDelete() {
      await deleteTaskPhase();
      deleteTaskPhaseConfirmModal.close();
    },
  },
});

const deleteIssuePhaseConfirmModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá vấn đề khỏi giai đoạn",
    content:
      "Dữ liệu vấn đề sẽ bị xóa khỏi giai đoạn. Bạn có chắc chắn muốn xóa vấn đề?",

    onCloseModal() {
      deleteIssuePhaseConfirmModal.close();
    },

    async onDelete() {
      await deleteIssuePhase();
      deleteIssuePhaseConfirmModal.close();
    },
  },
})

const taskColumns = ref([
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
    title: "Tiến độ",
    key: "Progress",
    render(row, index) {
      return h("div", { class: "d-flex flex-align-center" }, [
        h(NProgress, {
          type: "circle",
          percentage: row.Progress,
          showIndicator: false,
          strokeWidth: 10,
        }),
        h("div", { class: "m-ml16 text-link" }, [`${row.Progress}%`]),
      ]);
    },
    width: 80,
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
    width: 200,
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
    title: "Action",
    key: "ActionRecord",
    width: 50,
    render(row, index) {
      const handleSelectDropdown = (key) => {
        if (key == "deleteRecord") {
          currentDeleteData.task = row;
          currentPhase.Data['PhaseID'] = row.PhaseID;
          deleteTaskPhaseConfirmModal.open();
        }
      };
      return h(
        NDropdown,
        {
          options: dropdownPhaseItemRecord,
          showArrow: true,
          trigger: "click",
          onSelect: handleSelectDropdown,
        },
        [
          h(MButton, {
            title: "Thêm",
            classCustom: "m-button-m detail-issue-btn m-mr8",
            leftIcon: "mi-24 mi-more-custom",
            classText: "m-mr8",
            class: "btn-transparent",
          }),
        ]
      );
    },
  },
]);

const issueColumns = ref([
  {
    title: "Loại",
    key: "IssueType",
    width: 40,
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
    width: 60,
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
    width: 100,
  },
  {
    title: "Người xử lý",
    key: "AssigneeName",
    render(row, index) {
      return h("div", { class: "text-link-v2" }, row.AssigneeName);
    },
    width: 120,
  },
  {
    title: "Action",
    key: "ActionRecord",
    width: 50,
    render(row, index) {
      const handleSelectDropdown = (key) => {
        if (key == "deleteRecord") {
          currentDeleteData.issue = row;
          currentPhase.Data['PhaseID'] = row.PhaseID;
          deleteIssuePhaseConfirmModal.open();
        }
      };
      return h(
        NDropdown,
        {
          options: dropdownPhaseItemRecord,
          showArrow: true,
          trigger: "click",
          onSelect: handleSelectDropdown,
        },
        [
          h(MButton, {
            title: "Thêm",
            classCustom: "m-button-m detail-issue-btn m-mr8",
            leftIcon: "mi-24 mi-more-custom",
            classText: "m-mr8",
            class: "btn-transparent",
          }),
        ]
      );
    },
  },
]);

const dropdownPhaseItemRecord = [
  {
    key: "deleteRecord",
    label: () => h("div", { class: "danger" }, "Xoá"),
  },
];

const dropdownPhaseOptions = [
  {
    label: "Sửa thông tin",
    key: "key_editPhase",
  },
  {
    label: () => h("div", { class: "danger" }, "Xoá"),
    key: "key_deletePhase",
  },
];

onMounted(async () => {
  initMasterParam();

  await getData();
});

const initMasterParam = () => {
  masterParam.PageSize = 10;
  masterParam.PageIndex = 1;
  masterParam.SortBy = 1;
  masterParam.ProjectID = route.params.ProjectID;
  masterParam.EmployeeID = employee.value.EmployeeID;
};

const getData = async () => {
  let param = {
    data: masterParam,
  };

  await store.dispatch(ModulePhase + "/getPhaseByProject", param);
};

const getTaskPhase = async (phase) => {
  let param = {
    data: {
      PhaseID: phase.PhaseID,
    },
  };

  masterTaskData[phase.PhaseID] = await store.dispatch(
    ModulePhase + "/getTasks",
    param
  );
};

const getIssuePhase = async (phase) => {
  let param = {
    data: {
      PhaseID: phase.PhaseID,
    },
  };

  masterIssueData[phase.PhaseID] = await store.dispatch(
    ModulePhase + "/getIssues",
    param
  );
};

const insertTasksToPhase = async (tasks) => {
  if (!tasks || tasks.length == 0) {
    return;
  }

  let initParam = models.createAddTaskToPhaseParam();
  initParam.TaskIDs = tasks.map((item) => item.TaskID);
  initParam.PhaseID = currentPhase.Data.PhaseID;

  let param = {
    data: initParam,
  };

  let res = await store.dispatch(ModulePhase + "/insertTaskPhase", param);
  if (res > 0) {
    await getData();
  }
};

const insertIssuesToPhase = async (issues) => {
  if (!issues || issues.length == 0) {
    return;
  }

  let initParam = models.createAddIssueToPhaseParam();
  initParam.IssueIDs = issues.map((item) => item.IssueID);
  initParam.PhaseID = currentPhase.Data.PhaseID;

  let param = {
    data: initParam,
  };

  let res = await store.dispatch(ModulePhase + "/insertIssuePhase", param);
  if (res > 0) {
    await getData();
  }
};

const deletePhase = async () => {
  let param = {
    data: {
      PhaseID: currentPhase.Data.PhaseID,
    },
    onSuccess: () => success("Đã xoá giai đoạn khỏi dự án"),
    onFailure: () => error("Có lỗi xảy ra khi xoá giai đoạn"),
  };

  let res = await store.dispatch(ModulePhase + "/deletePhase", param);
  if (res > 0) {
    await getData();
  }

  confirmDeletePhaseModal.close();
};

const deleteTaskPhase = async () => {
  if(!currentDeleteData.task.TaskID){
    return;
  }
  let param = {
    data: currentDeleteData.task,
    onSuccess: () => success('Xoá công việc khỏi giai đoạn thành công'),
    onFailure: () => error('Có lỗi xảy ra khi xoá công việc khỏi giai đoạn')
  };

  let res = await store.dispatch(ModulePhase + "/deleteTaskPhase", param);
  if(res > 0){
    await getTaskPhase(currentPhase.Data);
    await getData();
  }
};

const deleteIssuePhase = async () => {
  if(!currentDeleteData.issue.IssueID){
    return;
  }
  let param = {
    data: currentDeleteData.issue,
    onSuccess: () => success('Xoá vấn đề khỏi giai đoạn thành công'),
    onFailure: () => error('Có lỗi xảy ra khi xoá vấn đề khỏi giai đoạn')
  };

  let res = await store.dispatch(ModulePhase + "/deleteIssuePhase", param);
  if(res > 0){
    await getIssuePhase(currentPhase.Data);
    await getData();
  }
};

const btnAddPhase_click = () => {
  phaseMode.value = MConstant.FormMode.Add;
  addPhaseModal.open();
};

const btnAddTaskToPhase_click = (e, collapsed, phase) => {
  addTaskToPhaseModal.open();
  currentPhase.Data = phase;
  collapsed = false;
  e.preventDefault();
  e.stopPropagation();
};

const btnAddIssueToPhase_click = (e, collapsed, phase) => {
  addIssueToPhaseModal.open();
  currentPhase.Data = phase;
  collapsed = false;
  e.preventDefault();
  e.stopPropagation();
};

const btnActionPhase_click = (key, option, phase) => {
  switch (key) {
    case "key_editPhase":
      phaseMode.value = MConstant.FormMode.Edit;
      currentPhase.Data = phase;
      addPhaseModal.open();
      break;
    case "key_deletePhase":
      currentPhase.Data = phase;
      confirmDeletePhaseModal.open();
      break;

    default:
      break;
  }
};

const handleItemHeaderClick = async (name, expanded, phase) => {
  if (!expanded) {
    return;
  }

  if (name == TASK_COLLAPSE) {
    await getTaskPhase(phase);
  }

  if (name == ISSUE_COLLAPSE) {
    await getIssuePhase(phase);
  }
};
</script>

<template>
  <div class="project-container project-content-wrapper m-p16">
    <n-scrollbar :style="'max-height: calc(100vh - 90px)'">
      <div class="phases-header">
        <div class="phase-title m-pr32 m-pb8">
          <div class="text-xl">Giai đoạn</div>
        </div>

        <div class="tool-bar flex-row">
          <div class="">
            <MButton
              :text="'Thêm'"
              :title="'Thêm giai đoạn'"
              :classCustom="'m-button-m m-mr8'"
              leftIcon="mi-24 mi-plus-white"
              :classText="'m-mr8 m-ml8'"
              @click="btnAddPhase_click"
            />
          </div>

          <div class="flex-1"></div>

          <div class="">
            <MIconInput
              :placeholder="'Tìm kiếm theo tên giai đoạn'"
              :iconLeft="'mi-18 mi-search-before'"
              :customClass="'m-m0'"
              :inputClass="'no-border'"
              v-model="searchText"
            />
          </div>
        </div>
      </div>

      <div class="phase-content">
        <div class="list-phase">
          <div class="phase-item m-mb24" v-for="phase in phases">
            <div class="header flex-row flex-jsp">
              <div class="text-large">{{ phase.PhaseName }}</div>
              <div class="">
                <n-dropdown
                  trigger="click"
                  :options="dropdownPhaseOptions"
                  :show-arrow="true"
                  @select="
                    (key, option) => btnActionPhase_click(key, option, phase)
                  "
                >
                  <MButton
                    :title="'Thêm'"
                    :classCustom="'m-button-m detail-issue-btn m-mr8'"
                    leftIcon="mi-24 mi-more-custom"
                    :classText="'m-mr8'"
                    class="btn-transparent"
                  />
                </n-dropdown>
              </div>
            </div>

            <div class="content m-pt8">
              <n-collapse
                @item-header-click="
                  ({ name, expanded }) =>
                    handleItemHeaderClick(name, expanded, phase)
                "
              >
                <n-collapse-item title="Công việc" :name="TASK_COLLAPSE">
                  <template #header="{ collapsed }">
                    <div class="flex-jsp flex-align-center text-default m-w100">
                      <div class="text-bold">
                        {{ `Công việc (${phase.NumTask})` }}
                      </div>
                      <div class="flex-1"></div>
                      <MButton
                        :text="'Thêm'"
                        :title="'Thêm công việc có sẵn vào giai đoạn'"
                        :classCustom="'m-button-m detail-issue-btn m-mr8'"
                        leftIcon="mi-24 mi-plus-blue"
                        :classText="'m-mr8'"
                        class="btn-transparent"
                        @click="
                          (event) =>
                            btnAddTaskToPhase_click(event, collapsed, phase)
                        "
                      />
                    </div>
                  </template>
                  <div>
                    <n-data-table
                      id="resizeMe"
                      class="text-medium table-2"
                      :columns="taskColumns"
                      :data="getTaskPhaseData(phase)"
                      :max-height="230"
                      :min-height="50"
                      :single-line="false"
                    />
                  </div>
                </n-collapse-item>
                <n-collapse-item title="Vấn đề" :name="ISSUE_COLLAPSE">
                  <template #header>
                    <div class="flex-jsp flex-align-center text-default m-w100">
                      <div class="text-bold">
                        {{ `Vấn đề (${phase.NumIssue})` }}
                      </div>
                      <div class="flex-1"></div>
                      <MButton
                        :text="'Thêm'"
                        :title="'Thêm vấn đề có sẵn vào giai đoạn'"
                        :classCustom="'m-button-m detail-issue-btn m-mr8'"
                        leftIcon="mi-24 mi-plus-blue"
                        :classText="'m-mr8'"
                        class="btn-transparent"
                        @click="
                          (event) =>
                            btnAddIssueToPhase_click(event, collapsed, phase)
                        "
                      />
                    </div>
                  </template>
                  <div class="">
                    <n-data-table
                      id="resizeMe"
                      class="text-medium table-2"
                      :columns="issueColumns"
                      :data="getIssuePhaseData(phase)"
                      :max-height="230"
                      :min-height="50"
                      :single-line="false"
                    />
                  </div>
                </n-collapse-item>
              </n-collapse>
            </div>
          </div>
        </div>
      </div>
    </n-scrollbar>
  </div>
</template>

<style>
.project-content-wrapper {
  background: #fff;
  margin: 16px;
  position: absolute;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 8px 0;
  height: calc(100vh - 90px);
  width: calc(100vw - 32px);
}

.phases-header .tool-bar {
  padding: 0 32px;
}

.phase-content .list-phase {
  padding: 16px 32px;
}

.phase-content .list-phase .phase-item {
  background-color: #f7f7f8;
  padding: 8px 8px 8px 16px;
  border-radius: 8px;
}

#resizeMe {
  background-color: #ffffff !important;
}
</style>
