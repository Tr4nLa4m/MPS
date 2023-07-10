<script setup>
import {
  defineComponent,
  defineEmits,
  h,
  onMounted,
  ref,
  computed,
  reactive,
  inject,
  nextTick,
} from "vue";
import Editor from "@tinymce/tinymce-vue";
import { useMessage } from "naive-ui";
import DropdownChooseDeadline from "@/views/pages/common/dropdown/DropdownChooseDeadline.vue";
import DropdownChooseProgress from "@/views/pages/common/dropdown/DropdownChooseProgress.vue";
import { useModal } from "vue-final-modal";
import FilterEmployeeForm from "@/views/popup/form/FilterEmployee.vue";
import DeleteConfirmForm from "@/views/popup/form/DeleteConfirm.vue";
import { useStore } from "vuex";
import {
  ModuleProject,
  ModuleUser,
  ModuleTask,
  ModuleEmployee,
} from "@/store/moduleConstant";
import { useMessages } from "@/utils/uses/base/useMessages";
import MSplitButton from "@/components/button/MSplitButton.vue";
import CommentList from "../bodyForm/taskView/CommentList.vue";
import ActivityList from "../bodyForm/taskView/ActivityList.vue";
import { cloneDeep } from "lodash";

const departmentKeyPrefix = "DEPARTMENT_";
const emit = defineEmits(["closeModal", "submit", "deleteTask"]);
const props = defineProps({
  TaskID: {
    type: String,
    default: "",
  },
});
const message = useMessage();
const store = useStore();
const commonFn = inject("CommonFn");
const models = inject("Model");
const employeeCreatorName = ref("");
const currentProject = reactive({
  ProjectID: null,
});
let originalData = {};

const { warning, success, error } = useMessages();
let isEdited = false;

let master = reactive({
  Project: {
    ProjectID: null,
  },
  TaskGroup: {
    TaskGroupID: null,
  },
  ProjectID: null,
  TaskName: null,
  Performer: {},
  StartDate: null,
  EndDate: null,
  Range: null,
  Description: null,
  Checklists: [],
  Subtasks: [],
  CreatorID: null,
  TaskGroupID: null,
  PerformerID: null,
  PerformerAvatar: null,
  Progress: 0,
});

const loading = reactive({
  CommentTab: false,
});

const progressRef = ref("0%");

const employee = computed(() => store.state[ModuleUser]?.employee);

const btnChooseProgress = ref(null);

// PROJECT SELECT
const departmentProjects = computed(() => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  return rawDepartmentProjects?.map((item) => {
    return {
      ...item,
      ProjectID: departmentKeyPrefix + item.DepartmentID,
      ProjectName: item.DepartmentName,
      disabled: true,
    };
  });
});

const getDefaultDepartmentProject = () => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  for (let index = 0; index < rawDepartmentProjects.length; index++) {
    const project = rawDepartmentProjects[index].Projects.find(
      (pro) => pro.ProjectID == master.ProjectID
    );
    if (project) {
      master.Project = project;
      return;
    }
  }
};

// TASK GROUP SELECT
const taskGroups = computed(() => store.state[ModuleTask]?.taskGroups);

const getDefaultTaskGroup = () => {
  let rawData = store.state[ModuleTask]?.taskGroups;
  let taskGroupInit = rawData.find(
    (item) => item.TaskGroupID == master.TaskGroupID
  );
  if (taskGroupInit) {
    master.TaskGroup = taskGroupInit;
  }
};

const filterEmployeeModal = useModal({
  component: FilterEmployeeForm,
  attrs: {
    project: currentProject,

    onCloseModal() {
      filterEmployeeModal.close();
    },
    async onChooseEmployee(employee) {
      if (subtaskOpenModelIndex.value || subtaskOpenModelIndex.value == 0) {
        master.Subtasks[subtaskOpenModelIndex.value].Performer = employee;
        master.Subtasks[subtaskOpenModelIndex.value].PerformerID =
          employee?.EmployeeID;
      } else {
        showEl.performer = true;
        master.Performer = employee;
        master.PerformerID = employee.EmployeeID;
        await handleUpdateFieldV2(
          "PerformerID",
          2,
          originalData.Performer.FullName,
          employee.FullName
        );
      }
    },
  },
});

const deleteConfirmModal = useModal({
  component: DeleteConfirmForm,
  attrs: {
    title: "Xoá công việc",
    content:
      "Dữ liệu công việc sẽ bị xóa khỏi hệ thống. Bạn có chắc chắn muốn xóa công việc?",

    onCloseModal() {
      deleteConfirmModal.close();
    },

    async onDelete() {
      let param = {
        data: {
          TaskID: master.TaskID,
        },
      };

      let res = await store.dispatch(ModuleTask + "/deleteTask", param);
      emit("deleteTask");
    },
  },
});

// MOUNTED HOOK
onMounted(async () => {
  let getTaskParam = {
    data: {
      TaskID: props.TaskID,
    },
  };
  // lấy task detail
  let task = await store.dispatch(ModuleTask + "/getByID", getTaskParam);

  master = reactive({
    ...master,
    ...task,
  });

  originalData = cloneDeep(master);

  // lấy danh sách các nhóm công việc
  await store.dispatch(ModuleTask + "/getTaskGroups");

  // lấy danh sách các dự án
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);

  // lấy tên người giao việc
  let creator = await store.dispatch(ModuleEmployee + "/getEmployeeByID", {
    data: {
      EmployeeID: master.CreatorID,
    },
  });

  employeeCreatorName.value = creator.FullName;

  initDataMaster();

  initConfig();
});

const initDataMaster = () => {
  getDefaultTaskGroup();
  getDefaultDepartmentProject();

  currentProject.ProjectID = master.ProjectID;
};

const initConfig = () => {
  loading.CommentTab = true;
  showEl.btnDone = master.Progress == 100;
  showEl.btnDescription = !(
    master.Description && master.Description.length > 0
  );

  showEl.deadline = master.StartDate || master.EndDate;

  showEl.subtasks = master.Subtasks.length > 0;
};

const renderDropdownChooseDeadline = () => {
  return h(
    "div",
    {
      style: "display: flex; align-items: center; padding: 8px 12px;",
    },
    [
      h(DropdownChooseDeadline, {
        onChooseDate: handleUpdateDeadline,
      }),
    ]
  );
};

const renderDropdownChooseProgress = () => {
  return h(
    "div",
    {
      style: "display: flex; align-items: center; padding: 8px 12px;",
    },
    [
      h(DropdownChooseProgress, {
        progress: master.Progress,
        onChooseProgress: handleUpdateProgress,
      }),
    ]
  );
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

const dropdownTaskOptions = [
  // {
  //   label: "Thông tin dự án/nhóm",
  //   key: "key_projectInfo",
  //   icon: renderIcon("mi-infomation"),
  // },
  {
    label: () => h("div", { class: "danger" }, "Xoá"),
    key: "key_delete",
    icon: renderIcon("mi-delete-close"),
  },
];

const dropdownChooseProgressOptions = commonFn.initDropdownOptions(
  renderDropdownChooseProgress
);

const handleSelectDropdownTask = (key, option) => {
  switch (key) {
    case "key_delete":
      deleteConfirmModal.open();
      break;

    default:
      break;
  }
};

const dropdownChooseDeadlineConfig = reactive({
  options: commonFn.initDropdownOptions(renderDropdownChooseDeadline),
  xRef: 0,
  yRef: 0,
  trigger: "manual",
  placement: "top",
});

const tinymceInit = {
  plugins: ["autolink", "link", "lists", "autoresize"], // Add any other plugins you want to use
  toolbar:
    "bold italic underline fontsize forecolor backcolor alignleft aligncenter alignright alignfull lineheight bullist numlist  | customInsertButton ", // Customize the toolbar buttons
  // Add any other initialization options you need
  line_height_formats: "1 1.2 1.4 1.6 2",
  statusbar: false,
  menubar: false,
  height: 150,
  content_style:
    "body { background-color: #f5f5f5; }" +
    "p {margin-block-start: 4px;margin-block-end: 4px;}",
  font_family_formats:
    "'GoogleSans-Regular',Roboto, Helvetica, Arial, sans-serif",
  auto_focus: true,
  setup: (editor) => {
    editor.ui.registry.addButton("customInsertButton", {
      text: "Lưu",
      onAction: async (_) => {
        let res = await handleUpdateField("Description");
        if (res > 0) {
          showEl.editor = false;
          if (!master.Description) {
            showEl.btnDescription = true;
          }
        }
      },
    });

    editor.ui.registry.addButton("customDeleteButton", {
      text: "Huỷ",
      onAction: (_) => {
        showEl.editor = false;
        master.Description = "";
        showEl.btnDescription = true;
      },
    });
  },
  init_instance_callback: function (editor) {
    editor.on("blur", async () => {
      let res = await handleUpdateField("Description");
      if (res > 0) {
        if (!master.Description) {
          showEl.btnDescription = true;
        }
        showEl.editor = false;
      }
    });
  },
};

const showEl = reactive({
  btnDescription: true,
  btnCheckList: true,
  dropdownChooseDeadline: false,
  btnDone: master.Progress == 100,
  editor: false,
  checklist: false,
  subtasks: false,
  performer: false,
  deadline: false,
});

// cờ gắn giá trị hiện modal chọn nhân viên task chính hay subtask
let subtaskOpenModelIndex = ref(null);
let subtaskShowDropdownIndex = ref(null);

const btnChooseEmployee_click = (index) => {
  subtaskOpenModelIndex.value = null;
  if (index || index === 0) {
    subtaskOpenModelIndex.value = index;
  }

  filterEmployeeModal.open();
};

const btnChooseDeadline_click = (e, index) => {
  subtaskShowDropdownIndex.value = null;
  if (index || index === 0) {
    subtaskShowDropdownIndex.value = index;
  }
  dropdownChooseDeadlineConfig.xRef = e.clientX;
  dropdownChooseDeadlineConfig.yRef = e.clientY;
  showEl.dropdownChooseDeadline = true;
};

const handleUpdateDeadline = async (data) => {
  showEl.dropdownChooseDeadline = false;
  if (subtaskShowDropdownIndex.value || subtaskShowDropdownIndex.value === 0) {
    await handleUpdateField(
      "StartDate",
      2,
      master.Subtasks[subtaskShowDropdownIndex.value].TaskID
    );
    await handleUpdateField(
      "EndDate",
      2,
      master.Subtasks[subtaskShowDropdownIndex.value].TaskID
    );
    master.Subtasks[subtaskShowDropdownIndex.value]["StartDate"] =
      data.StartDate;
    master.Subtasks[subtaskShowDropdownIndex.value]["EndDate"] = data.EndDate;
    master.Subtasks[subtaskShowDropdownIndex.value]["Range"] = data.Range;
  } else {
    master.StartDate = data.StartDate;
    master.EndDate = data.EndDate;
    master.Range = data.Range;
    showEl.deadline = true;

    await handleUpdateField("StartDate", 2, '', '', '' + master.StartDate);
    await handleUpdateField("EndDate", 2, '', '', '' + master.EndDate);
  }
};

const handleUpdateProgress = (progress) => {
  master.Progress = progress;
  progressRef.value = `${master.Progress}%`;
  btnChooseProgress.value.handleClickShowDropdown();
};

const handleUpdateProgressSubtask = (checked, index) => {
  let progress = checked ? 100 : 0;
  master.Subtasks[index]["Progress"] = progress;
};

const handleUpdateField = async (
  field,
  actionType = 2,
  taskID = master.TaskID
) => {
  let res = 1;
  if (originalData[field] != master[field]) {
    let payload = models.createUpdateTaskFieldParam({
      TaskID: taskID,
      FieldName: field,
      FieldValue: master[field],
      OldValue: originalData[field],
      TypeValue: typeof master[field],
      CreatedBy: employee.value.EmployeeCode,
      ActionType: actionType,
    });
    res = await updateTaskField(payload);
    // gắn cờ là đã sửa
    isEdited = true;
    if (res > 0) {
      originalData[field] = master[field];
    }
  }

  return res;
};

const handleUpdateFieldV2 = async (
  field,
  actionType = 2,
  oldText = "",
  newText = "",
  fieldValue
) => {
  let res = 1;
  if(!fieldValue){
    fieldValue = master[field];
  }
  if (originalData[field] != master[field]) {
    let payload = models.createUpdateTaskFieldParam({
      TaskID: master.TaskID,
      FieldName: field,
      FieldValue: fieldValue,
      OldValue: originalData[field],
      TypeValue: typeof master[field],
      CreatedBy: employee.value.EmployeeCode,
      ActionType: actionType,
      OldTextValue: oldText,
      OldTextValue: newText,
    });

    res = await updateTaskField(payload);
    isEdited = true;
    if (res > 0) {
      originalData[field] = master[field];
    }
  }

  return res;
};


const handleChangeTaskGroup = async (value, taskgroup) => {
  return await handleUpdateField("TaskGroupID");
};

const handleBlurTaskName = async (e) => {
  return await handleUpdateField("TaskName");
};

const closeModal = (e) => {
  emit("closeModal", isEdited);
};

const btnDeleteCheckList_click = (index) => {
  master.Checklists.splice(index, 1);
  if (master.Checklists.length === 0) {
    showEl.checklist = false;
  }
};

const btnDeleteSubtask_click = (index) => {
  master.Subtasks.splice(index, 1);
  if (master.Subtasks.length === 0) {
    showEl.subtasks = false;
  }
};

const btnAddCheckList_click = () => {
  if (!showEl.checklist) {
    showEl.checklist = true;
  }

  let checklistInvalid = master.Checklists.find(
    (checklist) => !checklist.ChecklistName
  );
  if (checklistInvalid) {
    warning("Hãy bổ sung đầy đủ thông tin checklist trước khi thêm");
    return;
  }

  master.Checklists.push(models.createChecklist());
};

const btnAddSubtask_click = () => {
  if (!showEl.subtasks) {
    showEl.subtasks = true;
  }

  let subtaskInvalid = master.Subtasks.find((subtask) => !subtask.TaskName);
  if (subtaskInvalid) {
    warning("Hãy bổ sung đầy đủ thông tin tên công việc con trước khi thêm");
    return;
  }
  debugger;
  let newSubTask = models.createSubTask({
    ProjectID: master.Project.ProjectID,
  });
  master.Subtasks.push(newSubTask);
};

const btnDone_click = async () => {
  let payload = models.createUpdateTaskFieldParam({
    TaskID: master.TaskID,
    FieldName: "Progress",
    FieldValue: "100",
    OldValue: `${master.Progress}`,
    TypeValue: typeof master.Progress,
    CreatedBy: employee.value.EmployeeCode,
  });

  let res = await updateTaskField(payload);
  if (res > 0) {
    showEl.btnDone = true;
    master.Progress = 100;
  }
};

const btnNotDone_click = () => {
  showEl.btnDone = false;
  master.Progress = 0;
  progressRef.value = `${master.Progress}%`;
};

const btnSave_click = async () => {
  // collect data
  let data = master;
  data.CreatorID = employee.value.EmployeeIDe;
  const payload = {
    Data: data,
    onSuccess: () => {
      success("Thêm mới công việc thành công");
      emit("closeModal");
    },
  };
  let res = await store.dispatch(ModuleTask + "/createTask", payload);
  console.log(res);
};

const updateTaskField = async (payload) => {
  const param = {
    data: payload,
    onFailure: () => {
      error("Cập nhật công việc không thành công");
    },
  };

  return await store.dispatch(ModuleTask + "/updateTaskField", param);
};

const onChecklistAway = (e) => {
  if (!showEl.checklist) {
    return;
  }
  const newChecklist = master.Checklists.filter(
    (item) => item.ChecklistName && item.ChecklistName.length > 0
  );

  master.Checklists = newChecklist;

  if (master.Checklists.length == 0) {
    showEl.checklist = false;
  }
};

const onDropdownDeadlineAway = () => {
  showEl.dropdownChooseDeadline = false;
};

const onSubtaskAway = (e) => {
  if (!showEl.subtasks) {
    return;
  }
  const newSubtask = master.Subtasks.filter(
    (item) => item.TaskName && item.TaskName.length > 0
  );

  master.Subtasks = newSubtask;

  if (master.Subtasks.length == 0) {
    showEl.subtasks = false;
  }
};

const clickExpandEditor = () => {
  showEl.editor = true;
  showEl.btnDescription = false;
};
</script>

<template>
  <VModal customClass="form-task">
    <template #default>
      <div class="m-h100 overflow-auto">
        <div class="form-task--wrapper">
          <!-- Header form -->
          <div class="form-header flex-row m-pt8 m-pb16 m-pr8">
            <div class="">
              <MSplitButton
                v-if="!showEl.btnDone"
                ref="btnChooseProgress"
                :text="'Hoàn thành'"
                :title="'Tiến độ'"
                :classCustom="'m-button-m btn-progress text-medium'"
                :options="dropdownChooseProgressOptions"
                :splitText="progressRef"
                :border="true"
                splitIcon="mi-carret-down"
                splitButtonClass="transparent"
                @onClick="btnDone_click"
              />

              <MButton
                v-if="showEl.btnDone"
                text="Đã hoàn thành"
                class="m-button-m text-medium m-white m-pl8 m-pr8"
                @click="btnNotDone_click"
              />
            </div>
            <div class="flex-1"></div>
            <div class="flex-row-end">
              <MButtonIcon
                classCustom="m-ml8 m-p4"
                icon="mi-comment"
                title="Bình luận"
              />

              <MButtonIcon
                classCustom="m-ml8 m-p4"
                icon="mi-sub-task"
                title="Công việc con"
              />

              <MButtonIcon
                classCustom="m-ml8 m-p4"
                icon="mi-attachment"
                title="Tài liệu"
              />

              <MButtonIcon
                classCustom="m-ml8 m-p4"
                icon="mi-label"
                title="Gắn thẻ"
              />

              <n-dropdown
                trigger="click"
                :options="dropdownTaskOptions"
                :show-arrow="true"
                @select="handleSelectDropdownTask"
                size="large"
              >
                <MButtonIcon
                  classCustom="m-ml8 m-p4"
                  icon="mi-more-custom"
                  title="Thêm"
                />
              </n-dropdown>

              <MButtonIcon
                classCustom="m-ml8 m-p8"
                icon="mi-close mi-16"
                title="Đóng"
                @click="closeModal"
              />
            </div>
          </div>

          <!-- Body form -->
          <n-scrollbar trigger="hover" style="max-height: 540px">
            <div class="form-body line">
              <div class="task-creator m-ml8">
                <div class="text-small">
                  Người giao việc : &nbsp;
                  <span class="text-link-small">{{ employeeCreatorName }}</span>
                </div>
              </div>

              <div class="header-task m-mb18">
                <div class="row">
                  <div class="form-label m-pl12">Dự án:</div>
                  <MTreeSelect
                    :data="departmentProjects"
                    class="project"
                    label-field="ProjectName"
                    key-field="ProjectID"
                    children-field="Projects"
                    :disabled="true"
                    v-model="master.ProjectID"
                  >
                  </MTreeSelect>
                </div>

                <div class="row">
                  <div class="form-label m-pl12">Nhóm công việc:</div>
                  <MTreeSelect
                    :data="taskGroups"
                    label-field="TaskGroupName"
                    key-field="TaskGroupID"
                    class="project"
                    v-model="master.TaskGroupID"
                    :enableChange="true"
                    @onChange="handleChangeTaskGroup"
                  >
                  </MTreeSelect>
                </div>
              </div>

              <div class="task-name m-pl8 m-pr8">
                <MInput
                  placeholder="Nhập tên công việc"
                  customClass="text-large"
                  :border="false"
                  :enableBlur="true"
                  @onBlur="handleBlurTaskName"
                  v-model="master.TaskName"
                />
              </div>

              <div class="flex-jsp flex-align-center m-mt16 m-mb16 m-pl8 m-pr8">
                <MButton
                  v-if="!master.Performer?.EmployeeID"
                  text="Chọn người thực hiện"
                  leftIcon="mi-question-circle"
                  classCustom="btn-custom-1 text-medium m-mr16 m-w100"
                  @click="btnChooseEmployee_click()"
                />

                <div
                  class="btn-custom-1 flex-row flex-align-center text-medium m-mr16 m-w100"
                  v-if="master.Performer?.EmployeeID"
                  @click="btnChooseEmployee_click()"
                >
                  <img :src="master.Performer.Avatar" class="mi-32" />
                  <div class="performer m-ml16">
                    <div class="label-performer">Người thực hiện</div>
                    <div class="key-performer text-bold">
                      {{ master.Performer.FullName }}
                    </div>
                  </div>
                </div>

                <MButton
                  v-if="!showEl.deadline"
                  text="Chọn hạn hoàn thành"
                  leftIcon="mi-calender-circle "
                  classCustom="btn-custom-1 text-medium m-w100"
                  @click="btnChooseDeadline_click"
                />

                <div
                  v-if="showEl.deadline"
                  class="btn-custom-1 flex-row flex-align-center text-medium m-mr16 m-w100"
                  @click="btnChooseDeadline_click"
                >
                  <div class="mi-32 flex-center calender-active">
                    <div class="mi-24 mi-calender-circle-img"></div>
                  </div>
                  <div class="deadline m-ml16">
                    <div class="calendar-label">
                      Từ &nbsp;&nbsp;&nbsp;&nbsp;
                      <span class="text-bold">{{
                        commonFn.formatDate(master.StartDate)
                      }}</span>
                    </div>
                    <div class="calendar-label">
                      Đến &nbsp;
                      <span class="text-bold">{{
                        commonFn.formatDate(master.EndDate)
                      }}</span>
                    </div>
                    <div class="calendar-label label-range">
                      Tổng thời gian &nbsp;&nbsp;
                      <span class="text-bold">{{
                        commonFn.calculateTimePeriod(
                          new Date(master.EndDate).getTime() -
                            new Date(master.StartDate).getTime()
                        )
                      }}</span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- TASK DESCRIPTION -->
              <div class="task-description m-mr8">
                <MButton
                  v-if="showEl.btnDescription"
                  leftIcon="mi-add-description mi-16 m-ml4 m-mr4"
                  text="Nhập mô tả"
                  classCustom="btn-expand text-link m-button-m"
                  @click="clickExpandEditor"
                />

                <div class="">
                  <div
                    class="flex-row flex-align-center m-mb8"
                    v-if="master.Description || showEl.editor"
                  >
                    <div class="mi-24 mi-description-v2 m-mr8"></div>
                    <div class="title-medium">Mô tả</div>
                  </div>
                  <Editor
                    v-if="showEl.editor"
                    api-key="9038dr0d32vvyxk56tg57fbo4w5hgp16g574iyezusedlm3f"
                    v-model="master.Description"
                    :init="tinymceInit"
                  />
                </div>

                <div v-if="!showEl.editor" @click="clickExpandEditor">
                  <div
                    class="m-ml8 m-mb8"
                    v-if="master.Description"
                    v-html="master.Description"
                  ></div>
                </div>
              </div>

              <div class="task-checklist" v-click-away="onChecklistAway">
                <div v-if="showEl.checklist" class="">
                  <div class="flex-row flex-align-center m-mb8">
                    <div class="mi-24 mi-checklist-v2 m-mr8"></div>
                    <div class="title-medium">Checklist</div>
                  </div>

                  <div class="">
                    <div
                      v-for="(item, index) in master.Checklists"
                      class="checklist-item"
                    >
                      <div class="prefix">{{ `${index + 1}. ` }}</div>
                      <input
                        v-model="item.ChecklistName"
                        class="checklist-item-text m-mb2"
                      />
                      <div class="">
                        <MButtonIcon
                          icon="mi-delete-red mi-24"
                          title="Xoá"
                          @click="btnDeleteCheckList_click(index)"
                        />
                      </div>
                    </div>
                  </div>
                </div>

                <MButton
                  v-if="showEl.btnCheckList"
                  leftIcon="mi-plus-blue"
                  text="Thêm checklist"
                  classCustom="btn-expand text-link m-button-m m-mt8"
                  @click="btnAddCheckList_click"
                />
              </div>

              <div class="task-subtask m-pb8" v-click-away="onSubtaskAway">
                <div class="" v-if="showEl.subtasks">
                  <div class="flex-row flex-align-center m-mb8">
                    <div class="mi-24 mi-subtask-v2 m-mr8"></div>
                    <div class="title-medium">Công việc con</div>
                  </div>

                  <div class="subtask-list">
                    <div class="line"></div>
                    <div
                      v-for="(item, index) in master.Subtasks"
                      class="subtask-item flex-row flex-align-center"
                    >
                      <n-checkbox
                        @update:checked="
                          (checked) =>
                            handleUpdateProgressSubtask(checked, index)
                        "
                        class="m-mr8"
                        size="large"
                      />

                      <input
                        v-model="item.TaskName"
                        class="subtask-item-text text-input-m"
                      />
                      <div class="flex-row">
                        <MButtonIcon
                          v-if="!item.Performer?.Avatar"
                          icon="mi-relevant-circle-dash mi-24"
                          title="Người thực hiện"
                          @click="btnChooseEmployee_click(index)"
                        />

                        <div
                          v-if="item.Performer?.Avatar"
                          class="mi-24 m-mr8 pointer"
                          @click="btnChooseEmployee_click(index)"
                          :title="item.Performer?.FullName"
                        >
                          <img class="round" :src="item.Performer?.Avatar" />
                        </div>

                        <MButtonIcon
                          v-if="!item.StartDate"
                          icon="mi-calendar-circle-dash mi-24"
                          title="Hạn hoàn thành"
                          @click="btnChooseDeadline_click($event, index)"
                        />
                        <div
                          class="pointer"
                          v-if="item.StartDate"
                          @click="btnChooseDeadline_click($event, index)"
                        >
                          <n-popover trigger="hover">
                            <template #trigger>
                              <div class="">
                                {{ commonFn.formatDate(item.EndDate, true) }}
                              </div>
                            </template>
                            <div style="width: 110px">
                              <div class="">
                                Từ :
                                {{ commonFn.formatDate(item.StartDate, true) }}
                              </div>
                              <div class="">
                                Đến :
                                {{ commonFn.formatDate(item.EndDate, true) }}
                              </div>
                            </div>
                          </n-popover>
                        </div>

                        <MButtonIcon
                          icon="mi-delete-red mi-24"
                          title="Xoá"
                          @click="btnDeleteSubtask_click(index)"
                        />
                      </div>
                    </div>
                  </div>
                </div>

                <MButton
                  leftIcon="mi-plus-blue"
                  text="Thêm công việc con"
                  classCustom="btn-expand text-link m-button-m m-mt8 "
                  @click="btnAddSubtask_click"
                />
              </div>

              <div class="task-footer-tab m-pl8 m-pr8">
                <n-tabs type="line" animated class="m-tabs">
                  <n-tab-pane name="task-tab_Comment" tab="Bình luận">
                    <CommentList
                      v-if="loading.CommentTab"
                      :taskID="master.TaskID"
                    />
                  </n-tab-pane>
                  <n-tab-pane name="task-tab_Activity" tab="Hoạt động">
                    <ActivityList :taskID="master.TaskID" />
                  </n-tab-pane>
                </n-tabs>
              </div>
            </div>
          </n-scrollbar>

          <!-- Footer form -->
        </div>
      </div>

      <n-dropdown
        :show="showEl.dropdownChooseDeadline"
        :options="dropdownChooseDeadlineConfig.options"
        :show-arrow="true"
        :placement="dropdownChooseDeadlineConfig.placement"
        :trigger="dropdownChooseDeadlineConfig.trigger"
        :x="dropdownChooseDeadlineConfig.xRef"
        :y="dropdownChooseDeadlineConfig.yRef"
        :on-clickoutside="onDropdownDeadlineAway"
      ></n-dropdown>
    </template>
  </VModal>
</template>

<style>
@import "@/assets/style/base.css";
.form-task--wrapper {
  min-width: 840px;
}

.form-task--wrapper .form-header .m-button.m-btn-primary {
  width: unset !important;
}

.form-header {
}

.form-header .btn-progress {
  background-color: transparent !important;
  color: var(--text-color-default) !important;
  border-radius: 8px !important;
}

.form-header .btn-progress .m-button .text {
  font-size: 15px !important;
  font-family: "GoogleSans-Regular", Roboto, Helvetica, Arial, sans-serif !important;
  font-weight: 500 !important;
  color: var(--text-color-default) !important;
}

.form-header .btn-progress.m-split-button .divider {
  background-color: var(--text-color-default);
  height: 24px !important;
}

.form-body {
}

.form-body .header-task {
  padding-top: 16px;
  display: flex;
}

.form-body .header-task .form-label {
  font-size: 14px;
  font-weight: 600;
}

.form-body .btn-custom-1 {
  background-color: #f5f5f5 !important;
  border-radius: 8px !important;
  overflow: hidden;
  height: 73px;
  padding: 0 8px;
  cursor: pointer;
}

.form-body .btn-custom-1 img {
  border-radius: 50%;
}

.calender-active {
  border-radius: 50%;
  background-color: #96a7b5;
}

.calendar-label {
  min-width: 40px;
}

.form-body .btn-custom-1:hover {
  box-shadow: 0 2px 15px rgba(42, 126, 252, 0.25);
  background-color: var(--background-hover-color-2);
  transition: all 0.5s;
}

.form-body .btn-expand {
  width: fit-content !important;
  background-color: transparent !important;
}

.form-body .task-checklist .checklist-item {
  display: flex;
  align-items: center;
  padding: 4px 8px;
}

.checklist-item:hover,
.checklist-item:focus-within,
.checklist-item:hover input,
.checklist-item:focus-within input {
  background-color: #f5f5f5;
}

.checklist-item .checklist-item-text,
.subtask-item .subtask-item-text {
  width: 100%;
  text-overflow: ellipsis;
}

.form-body .task-subtask .subtask-item {
  padding: 12px 16px;
  border-bottom: 1px solid var(--surface-300);
}

.form-footer {
  padding: 16px;
}

.header-task .row {
  min-width: 200px;
  max-width: 320px;
}

.project .n-base-selection {
  --n-border: 0px !important;
  --n-border-active: 0px !important;
  --n-border-focus: 0px !important;
  --n-border-hover: 0px !important;
  --n-font-size: 16px !important;
  --n-box-shadow-active: 0 2px 15px rgba(42, 126, 252, 0.25) !important;
  --n-box-shadow-focus: 0 2px 15px rgba(42, 126, 252, 0.25) !important;
}

.project.n-tree-select {
  width: unset !important;
}

.n-tree .n-tree-node-wrapper {
  padding: 0 !important;
}

.n-tree .n-tree-node {
  padding: 8px 0 !important;
}
</style>
