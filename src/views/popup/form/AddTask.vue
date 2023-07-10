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
  watch
} from "vue";
import Editor from "@tinymce/tinymce-vue";
import { useMessage } from "naive-ui";
import DropdownChooseDeadline from "@/views/pages/common/dropdown/DropdownChooseDeadline.vue";
import { useModal } from "vue-final-modal";
import FilterEmployeeForm from "@/views/popup/form/FilterEmployee.vue";
import { useStore } from "vuex";
import { ModuleProject, ModuleUser, ModuleTask } from "@/store/moduleConstant";
import Task from "@/services/Task";
import { useMessages } from "@/utils/uses/base/useMessages";
import { useUploadFile } from "@/utils/uses/base/useUploadFile";
import { cloneDeep } from "lodash";

const departmentKeyPrefix = "DEPARTMENT_";
const emit = defineEmits(["closeModal", "submit"]);
const message = useMessage();
const store = useStore();
const commonFn = inject("CommonFn");
const { warning, success } = useMessages();
const models = inject("Model");

const master = reactive({
  Project: {
    ProjectID: null,
  },
  TaskGroup: {
    TaskGroupID: null,
  },
  TaskName: null,
  Performer: {},
  StartDate: null,
  EndDate: null,
  Range: null,
  Description: null,
  Checklists: [],
  Subtasks: [],
  CreatorID: null,
});

const btnAddAttachment = ref(null);
const tfTaskName = ref(null);

const employee = computed(() => store.state[ModuleUser]?.employee);

const {
  fileList,
  beforeUploadFile,
  finishUploadFile,
  errorUploadFile,
  removeFile,
} = useUploadFile();

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
    const project = rawDepartmentProjects[index];
    if (project.Projects?.length > 0) {
      return project.Projects[0].ProjectID;
    }
  }

  return "";
};

// TASK GROUP SELECT
const taskGroups = computed(() => store.state[ModuleTask]?.taskGroups);

const getDefaultTaskGroup = () => {
  let res = "";
  let rawData = store.state[ModuleTask]?.taskGroups;
  let taskGroupInit = rawData.find((item) =>
    item.TaskGroupName.includes("Cần thực hiện")
  );
  if (taskGroupInit) {
    res = taskGroupInit.TaskGroupID;
  }

  return res;
};

// MOUNTED HOOK
onMounted(async () => {
  // lấy danh sách các nhóm công việc
  await store.dispatch(ModuleTask + "/getTaskGroups");

  master.TaskGroup.TaskGroupID = getDefaultTaskGroup();

  // lấy danh sách các dự án
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);

  master.Project.ProjectID = getDefaultDepartmentProject();
});

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
  content_style: "body { background-color: #f5f5f5; }" + "p {margin-block-start: 4px;margin-block-end: 4px;}",
  font_family_formats: "'GoogleSans-Regular',Roboto, Helvetica, Arial, sans-serif",
  auto_focus: true,
  setup: (editor) => {
    editor.ui.registry.addButton("customInsertButton", {
      text: "Lưu",
      onAction: (_) => {
        showEl.editor = false;
        if(!master.Description){
          showEl.btnDescription = true;
        }
      },
    });

    editor.ui.registry.addButton("customDeleteButton", {
      text: "Huỷ",
      onAction: (_) => {
        showEl.editor = false;
        master.Description = '';
        showEl.btnDescription = true;
      },
    });
  },
  init_instance_callback: function (editor) {
    editor.on("blur", function () {
      if (!master.Description) {
        showEl.btnDescription = true;
      }
      showEl.editor = false;

    });
  },
};

const showEl = reactive({
  btnDescription: true,
  btnCheckList: true,
  dropdownChooseDeadline: false,
  editor: false,
  checklist: false,
  subtasks: false,
  performer: false,
  deadline: false,
  attachment: false,
});

// cờ gắn giá trị hiện modal chọn nhân viên task chính hay subtask
let subtaskOpenModelIndex = ref(null);
let subtaskShowDropdownIndex = ref(null);

const filterEmployeeModal = useModal({
  component: FilterEmployeeForm,
  attrs: {
    project: master.Project,

    onCloseModal() {
      filterEmployeeModal.close();
    },
    onChooseEmployee(employee) {
      if (subtaskOpenModelIndex.value || subtaskOpenModelIndex.value == 0) {
        master.Subtasks[subtaskOpenModelIndex.value].Performer = employee;
        master.Subtasks[subtaskOpenModelIndex.value].PerformerID =
          employee?.EmployeeID;
      } else {

        master.Performer = employee;
      }
    },
  },
});



const handleUpdateDeadline = (data) => {
  showEl.dropdownChooseDeadline = false;
  if (subtaskShowDropdownIndex.value || subtaskShowDropdownIndex.value === 0) {
    master.Subtasks[subtaskShowDropdownIndex.value]["StartDate"] =
      data.StartDate;
    master.Subtasks[subtaskShowDropdownIndex.value]["EndDate"] = data.EndDate;
    master.Subtasks[subtaskShowDropdownIndex.value]["Range"] = data.Range;
  } else {
    master.StartDate = data.StartDate;
    master.EndDate = data.EndDate;
    master.Range = data.Range;
    showEl.deadline = true;
  }
};

watch(() => master.Project.ProjectID, (newVal, oldValue) => {
  if(newVal != oldValue){
    master.Performer = {};
  }
})


const closeModal = (e) => {
  emit("closeModal");
};

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
  let newSubTask = models.createSubTask({
    ProjectID: master.Project.ProjectID,
  });
  master.Subtasks.push(newSubTask);
};



const btnIconSubtask_click = () => {
  btnAddSubtask_click();
}

const btnIconAttachment_click = () => {
  showEl.attachment = true;
  nextTick(() => {
    debugger;
    btnAddAttachment.value.click();
  });
};

const btnSave_click = async () => {
  // collect data
  let data = collectData();
  console.log(data);
  let {isValid, errMsg} = validateData(data);
  if(!isValid){
    warning(errMsg);
  }
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

const collectData = () => {
  let data = cloneDeep(master);
  data.CreatorID = employee.value.EmployeeID;
  data.Files = fileList.value;
  
  return data;
}

const validateData = (data) => {
  let res = {
    errMsg : '',
    isValid : true
  }

  if(!data.TaskName){
    res.isValid = false;
    res.errMsg = 'Tên công việc không được để trống !' ;
    tfTaskName.value.invalid();
    return res;
  }

  return res;
}

const onChecklistAway = (e) => {
  if(!showEl.checklist){
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

const onSubtaskAway = (e) => {
  if(!showEl.subtasks){
    return;
  }
  const newSubtask = master.Subtasks.filter(
    (item) => item.TaskName && item.TaskName.length > 0
  );

  master.Subtasks = newSubtask;

  if (master.Subtasks.length == 0) {
    showEl.subtasks = false;
  }
}

const onDropdownDeadlineAway = () => {
  showEl.dropdownChooseDeadline = false;
};

const clickExpandEditor = () => {
  showEl.editor = true;
  showEl.btnDescription = false;
};

const handleUpdateVal = () => {
  debugger
}
</script>

<template>
  <VModal customClass="form-task">
    <template #default>
      <div class="m-h100 overflow-auto">
        <div class="form-task--wrapper">
          <!-- Header form -->
          <div class="form-header flex-row-end m-pt8 m-pb16 m-pr8">
            <MButtonIcon
              classCustom="m-ml8 m-p4"
              icon="mi-sub-task"
              title="Công việc con"
              @click="btnIconSubtask_click"
            />

            <MButtonIcon
              classCustom="m-ml8 m-p4"
              icon="mi-attachment"
              title="Tài liệu"
              @click="btnIconAttachment_click"
            />

            <MButtonIcon
              classCustom="m-ml8 m-p4"
              icon="mi-label"
              title="Gắn thẻ"
            />

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>

          <!-- Body form -->
          <n-scrollbar trigger="hover" style="max-height: 540px">
            <div class="form-body line">
              <div class="header-task m-mb18">
                <div class="row">
                  <div class="form-label m-pl12">Dự án:</div>
                  <MTreeSelect
                    :data="departmentProjects"
                    class="project"
                    label-field="ProjectName"
                    key-field="ProjectID"
                    children-field="Projects"
                    v-model="master.Project.ProjectID"
                    @update:value="handleUpdateVal"
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
                    v-model="master.TaskGroup.TaskGroupID"
                  >
                  </MTreeSelect>
                </div>
              </div>

              <!-- TASK NAME -->
              <div class="task-name m-pl8 m-pr8">
                <MInput
                ref="tfTaskName"
                  placeholder="Nhập tên công việc"
                  customClass="text-large"
                  :border="false"
                  v-model="master.TaskName"
                />
              </div>

              <!-- TASK PERFORMER -->
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
                  <img :src="master.Performer?.Avatar" class="mi-32" />
                  <div class="performer m-ml16">
                    <div class="label-performer">Người thực hiện</div>
                    <div class="key-performer text-bold">
                      {{ master.Performer?.FullName }}
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
                        commonFn.calculateTimePeriod(master.Range)
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
                  <div class="flex-row flex-align-center m-mb8" v-if="master.Description || showEl.editor" >
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
                  <div class="m-ml8 m-mb8" v-if="master.Description"  v-html="master.Description"></div>
                </div>
              </div>

              <!-- TASK CHECKLIST -->
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

              <!-- TASK ATTACHMENT -->
              <div class="task-attachment">
                <div
                  class="flex-row flex-align-center m-mb8"
                  v-if="showEl.attachment"
                >
                  <div class="mi-24 mi-attachment-v2 m-mr8"></div>
                  <div class="title-medium">Tệp đính kèm</div>
                </div>

                <div class="row" v-if="showEl.attachment">
                  <n-upload
                    action="http://localhost:5228/api/v1/File"
                    list-type="image"
                    show-download-button
                    :default-file-list="fileList"
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
            </div>
          </n-scrollbar>

          <div class="form-footer line">
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
