<script setup>
import {
  computed,
  inject,
  ref,
  reactive,
  h,
  onMounted,
  nextTick,
  watch,
} from "vue";
import { useStore } from "vuex";
import {
  ModuleDepartment,
  ModuleEmployee,
  ModuleProject,
  ModuleContext,
  ModuleIssue,
} from "@/store/moduleConstant";
import EmployeeCardV2 from "@/components/cards/EmployeeV2.vue";
import _ from "lodash";
import { useMessages } from "@/utils/uses/base/useMessages";
import MConstant, { DEPARTMENT_KEY_PREFIX } from "@/common/consts/MConstant";
import FilterEmployee from "./FilterEmployee.vue";
import RelateEmployee from "./RelateEmployee.vue";
import { useModal } from "vue-final-modal";
import { useUploadFile } from "@/utils/uses/base/useUploadFile";
import eventBus, {GlobalEventName} from "@/utils/helper/eventBus";

//#region Hàm hỗ trợ
const createDropdownOptions = (options) =>
  options.map((option) => ({
    key: option.EmployeeID,
    label: option.FullName,
  }));

//#endregion

//#region Khai báo biến
const store = useStore();
const models = inject("Model");
const commonFn = inject("CommonFn");
const emit = defineEmits(["closeModal"]);
const currentIssue = computed(() => store.state[ModuleIssue].issue);
const props = defineProps({
  mode: {
    type: Number,
    default: MConstant.FormMode.Add,
  },
  issueID: {
    type: String,
    default: null,
  },
});
const { error, success } = useMessages();

const departments = computed(() => store.state[ModuleDepartment].departments);
const employee = computed(() => store.state[ModuleContext]?.employee);
const issueTypes = computed(() => store.state[ModuleIssue]?.issueTypes);
const priorities = computed(() => store.state[ModuleIssue]?.priorities);
const timestamps = reactive({
  ReceptionDate: null,
  DesiredDate: null,
});

const {
  UPLOAD_DOMAIN,
  fileList,
  initFileList,
  beforeUploadFile,
  finishUploadFile,
  errorUploadFile,
  removeFile,
} = useUploadFile();

const formConfig = reactive({
  Title: props.mode == MConstant.FormMode.Edit ? "Sửa vấn đề" : "Thêm vấn đề",
});

// PROJECT SELECT
const departmentProjects = computed(() => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  return rawDepartmentProjects?.map((item) => {
    return {
      ...item,
      ProjectID: DEPARTMENT_KEY_PREFIX + item.DepartmentID,
      ProjectName: item.DepartmentName,
      disabled: true,
    };
  });
});

let master = reactive({
  Data: models.createAddIssueParam(),
  OriginalData: {}
});

const chooseAssigneeModal = useModal({
  component: FilterEmployee,
  attrs: {
    project: master.Data.Project,

    onCloseModal() {
      chooseAssigneeModal.close();
    },
    onChooseEmployee(employee) {
      master.Data.Assignee = employee;
    },
  },
});

const chooseRelateEmployeeModal = useModal({
  component: RelateEmployee,
  attrs: {
    project: master.Data.Project,

    onCloseModal() {
      chooseRelateEmployeeModal.close();
    },
    onChooseEmployee(employees) {
      master.Data.RelateEmployees = employees;
    },
  },
});

let flagIsBindingData = false;

//#endregion

//#region Hàm sự kiện
const selectProject_change = async (value, option) => {
  await getIssueTypes(value);
};

const btnChooseAssignee_click = () => {
  chooseAssigneeModal.patchOptions({
    attrs: {
      project: master.Data.Project
    }
  })
  chooseAssigneeModal.open();
};

const btnChooseRelate_click = () => {
  chooseRelateEmployeeModal.patchOptions({
    attrs: {
      project: master.Data.Project
    }
  })
  chooseRelateEmployeeModal.open();
};

const btnSave_click = async () => {
  let data = collectData();
  let action = "/insertIssue";
  let onSuccess = () => {
    success("Thêm mới vấn đề thành công");
  };

  let onFailure = () => {
    error('Có lỗi xảy ra');
  }

  if (props.mode == MConstant.FormMode.Edit) {
    action = "/updateIssue";
    onSuccess = () => {
      success("Sửa vấn đề thành công");
      eventBus.$emit(GlobalEventName.loadDetailIssue);
    };
  }

  let payload = {
    data,
    onSuccess,
    onFailure
  };

  await store.dispatch(ModuleIssue + action, payload);
  emit("closeModal");

};

//#endregion

//#region Hàm xử lý logic

const getProjects = async () => {
  // lấy danh sách các dự án
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);
};

const getIssueTypes = async (projectID) => {
  // lấy danh sách loại vấn đề đối với từng dự án
  let param = {
    data: {
      ProjectID: projectID,
    },
  };
  await store.dispatch(ModuleIssue + "/getIssueTypesByProject", param);
  if(!isEditMode()){
    getDefaultIssueType();
  }
};

const closeModal = () => {
  emit("closeModal");
};

const isEditMode = () => {
  return props.mode == MConstant.FormMode.Edit;
}

const collectData = () => {
  let data = _.cloneDeep(master.Data);
  let orignalData = _.cloneDeep(master.OriginalData)
  data.Files = fileList.value;
  let arrDataFields = ['IssueName', 'CustomerInfo', 'Assignee', 'IssueTypeID', 'Description', 'ReceptionDate', 'DesiredDate', 'PreliminarySolution', 'Priority' ];
  data.FieldChanges = commonFn.getObjectChanges(data,orignalData, arrDataFields);
  return data;
};

const getIssue = async () => {
  let param = {
    data: {
      IssueID: props.issueID,
    },
  };
  await store.dispatch(ModuleIssue + "/getIssue", param);
};
//#endregion

//#region Lifecycle hooks
onMounted(async () => {
  await getProjects();

  await bindInitMasterData();
});

const bindInitMasterData = async () => {
  if (isEditMode()) {
    await getIssue();

    bindCurrentIssueData();
  }

  if (props.mode == MConstant.FormMode.Add) {
    master.Data.Project.ProjectID = getDefaultDepartmentProject();
  }

  await getIssueTypes(master.Data.Project.ProjectID);
};

const bindCurrentIssueData = () => {
  let issue = _.cloneDeep(currentIssue.value);
  
  flagIsBindingData = true;
  master.Data = issue;

  // bind Project
  master.Data.Project = { ProjectID: issue.ProjectID };

  // bind Assignee
  master.Data.Assignee = {
    EmployeeID: issue.AssigneeID,
    FullName: issue.AssigneeName,
    Avatar: issue.AssigneeAvatar,
  };

  master.Data.Files = issue.Attachments;
  master.Data.RelateEmployees = issue.Relates;
  master.Data.CustomerInfo = {
    PhoneNumber: issue.CustomerPhoneNumber,
    Email: issue.CustomerEmail,
    ContactInfo: issue.CustomerContactInfo,
  };

  master.OriginalData = _.cloneDeep(master.Data);

  bindAttachments();
};

const bindAttachments = () => {
  // bind File
  let attachments = _.cloneDeep(currentIssue.value.Attachments);
  if (attachments && attachments.length > 0) {
    attachments.forEach((file) => {
      initFileList.value.push({
        id: file.ID,
        name: file.FileName,
        status: "finished",
        url: file.Url,
        type: file.Type,
      });
    });
    fileList.value = attachments;
  }
};

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

const getDefaultIssueType = () => {
  let defaultIssue = issueTypes.value[0];
  master.Data.IssueTypeID = defaultIssue.IssueTypeID;
};

watch(
  () => master.Data.Project.ProjectID,
  (newVal, oldValue) => {
    if (newVal != oldValue) {
      if (flagIsBindingData) {
        flagIsBindingData = false;
        return;
      }
      master.Data.Assignee = {};
      master.Data.ProjectID = newVal;
    }
  }
);

watch(
  () => master.Data.Assignee.EmployeeID,
  (newVal, oldValue) => {
    if (newVal != oldValue) {
      master.Data.AssigneeID = newVal;
    }
  }
);

watch(
  () => timestamps.DesiredDate,
  (newVal, oldValue) => {
    if (newVal != null) {
      master.Data.DesiredDate = new Date(newVal);
    }
  }
);

watch(
  () => timestamps.ReceptionDate,
  (newVal, oldValue) => {
    if (newVal != null) {
      master.Data.ReceptionDate = new Date(newVal);
    }
  }
);
//#endregion
</script>

<template>
  <VModal customClass="form-issue">
    <template #default>
      <div class="form-issue--wrapper">
        <div class="form-header line-bottom m-pb8">
          <div class="flex-row flex-jsp">
            <div class="text-xl">{{ formConfig.Title }}</div>

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
            <div class="">
              <div class="form-label m-pb4">
                Tiêu đề: <span class="danger">*</span>
              </div>
              <MInput
                :placeholder="'Tóm tắt vấn đề'"
                :customClass="'m-m0 input-l'"
                inputClass="m-pl16 m-pr16"
                v-model="master.Data.IssueName"
              />
            </div>

            <div class="flex-row m-pb8">
              <div class="flex-1 m-mr8">
                <div class="form-label m-pb4">
                  Chọn dự án: <span class="danger">*</span>
                </div>
                <MTreeSelect
                  :data="departmentProjects"
                  class="m-select"
                  label-field="ProjectName"
                  key-field="ProjectID"
                  children-field="Projects"
                  v-model="master.Data.Project.ProjectID"
                  :isExpandAll="true"
                  :enableChange="true"
                  @onChange="selectProject_change"
                />
              </div>

              <div class="flex-1 m-ml8">
                <div class="form-label m-pb4">
                  Chọn loại vấn đề: <span class="danger">*</span>
                </div>
                <n-select
                  class="m-select"
                  v-model:value="master.Data.IssueTypeID"
                  :options="issueTypes"
                  label-field="IssueTypeName"
                  value-field="IssueTypeID"
                  placeholder="Chọn loại vấn đề"
                />
              </div>
            </div>

            <div class="flex-row m-pb8">
              <div class="m-w100 m-pr8">
                <div class="form-label m-pb4">
                  Chọn người thực hiện: <span class="danger">*</span>
                </div>
                <MButton
                  v-if="!master.Data.Assignee?.EmployeeID"
                  text="Chọn người thực hiện"
                  leftIcon="mi-question-circle"
                  classCustom="btn-custom-1 text-medium m-mr16 m-w100"
                  @click="btnChooseAssignee_click()"
                />

                <div
                  class="btn-custom-1 flex-row flex-align-center text-medium m-mr16 m-w100"
                  v-if="master.Data.Assignee?.EmployeeID"
                  @click="btnChooseAssignee_click()"
                >
                  <img :src="master.Data.Assignee?.Avatar" class="mi-32" />
                  <div class="performer m-ml16">
                    <div class="label-performer">Người thực hiện</div>
                    <div class="key-performer text-bold">
                      {{ master.Data.Assignee?.FullName }}
                    </div>
                  </div>
                </div>
              </div>

              <div class="m-w100 m-pl8">
                <div class="form-label m-pb4">Chọn người liên quan:</div>
                <MButton
                  v-if="
                    !master.Data.RelateEmployees ||
                    master.Data.RelateEmployees.length == 0
                  "
                  text="Chọn người liên quan"
                  leftIcon="mi-question-circle"
                  classCustom="btn-custom-1 text-medium m-w100"
                  @click="btnChooseRelate_click"
                />

                <div
                  class="btn-custom-1 flex-row flex-align-center text-medium m-mr16 m-w100"
                  v-if="master.Data.RelateEmployees.length > 0"
                  @click="btnChooseRelate_click"
                >
                  <div class="label-performer">Người liên quan : &nbsp;</div>
                  <n-avatar-group
                    :options="master.Data.RelateEmployees"
                    :size="32"
                    :max="4"
                  >
                    <template #avatar="{ option: { FullName, Avatar } }">
                      <n-tooltip>
                        <template #trigger>
                          <n-avatar :src="Avatar" />
                        </template>
                        {{ FullName }}
                      </n-tooltip>
                    </template>
                    <template #rest="{ options: restOptions, rest }">
                      <n-dropdown
                        :options="createDropdownOptions(restOptions)"
                        placement="top"
                      >
                        <n-avatar>+{{ rest }}</n-avatar>
                      </n-dropdown>
                    </template>
                  </n-avatar-group>
                  <!-- <n-tooltip>
                    <template #trigger>
                      <img
                        :src="master.Data.RelateEmployees[0].Avatar"
                        class="mi-32"
                      />
                    </template>
                    {{ master.Data.RelateEmployees[0].FullName }}
                  </n-tooltip> -->
                </div>
              </div>
            </div>

            <div class="m-pb8 flex-row">
              <div class="flex-1 m-mr8">
                <div class="form-label m-pb4">Chọn mức độ ưu tiên:</div>
                <n-select
                  class="m-select"
                  v-model:value="master.Data.Priority"
                  :options="priorities"
                  label-field="PriorityName"
                  value-field="Priority"
                  placeholder="Chọn mức độ ưu tiên"
                />
              </div>

              <div class="flex-1 m-ml8">
                <div class="form-label m-pb4">Chọn phiên bản:</div>
                <n-select
                  class="m-select"
                  v-model:value="master.Data.ProjectVersionID"
                  :options="departments"
                  label-field="DepartmentName"
                  value-field="DepartmentID"
                  placeholder="Chọn phiên bản dự án"
                />
              </div>
            </div>

            <div class="m-pb16">
              <div class="form-label m-pb8">Mô tả:</div>
              <n-input
                v-model:value="master.Data.Description"
                type="textarea"
                placeholder="Mô tả"
              />
            </div>

            <div class="m-pb8">
              <div class="custom-info-section">
                <div class="flex-row">
                  <div class="flex-1 m-pr8">
                    <div class="form-label m-pb4">
                      Số điện thoại khách hàng: <span class="danger">*</span>
                    </div>
                    <MInput
                      :placeholder="'Số điện thoại'"
                      :customClass="'m-m0 input-l'"
                      inputClass="m-pl16 m-pr16"
                      v-model="master.Data.CustomerInfo.PhoneNumber"
                    />
                  </div>

                  <div class="flex-1 m-pl8">
                    <div class="form-label m-pb4">
                      Email khách hàng: <span class="danger">*</span>
                    </div>
                    <MInput
                      :placeholder="'Email'"
                      :customClass="'m-m0 input-l'"
                      inputClass="m-pl16 m-pr16"
                      v-model="master.Data.CustomerInfo.Email"
                    />
                  </div>
                </div>

                <div class="">
                  <div class="form-label m-pb8">
                    Thông tin liên hệ của khách hàng
                    <span class="danger">*</span>
                  </div>
                  <n-input
                    v-model:value="master.Data.CustomerInfo.ContactInfo"
                    type="textarea"
                    :rows="4"
                    placeholder="Mô tả"
                  />
                </div>
              </div>
            </div>

            <div class="">
              <div class="form-label m-pb8">Tệp đính kèm</div>
              <n-upload
                directory-dnd
                :action="UPLOAD_DOMAIN"
                list-type="image"
                show-download-button
                :default-file-list="initFileList"
                @finish="finishUploadFile"
                @beforeUpload="beforeUploadFile"
                @error="errorUploadFile"
                @remove="removeFile"
              >
                <n-upload-dragger>
                  <div class="">Kéo thả hoặc chọn file để upload</div>
                </n-upload-dragger>
              </n-upload>
            </div>

            <div class="flex-row m-pb8">
              <div class="flex-1 m-pr8">
                <div class="form-label m-pb4">Thời hạn mong muốn:</div>
                <n-date-picker
                  v-model:value="timestamps.DesiredDate"
                  type="datetime"
                  placeholder="Thời hạn mong muốn"
                  :format="'dd/MM/yyyy - HH:mm'"
                  clearable
                />
              </div>

              <div class="flex-1 m-pl8">
                <div class="form-label m-pb4">Ngày tiếp nhận:</div>
                <n-date-picker
                  v-model:value="timestamps.ReceptionDate"
                  placeholder="Ngày tiếp nhận"
                  type="datetime"
                  :format="'dd/MM/yyyy - HH:mm'"
                  clearable
                />
              </div>
            </div>

            <div class="m-pb8">
              <div class="form-label m-pb8">Giải pháp tạm thời</div>
              <n-input
                v-model:value="master.Data.PreliminarySolution"
                type="textarea"
                placeholder="Giải pháp tạm thời"
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
.form-issue--wrapper {
  width: 680px;
}

.form-issue--wrapper .form-body {
  padding: 8px 8px 0 8px;
}

.form-issue--wrapper .btn-choose-employee {
  height: 38px;
  color: var(--primary-color) !important;
  border: 1px solid var(--primary-color);
}

.m-select .n-base-selection {
  --n-font-size: 15px !important;
  --n-height: 38px !important;
}

.n-virtual-list {
  --n-option-text-color-active: var(--primary-color) !important;
  --n-option-check-color: var(--primary-color) !important;
}

.project-date .n-input {
  --n-height: 38px !important;
  --n-border-hover: 1px solid var(--primary-color) !important;
  --n-border-focus: 1px solid var(--primary-color) !important;
}

.dropdown-search-employee.n-dropdown-menu {
  width: 500px !important;
}

.employee-permission .n-base-selection {
  --n-border: 0 !important;
  min-width: 130px;
}

.v-binder-follower-content:has(.dropdown-search-employee) {
  max-height: 300px !important;
  overflow-y: auto;
}
</style>
