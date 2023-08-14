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
import DropdownChooseDeadline from "@/components/dropdown/DropdownChooseDeadline.vue";
import DropdownChooseProgress from "@/components/dropdown/DropdownChooseProgress.vue";
import { useModal } from "vue-final-modal";
import FilterEmployeeForm from "@/components/popup/form/FilterEmployee.vue";
import DeleteConfirmForm from "@/components/popup/form/DeleteConfirm.vue";
import { useStore } from "vuex";
import {
  ModuleProject,
  ModuleContext,
  ModuleTask,
  ModuleEmployee,
} from "@/store/moduleConstant";
import { useMessages } from "@/utils/uses/base/useMessages";
import MSplitButton from "@/components/button/MSplitButton.vue";
import CommentList from "@/components//tabDetail/taskView/CommentList.vue";
import ActivityList from "@/components//tabDetail/taskView/ActivityList.vue";
import { cloneDeep } from "lodash";
import MConstant, { GUID_EMPTY } from "@/common/consts/MConstant";
import UpdateTaskFieldParam from "@/common/model/params/UpdateTaskFieldParam";
import { useUploadFile } from "@/utils/uses/base/useUploadFile";

const emit = defineEmits(["closeModal", "submit", "deleteTask"]);
const props = defineProps({
  TaskID: {
    type: String,
    default: "",
  },
});
const store = useStore();
const commonFn = inject("CommonFn");
const models = inject("Model");
let originalData = {};

const { warning, success, error } = useMessages();
let isEdited = false;

const master = reactive({
  Data: models.createTaskParam(),
});

const loading = reactive({
  CommentTab: false,
});

const employee = computed(() => store.state[ModuleContext]?.employee);

// TASK GROUP SELECT
const taskGroups = computed(() => store.state[ModuleProject].taskGroups);

const btnChooseProgress = ref(null);

const userPermissions = computed(() =>
  store.getters[ModuleContext + "/getUserProjectPermission"](
    master.Data.Project?.ProjectID
  )
);

const {
  UPLOAD_DOMAIN,
  fileList,
  initFileList,
  beforeUploadFile,
  finishUploadFile,
  errorUploadFile,
  removeFile,
} = useUploadFile({});

// PROJECT SELECT
const userProjects = computed(() => store.state[ModuleProject].projects);
const getUserProjects = computed(() => {
  if (userProjects.value.length == 0) {
    return [];
  }
  let allUserPermissions = cloneDeep(userPermissions.value);
  let projectData = cloneDeep(userProjects.value);
  projectData.forEach((project) => {
    if (
      !commonFn.hasPermissionInProject(
        allUserPermissions,
        project.ProjectID,
        MConstant.ProjectPermissions.Task.Task_Add
      )
    ) {
      project["disabled"] = true;
    }
  });

  let departmentProjects = commonFn.getDepartmentProject(projectData);
  return departmentProjects;
});

const getSectionTaskShow = computed(() => (section) => {
  let res = false;
  switch (section) {
    case MConstant.TaskFields.Checklists:
      res = master.Data.Checklists && master.Data.Checklists.length > 0;
      break;
    case MConstant.TaskFields.Subtasks:
      res = master.Data.Subtasks && master.Data.Subtasks.length > 0;
      break;
    case MConstant.TaskFields.Performer:
      res = master.Data.Performer && master.Data.Performer.EmployeeID;
      break;
    case MConstant.TaskFields.Progress:
      res = master.Data.Progress >= 0 && master.Data.Progress < 100;
      break;
    case MConstant.TaskFields.StartDate:
      res = master.Data.StartDate;
      break;
    case MConstant.TaskFields.EndData:
      res = master.Data.EndData;
      break;
    default:
      break;
  }
  return res;
});

// Nếu có quyền thì true
const checkUserDisableItem = computed(() => (permission) => {
  if (!permission) {
    return true;
  }

  if (userPermissions.value.length == 0) {
    return false;
  }

  return userPermissions.value.find(
    (item) => item.PermissionCode == permission
  );
});



const filterEmployeeModal = useModal({
  component: FilterEmployeeForm,
  attrs: {
    project: {
      ProjectID: master.Data.ProjectID,
    },

    onCloseModal() {
      filterEmployeeModal.close();
    },
    async onChooseEmployee(employee) {
      if (subtaskOpenModelIndex.value || subtaskOpenModelIndex.value == 0) {
        master.Data.Subtasks[subtaskOpenModelIndex.value].Performer = employee;
        master.Data.Subtasks[subtaskOpenModelIndex.value].PerformerID =
          employee?.EmployeeID;
      } else {
        master.Data.Performer = employee;
        master.Data.PerformerID = employee.EmployeeID;
        await handleUpdateFieldV2(
          MConstant.TaskFields.Performer,
          2,
          originalData.Performer.FullName,
          employee.FullName,
          "PerformerID"
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
          TaskID: master.Data.TaskID,
        },
      };

      let res = await store.dispatch(ModuleTask + "/deleteTask", param);
      emit("deleteTask");
    },
  },
});

const deleteSubTaskConfirmModal = useModal({
  component: DeleteConfirmForm,
  attrs: {
    taskID: null,
    title: "Xoá công việc con",
    content:
      "Dữ liệu công việc sẽ bị xóa khỏi hệ thống. Bạn có chắc chắn muốn xóa công việc con?",

    onCloseModal() {
      deleteSubTaskConfirmModal.close();
    },

    async onDelete() {
      if (
        commonFn.hasPermissionInProject(
          userPermissions.value,
          master.Data.ProjectID,
          MConstant.ProjectPermissions.Task.Task_Delete
        )
      ) {
        await deleteSubTaskAsync(
          deleteSubTaskConfirmModal.options.attrs.taskID
        );
      } else {
        error("Bạn không có quyền thực hiện chức năng này!");
      }

      deleteSubTaskConfirmModal.close();
    },
  },
});

// MOUNTED HOOK
onMounted(async () => {
  // lấy task detail
  await getTaskData();

  // lấy danh sách các nhóm công việc
  await getTaskGroups();

  // lấy danh sách các dự án
  await getProjects();

  initDataMaster();

  initConfig();
});

const initDataMaster = () => {
  bindAttachments();
};

const bindAttachments = () => {
  // bind File
  let attachments = master.Data.Files;
  if (attachments && attachments.length > 0) {
    initFileList.value = attachments.map((file) => {
      return {
        id: file.ID,
        name: file.FileName,
        status: "finished",
        url: file.Url,
        type: file.Type,
      };
    });

    fileList.value = cloneDeep(attachments);
  }
};

const initConfig = () => {
  loading.CommentTab = true;
  showEl.btnDescription = !(
    master.Data.Description && master.Data.Description.length > 0
  );

  showEl.deadline = master.Data.StartDate || master.Data.EndDate;

  showEl.subtasks = master.Data.Subtasks.length > 0;
};

const getTaskData = async () => {
  let getTaskParam = {
    data: {
      TaskID: props.TaskID,
    },
  };
  // lấy task detail
  let data = await store.dispatch(ModuleTask + "/getByID", getTaskParam);
  if (data) {
    master.Data = data;
    // Lưu lại dữ liệu gốc ban đầu
    originalData = cloneDeep(master.Data);
  }
};

const getTaskGroups = async () => {
  let param = {
    data: {
      ProjectID: master.Data.ProjectID
    }
  }
  return await store.dispatch(ModuleProject + "/getTaskGroups", param);
};

const getProjects = async () => {
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);
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
        progress: master.Data.Progress,
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
  {
    label: () => h("div", { class: "danger" }, "Xoá"),
    key: "key_delete",
    icon: renderIcon("mi-delete-close"),
    permission: MConstant.ProjectPermissions.Task.Task_Delete,
  },
];

const getUserDropdownTaskOptions = computed(() => {
  let arrPermissionCode = userPermissions.value.map((x) => x.PermissionCode);
  return dropdownTaskOptions.filter(
    (option) =>
      arrPermissionCode.includes(option.permission) || !option.permission
  );
});

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
          if (!master.Data.Description) {
            showEl.btnDescription = true;
          }
        }
      },
    });

    editor.ui.registry.addButton("customDeleteButton", {
      text: "Huỷ",
      onAction: (_) => {
        showEl.editor = false;
        master.Data.Description = "";
        showEl.btnDescription = true;
      },
    });
  },
  init_instance_callback: function (editor) {
    editor.on("blur", async () => {
      let res = await handleUpdateField("Description");
      if (res > 0) {
        if (!master.Data.Description) {
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
  btnDone: master.Data.Progress == 100,
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
  filterEmployeeModal.patchOptions({
    attrs: {
      project: {
        ProjectID: master.Data.ProjectID,
      },
    },
  });
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
    let subtask = master.Data.Subtasks[subtaskShowDropdownIndex.value];
    subtask["StartDate"] = data.StartDate;
    subtask["EndDate"] = data.EndDate;
    subtask["Range"] = data.Range;

    await handleUpdateField("StartDate", 2, subtask.TaskID);
    await handleUpdateField("EndDate", 2, subtask.TaskID);

  } else {
    master.Data.StartDate = data.StartDate;
    master.Data.EndDate = data.EndDate;
    master.Data.Range = data.Range;

    await handleUpdateField("StartDate");
    await handleUpdateField("EndDate");
  }
};

const handleUpdateProgress = async (progress) => {
  if (progress < 0 || progress > 100) {
    error("Tiến độ không hợp lệ");
    return;
  }

  master.Data.Progress = progress;
  btnChooseProgress.value.handleClickShowDropdown();

  await handleUpdateField(MConstant.TaskFields.Progress);
};

const handleUpdateProgressSubtask = (checked, index) => {
  let progress = checked ? 100 : 0;
  master.Data.Subtasks[index]["Progress"] = progress;
};

const handleUpdateField = async (
  field,
  actionType = 2,
  taskID = master.Data.TaskID
) => {
  let res = 0;
  if (originalData[field] != master.Data[field]) {
    let payload = models.createUpdateTaskFieldParam({
      TaskID: taskID,
      FieldName: field,
      FieldValue: commonFn.getFieldValueByType(master.Data[field]),
      OldValue: commonFn.getFieldValueByType(originalData[field]),
      TypeValue: typeof master.Data[field],
      CreatedBy: employee.value.EmployeeCode,
      ActionType: actionType,
      OldTextValue: commonFn.getFieldValueText(),
      NewTextValue: commonFn.getFieldValueText(),
    });
    res = await updateTaskField(payload);
    if (res > 0) {
      // gắn cờ là đã sửa
      isEdited = true;
      originalData[field] = master.Data[field];
    } else {
      master.Data[field] = originalData[field];
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
  let res = 0;
  if (!fieldValue) {
    fieldValue = field;
  }
  if (originalData[fieldValue] != master.Data[fieldValue]) {
    let payload = models.createUpdateTaskFieldParam({
      TaskID: master.Data.TaskID,
      FieldName: field,
      FieldValue: commonFn.getFieldValueByType(master.Data[fieldValue]),
      OldValue: commonFn.getFieldValueByType(originalData[fieldValue]),
      TypeValue: typeof master.Data[fieldValue],
      CreatedBy: employee.value.EmployeeCode,
      ActionType: actionType,
      OldTextValue: oldText,
      NewTextValue: newText,
    });

    res = await updateTaskField(payload);
    if (res > 0) {
      // gắn cờ là đã sửa
      isEdited = true;
      originalData[fieldValue] = master.Data[fieldValue];
    } else {
      master.Data[fieldValue] = originalData[fieldValue];
    }
  }

  return res;
};

const handleUpdateSubtaskField = async (subtask, actionType = MConstant.FieldTaskType.Add) => {
  let payload = models.createUpdateTaskFieldParam({
      TaskID: subtask.ParentID,
      FieldName: MConstant.TaskFields.Subtasks,
      FieldValue: commonFn.getFieldValueByType(master.Data[fieldValue]),
      OldValue: commonFn.getFieldValueByType(originalData[fieldValue]),
      TypeValue: typeof master.Data[fieldValue],
      CreatedBy: employee.value.EmployeeCode,
      ActionType: actionType,
      OldTextValue: oldText,
      NewTextValue: newText,
    });

    res = await updateTaskField(payload);
}

const handleChangeTaskGroup = async (value, taskgroup) => {
  let oldTaskGroup = taskGroups.value.find((item) => item.TaskGroupID == originalData.TaskGroupID);
  await handleUpdateFieldV2(
          MConstant.TaskFields.TaskGroup,
          2,
          oldTaskGroup ? oldTaskGroup.TaskGroupName : '',
          taskgroup.TaskGroupName,
          MConstant.TaskFields.TaskGroup + "ID"
        );
};

const handleBlurTaskName = async (e) => {
  return await handleUpdateField("TaskName");
};

const deleteSubTaskAsync = async (taskID) => {
  let subtask = master.Data.Subtasks?.find((item) => item.TaskID == taskID);
  let param = {
    data: cloneDeep(subtask),
    onSuccess: async () => {
      success("Xoá công việc con thành công");
      await getTaskData();
    },
    onFailure: () => error("Có lỗi xảy ra khi xoá công việc con"),
  };

  await store.dispatch(ModuleTask + "/deleteTaskV2", param);
};

const deleteChecklistAsync = async (checklist) => {
  let param = {
    data: checklist,
    onSuccess: async () => {
      success("Xoá checklist thành công");
      await getTaskData();
    },
    onFailure: () => error("Có lỗi xảy ra khi xoá checklist"),
  };

  await store.dispatch(ModuleTask + "/deleteChecklist", param);
};

const insertChecklistAsync = async (checklist) => {
  let data = cloneDeep(checklist);
  data.TaskID = master.Data.TaskID;
  let param = {
    data: data,
    onSuccess: async () => {
      success("Thêm mới checklist thành công");
      await getTaskData();
    },
    onFailure: () => error("Có lỗi xảy ra khi thêm mới checklist"),
  };

  await store.dispatch(ModuleTask + "/insertChecklist", param);
};

const insertSubtaskAsync = async (subtask) => {
  let data = cloneDeep(subtask);
  let taskGroupNeedToDo = taskGroups.value.find((taskgroup) => taskgroup.TaskGroupName.includes("Cần thực hiện"));

  data.ProjectID = master.Data.ProjectID;
  data.TaskGroupID = taskGroupNeedToDo ? taskGroupNeedToDo.TaskGroupID : GUID_EMPTY;
  let param = {
    data: data,
    onSuccess: async () => {
      success("Thêm mới công việc con thành công");
      await getTaskData();
    },
    onFailure: () => error("Có lỗi xảy ra khi thêm mới công việc con"),
  };

  await store.dispatch(ModuleTask + "/insertSubtask", param);
}

const closeModal = (e) => {
  emit("closeModal", isEdited);
};

const btnDeleteCheckList_click = async (item) => {
  await deleteChecklistAsync(item);
};

const btnDeleteSubtask_click = (task) => {
  deleteSubTaskConfirmModal.patchOptions({
    attrs: {
      taskID: task.TaskID,
    },
  });

  deleteSubTaskConfirmModal.open();
};

const btnAddCheckList_click = () => {
  let checklistInvalid = master.Data.Checklists.find(
    (checklist) => !checklist.ChecklistName
  );
  if (checklistInvalid) {
    warning("Hãy bổ sung đầy đủ thông tin checklist trước khi thêm");
    return;
  }

  master.Data.Checklists.push(models.createChecklist());
};

const btnAddSubtask_click = () => {
  if (!showEl.subtasks) {
    showEl.subtasks = true;
  }

  let subtaskInvalid = master.Data.Subtasks.find(
    (subtask) => !subtask.TaskName
  );
  if (subtaskInvalid) {
    warning("Hãy bổ sung đầy đủ thông tin tên công việc con trước khi thêm");
    return;
  }
  let newSubTask = models.createSubTask({
    Project: {
      ProjectID: master.Data.ProjectID,
    },
    ParentID: master.Data.TaskID
  });
  master.Data.Subtasks.push(newSubTask);
};

const btnDone_click = async () => {
  master.Data.Progress = 100;

  await handleUpdateField(MConstant.TaskFields.Progress);
};

const btnNotDone_click = async () => {
  master.Data.Progress = 0;
  await handleUpdateField(MConstant.TaskFields.Progress);
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

const onChecklistAway = async (e) => {
  const newChecklist = master.Data.Checklists.find((item) => item.IsNew);
  if (newChecklist) {
    if (!newChecklist.ChecklistName) {
      let checklistInx = master.Data.Checklists.findIndex(
        (item) => item.IsNew
      );
      if (checklistInx > -1) {
        master.Data.Checklists.splice(checklistInx, 1);
      }
    } else {
      await insertChecklistAsync(newChecklist);
    }
  }
};

const onSubtaskAway = async (e) => {
  const newSubtask = master.Data.Subtasks.find((item) => item.IsNew);
  if (newSubtask) {
    if (!newSubtask.TaskName) {
      let invalidSubtask = master.Data.Subtasks.findIndex(
        (item) => item.IsNew
      );
      if (invalidSubtask > -1) {
        master.Data.Subtasks.splice(invalidSubtask, 1);
      }
    } else {
      await insertSubtaskAsync(newSubtask);
    }
  }
};

const clickExpandEditor = () => {
  showEl.editor = true;
  showEl.btnDescription = false;
};

const onDropdownDeadlineAway = () => {
  showEl.dropdownChooseDeadline = false;
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
                v-if="getSectionTaskShow(MConstant.TaskFields.Progress)"
                ref="btnChooseProgress"
                :text="'Hoàn thành'"
                :title="'Tiến độ'"
                :classCustom="'m-button-m btn-progress text-medium'"
                :options="dropdownChooseProgressOptions"
                :splitText="master.Data.Progress + '%'"
                :border="true"
                splitIcon="mi-carret-down"
                splitButtonClass="transparent"
                @onClick="btnDone_click"
              />

              <MButton
                v-if="master.Data.Progress == 100"
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
                :options="getUserDropdownTaskOptions"
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
                  <span class="text-link-small">{{
                    master.Data.AssignorName
                  }}</span>
                </div>
              </div>

              <div class="header-task m-mb18">
                <div class="row">
                  <div class="form-label m-pl12">Dự án:</div>
                  <MTreeSelect
                    :data="getUserProjects"
                    class="project"
                    label-field="ProjectName"
                    key-field="ProjectID"
                    children-field="Projects"
                    :disabled="true"
                    v-model="master.Data.ProjectID"
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
                    v-model="master.Data.TaskGroupID"
                    :enableChange="true"
                    @onChange="handleChangeTaskGroup"
                  />
                </div>
              </div>

              <div class="task-name m-pl8 m-pr8">
                <MInput
                  placeholder="Nhập tên công việc"
                  customClass="text-large"
                  :border="false"
                  :enableBlur="true"
                  @onBlur="handleBlurTaskName"
                  v-model="master.Data.TaskName"
                />
              </div>

              <!-- ASSIGNEE -->
              <div class="flex-jsp flex-align-center m-mt16 m-mb16 m-pl8 m-pr8">
                <MButton
                  v-if="!getSectionTaskShow('Performer')"
                  text="Chọn người thực hiện"
                  leftIcon="mi-question-circle"
                  classCustom="btn-custom-1 text-medium m-mr16 m-w100"
                  @click="btnChooseEmployee_click()"
                />

                <div
                  class="btn-custom-1 flex-row flex-align-center text-medium m-mr16 m-w100"
                  v-if="getSectionTaskShow('Performer')"
                  @click="btnChooseEmployee_click()"
                >
                  <img :src="master.Data.Performer.Avatar" class="mi-32" />
                  <div class="performer m-ml16">
                    <div class="label-performer">Người thực hiện</div>
                    <div class="key-performer text-bold">
                      {{ master.Data.Performer.FullName }}
                    </div>
                  </div>
                </div>

                <MButton
                  v-if="!getSectionTaskShow(MConstant.TaskFields.StartDate) && !getSectionTaskShow(MConstant.TaskFields.EndData)"
                  text="Chọn hạn hoàn thành"
                  leftIcon="mi-calender-circle "
                  classCustom="btn-custom-1 text-medium m-w100"
                  @click="btnChooseDeadline_click"
                />

                <div
                  v-if="getSectionTaskShow(MConstant.TaskFields.StartDate) || getSectionTaskShow(MConstant.TaskFields.EndData)"
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
                        commonFn.formatDate(master.Data.StartDate)
                      }}</span>
                    </div>
                    <div class="calendar-label">
                      Đến &nbsp;
                      <span class="text-bold">{{
                        commonFn.formatDate(master.Data.EndDate)
                      }}</span>
                    </div>
                    <div class="calendar-label label-range">
                      Tổng thời gian &nbsp;&nbsp;
                      <span class="text-bold">{{
                        commonFn.calculateTimePeriod(
                          new Date(master.Data.EndDate).getTime() -
                            new Date(master.Data.StartDate).getTime()
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
                    v-if="master.Data.Description || showEl.editor"
                  >
                    <div class="mi-24 mi-description-v2 m-mr8"></div>
                    <div class="title-medium">Mô tả</div>
                  </div>
                  <Editor
                    v-if="showEl.editor"
                    api-key="9038dr0d32vvyxk56tg57fbo4w5hgp16g574iyezusedlm3f"
                    v-model="master.Data.Description"
                    :init="tinymceInit"
                  />
                </div>

                <div v-if="!showEl.editor" @click="clickExpandEditor">
                  <div
                    class="m-ml8 m-mb8"
                    v-if="master.Data.Description"
                    v-html="master.Data.Description"
                  ></div>
                </div>
              </div>

              <div class="task-checklist" v-click-away="onChecklistAway">
                <div v-if="getSectionTaskShow('Checklists')" class="">
                  <div class="flex-row flex-align-center m-mb8">
                    <div class="mi-24 mi-checklist-v2 m-mr8"></div>
                    <div class="title-medium">Checklist</div>
                  </div>

                  <div class="">
                    <div
                      v-for="(item, index) in master.Data.Checklists"
                      class="checklist-item"
                    >
                      <div class="prefix">{{ `${index + 1}.` }}</div>
                      <input
                        v-model="item.ChecklistName"
                        class="checklist-item-text"
                      />
                      <div class="">
                        <MButtonIcon
                          icon="mi-delete-red mi-24"
                          title="Xoá"
                          @click="btnDeleteCheckList_click(item)"
                        />
                      </div>
                    </div>
                  </div>
                </div>

                <MButton
                  leftIcon="mi-plus-blue"
                  text="Thêm checklist"
                  classCustom="btn-expand text-link m-button-m m-mt8"
                  @click="btnAddCheckList_click"
                />
              </div>

              <!-- TASK ATTACHMENT -->
              <div class="task-attachment" v-if="master.Data.Files && master.Data.Files.length > 0">
                <div
                  class="flex-row flex-align-center m-mb8"
                >
                  <div class="mi-24 mi-attachment-v2 m-mr8"></div>
                  <div class="title-medium">Tệp đính kèm</div>
                </div>

                <div class="row" >
                  <n-upload
                    :action="UPLOAD_DOMAIN"
                    list-type="image"
                    show-download-button
                    :default-file-list="initFileList"
                    @finish="finishUploadFile"
                    @beforeUpload="beforeUploadFile"
                    @error="errorUploadFile"
                    @remove="removeFile"
                  >
                    <MButton
                      leftIcon="mi-plus-blue"
                      text="Thêm tệp"
                      classCustom="btn-expand text-link m-button-m"
                      ref="btnAddAttachment"
                    />
                  </n-upload>
                </div>
              </div>

              <div class="task-subtask m-pb8" v-click-away="onSubtaskAway">
                <div class="" v-if="getSectionTaskShow('Subtasks')">
                  <div class="flex-row flex-align-center m-mb8">
                    <div class="mi-24 mi-subtask-v2 m-mr8"></div>
                    <div class="title-medium">Công việc con</div>
                  </div>

                  <div class="subtask-list">
                    <div class="line"></div>
                    <div
                      v-for="(item, index) in master.Data.Subtasks"
                      class="subtask-item flex-row flex-align-center"
                    >
                      <n-checkbox
                        :checked="item.Progress == 100"
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
                          v-if="!item.PerformerAvatar"
                          icon="mi-relevant-circle-dash mi-24"
                          title="Người thực hiện"
                          @click="btnChooseEmployee_click(index)"
                        />

                        <div
                          v-if="item.PerformerAvatar"
                          class="mi-24 m-mr8 pointer"
                          @click="btnChooseEmployee_click(index)"
                          :title="item.PerformerName"
                        >
                          <img class="round" :src="item.PerformerAvatar" />
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
                          @click="btnDeleteSubtask_click(item)"
                          v-if="
                            checkUserDisableItem(
                              MConstant.ProjectPermissions.Task.Task_Delete
                            )
                          "
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
                      :taskID="master.Data.TaskID"
                    />
                  </n-tab-pane>
                  <n-tab-pane name="task-tab_Activity" tab="Hoạt động">
                    <ActivityList :taskID="master.Data.TaskID" />
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
