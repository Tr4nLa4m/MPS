<script setup>
import { ModuleContext, ModuleIssue } from "@/store/moduleConstant";
import { useUploadFile } from "@/utils/uses/base/useUploadFile";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";
import CommentTab from "@/views/pages/project/issue/detailTabs/CommentTab.vue";
import ActivityTab from "@/views/pages/project/issue/detailTabs/ActivityTab.vue";
import { ref, onMounted, reactive, nextTick, computed, inject, h } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import eventBus, { GlobalEventName } from "@/utils/helper/eventBus";
import useEventBus from "@/utils/uses/base/useEventBus";
import { cloneDeep } from "lodash";
import { useModal } from "vue-final-modal";
import AddIssue from "@/components/popup/form/AddIssue.vue";
import MConstant, { GUID_EMPTY } from "@/common/consts/MConstant";
import ResolveIssue from "@/components/popup/form/ResolveIssue.vue";
import ReOpenIssue from "@/components/popup/form/ReOpenIssue.vue";
import FilterEmployee from "@/components/popup/form/FilterEmployee.vue";
import { useMessages } from "@/utils/uses/base/useMessages";
import DeleteConfirm from "@/components/popup/form/DeleteConfirm.vue";

const store = useStore();
const route = useRoute();
const { goTo404, goToIssueTab } = useRoutePath();
const commonFn = inject("CommonFn");
const models = inject("Model");
const { warning, success, error } = useMessages();
const eventReloadIssue = useEventBus(
  GlobalEventName.loadIssueComment,
  async () => await loadIssue()
);

const handleRemoveFile = async (file) => {
  let param = {
    IssueID: issue.value.IssueID,
    ID: file.ID,
  };
  await store.dispatch(ModuleIssue + "/removeFile", { data: param });
};

const handleAttachFile = async (file, response) => {
  let issueFile = cloneDeep(file);
  issueFile["IssueID"] = issue.value.IssueID;

  await store.dispatch(ModuleIssue + "/attachFile", { data: issueFile });
};

const methodsHandleFile = {
  onRemove: handleRemoveFile,
  onFinish: handleAttachFile,
};

const {
  UPLOAD_DOMAIN,
  fileList,
  initFileList,
  beforeUploadFile,
  finishUploadFile,
  errorUploadFile,
  removeFile,
} = useUploadFile({}, methodsHandleFile);
const employee = computed(() => store.state[ModuleContext]?.employee);
const userPermissions = computed(() =>
  store.getters[ModuleContext + "/getUserProjectPermission"](
    issue.value.ProjectID
  )
);

const issue = computed(() => store.state[ModuleIssue].issue);
const isWatchingIssue = computed(() => {
  if (!issue.value.Watchers || !issue.value.Watchers.length) {
    return false;
  }
  let watchers = issue.value.Watchers;
  let employeeIndex = watchers.findIndex(
    (watcher) => watcher.EmployeeID == employee.value.EmployeeID
  );
  return employeeIndex >= 0;
});

const issueIsNotResolve = computed(
  () =>
    issue.value.SolutionID == null ||
    issue.value.SolutionID == GUID_EMPTY ||
    issue.value.IssueStatus == 5
);

const issueClosed = computed(() => issue.value.IsClosed);
const getReOpenIssueBtn = computed(() => {
  if (issue.value.IsClosed) {
    return true;
  }
  if (!issueIsNotResolve) {
    return true;
  }

  return false;
});
const commentInputEl = ref(null);
const commentText = ref("");

const loading = reactive({
  CommentTab: false,
});
const showEl = reactive({
  commentInput: false,
});

const dropdownMoreOptions = [
  {
    label: "Đính kèm",
    key: "attachIssue",
  },
  {
    label: () => h("div", { class: "danger" }, "Xoá"),
    key: "deleteIssue",
  },
];

const editIssueModal = useModal({
  component: AddIssue,
  attrs: {
    mode: MConstant.FormMode.Edit,
    issueID: route.params.IssueID,

    onCloseModal() {
      editIssueModal.close();
    },
    async onUpdatedComment() {
      await getComments();
    },
  },
});

const resolveIssueModal = useModal({
  component: ResolveIssue,
  attrs: {
    onCloseModal() {
      resolveIssueModal.close();
    },
    async onUpdatedIssue() {
      await loadIssue();
    },
  },
});

const reOpenIssueModal = useModal({
  component: ReOpenIssue,
  attrs: {
    onCloseModal() {
      reOpenIssueModal.close();
    },
    async onUpdatedIssue() {
      await loadIssue();
    },
  },
});

const chooseAssigneeModal = useModal({
  component: FilterEmployee,
  attrs: {
    project: {
      ProjectID: route.params.ProjectID,
    },
    onCloseModal() {
      chooseAssigneeModal.close();
    },
    async onChooseEmployee(assignee) {
      await assignIssue(assignee);
    },
  },
});

const deleteConfirmModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá vấn đề",
    content:
      "Dữ liệu vấn đề sẽ bị xóa khỏi hệ thống. Bạn có chắc chắn muốn xóa vấn đề này?",

    onCloseModal() {
      deleteConfirmModal.close();
    },

    async onDelete() {
      deleteConfirmModal.close();
      await deleteIssue();
    },
  },
});

const checkDisableItem = computed(() => (component) => {
  let permissions = userPermissions.value;
  debugger;
  let checkHasPermissions = (permission) => {
    return permissions.find((item) => item.PermissionCode == permission);
  };
  switch (component) {
    case "edit":
      if (
        employee.value.EmployeeID != issue.value.CreatorID ||
        !checkHasPermissions(MConstant.ProjectPermissions.Issue.Issue_Edit_All)
      ) {
        return false;
      }

      if (!issueIsNotResolve) {
        return false;
      }
      return true;
      break;
    case "resolve":
      if (issueClosed.value) return false;
      if (issue.value.IssueStatus != MConstant.IssueStatus.InProgress)
        return false;

      if (checkHasPermissions(MConstant.ProjectPermissions.Issue.Issue_Resolve))
        return true;
      if (employee.value.EmployeeID == issue.value.AssigneeID) {
        return true;
      }

      return false;
      break;
    case "start":
      let arrStatus = [MConstant.IssueStatus.Pending, MConstant.IssueStatus.Imqualified];
      if (!arrStatus.includes(issue.value.IssueStatus))
        return false;
      if (checkHasPermissions(MConstant.ProjectPermissions.Issue.Issue_Resolve))
        return true;
      if (employee.value.EmployeeID == issue.value.AssigneeID) {
        return true;
      }

      return false;
      break;
    case "stop":
      if (issue.value.IssueStatus != MConstant.IssueStatus.InProgress)
        return false;
      if (checkHasPermissions(MConstant.ProjectPermissions.Issue.Issue_Resolve))
        return true;
      if (employee.value.EmployeeID == issue.value.AssigneeID) {
        return true;
      }

      return false;
      break;
    case "assign":
      if (issueClosed.value) return false;
      if (
        checkHasPermissions(MConstant.ProjectPermissions.Issue.Issue_Edit_All)
      )
        return true;
      if (employee.value.EmployeeID == issue.value.CreatorID) {
        return true;
      }

      return false;
      break;
    case "close":
      debugger
      if (issueClosed.value) return false;
      if (
        checkHasPermissions(MConstant.ProjectPermissions.Issue.Issue_Open_Close)
      )
        return true;
      return false;
      break;
    case "open":
      if (!issueClosed.value) return false;
      if(issue.value.IssueStatus != MConstant.IssueStatus.Processed) return false;
      if (
        checkHasPermissions(MConstant.ProjectPermissions.Issue.Issue_Open_Close)
      )
        return true;
      return false;
      break;
    default:
      break;
  }
});

onMounted(async () => {
  checkIssueValid();

  await loadIssue();
});

const loadIssue = async () => {
  await getIssue();

  bindInitData();
};

const bindInitData = () => {
  loading.CommentTab = true;

  bindAttachments();
};

const bindAttachments = () => {
  // bind File
  let attachments = issue.value.Attachments;
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

//#region Hàm xử lý sự kiện
const btnReload_click = async () => {
  await getIssue();
};

const btnWatchIssue_click = async () => {
  let res = await watchIssue();

  if (res) {
    await getIssue();
  }
};

const btnComment_click = () => {
  showEl.commentInput = true;

  nextTick(() => {
    commentInputEl.value.focus();
    commentInputEl.value.scrollTo({
      behavior: "smooth", // You can use 'auto' or 'smooth' for scrolling behavior
      block: "end", // You can use 'start', 'center', 'end', or 'nearest'
    });
  });
};

const btnAddComment_click = async () => {
  await insertComment();
};

const btnResolve_click = () => {
  resolveIssueModal.open();
};

const btnReOpen_click = () => {
  reOpenIssueModal.open();
};

const btnStartProgress_click = async () => {
  let param = {
    data: {
      IssueID: issue.value.IssueID,
      IssueStatus: MConstant.IssueStatus.InProgress,
    },
    onSuccess: async () => {
      await getIssue();
    },
    onFailure: () => error("Có lỗi xảy ra"),
  };

  await store.dispatch(ModuleIssue + "/updateStatus", param);
};

const btnStopProgress_click = async () => {
  let param = {
    data: {
      IssueID: issue.value.IssueID,
      IssueStatus: MConstant.IssueStatus.Pending,
    },
    onSuccess: async () => {
      await getIssue();
    },
    onFailure: () => error("Có lỗi xảy ra"),
  };

  await store.dispatch(ModuleIssue + "/updateStatus", param);
};

const btnCloseIssue_click = async () => {
  let onSuccess = async () => {
    success("Đóng vấn đề thành công");
    await getIssue();
  };

  let onFailure = () => error("Có lỗi xảy ra khi đóng vấn đề");
  let param = {
    data: {
      IssueID: issue.value.IssueID,
    },
    onSuccess,
    onFailure,
  };

  await store.dispatch(ModuleIssue + "/closeIssue", param);
};

const btnAssign_click = () => {
  chooseAssigneeModal.open();
};

const btnEdit_click = () => {
  editIssueModal.open();
};

const btnMoreOption_click = (key, option) => {
  switch (key) {
    case "deleteIssue":
      deleteConfirmModal.open();
      break;

    default:
      break;
  }
};
//#endregion

//#region Hàm xử lý Logic
const checkIssueValid = () => {
  let issueID = route.params.IssueID;

  if (!issueID) {
    goTo404();
  }
};

const getIssue = async () => {
  let param = {
    data: {
      IssueID: route.params.IssueID,
    },
  };
  await store.dispatch(ModuleIssue + "/getIssue", param);
};

const watchIssue = async () => {
  let param = {
    data: {
      IssueID: issue.value.IssueID,
      EmployeeID: employee.value.EmployeeID,
      IsWatching: !isWatchingIssue.value,
    },
  };

  return await store.dispatch(ModuleIssue + "/watchIssue", param);
};

const insertComment = async () => {
  let param = models.createIssueCommentParam();
  param.IssueID = route.params.IssueID;
  param.Content = commentText.value;
  let res = await store.dispatch(ModuleIssue + "/insertComment", {
    data: param,
  });
  if (res) {
    resetComment();
    eventBus.$emit(GlobalEventName.loadIssueComment);
  }
};

const resetComment = () => {
  commentText.value = "";
  showEl.commentInput = false;
};

const assignIssue = async (employee) => {
  if (employee.EmployeeID == issue.value.AssigneeID) {
    warning("Nhân viên đã chọn là người đang xử lý vấn đề này!");
    return;
  }
  let param = {
    data: {
      IssueID: issue.value.IssueID,
      AssigneeID: employee.EmployeeID,
    },
    onSuccess: async () => await getIssue(),
  };

  var res = store.dispatch(ModuleIssue + "/assignIssue", param);
};

const deleteIssue = async () => {
  let onSuccess = () => {
    success("Xoá vấn đề thành công");
    goToIssueTab(route.params.ProjectID);
  };
  let param = {
    data: {
      IssueID: issue.value.IssueID,
    },
    onSuccess,
  };

  let res = await store.dispatch(ModuleIssue + "/deleteIssue", param);
};

//#endregion
</script>

<template>
  <div class="issue-detail--wrapper">
    <n-scrollbar :style="`max-height: 600px`">
      <div class="issue-detail-header m-pb16">
        <div class="issue-detail-nav flex-row">
          <div class="text-link-v3">Tất cả vấn đề</div>
          <div class="">&nbsp;/ &nbsp;</div>
          <div class="text-link-v3">{{ issue.IssueCode }}</div>
        </div>

        <div class="issue-detail-title">
          <div class="text-xl">
            {{ issue.IssueName }}
          </div>
        </div>
      </div>

      <div class="issue-detail-body">
        <div class="tool-bar flex-row m-pb16">
          <div class="tool-bar-left flex-row">
            <MButton
              :text="'Bình luận'"
              :title="'Bình luận'"
              :classCustom="'m-button-m detail-issue-btn m-mr8'"
              leftIcon="mi-24 mi-comment"
              :classText="'m-mr8 m-ml8'"
              @click="btnComment_click"
            />

            <MButton
              v-if="checkDisableItem('edit')"
              :text="'Sửa'"
              :title="'Chỉnh sửa vấn đề'"
              :classCustom="'m-button-m detail-issue-btn m-mr8'"
              :classText="'m-mr8 m-ml8'"
              @click="btnEdit_click"
            />

            <MButton
              v-if="checkDisableItem('assign')"
              :text="'Giao cho'"
              :title="'Giao cho'"
              :classCustom="'m-button-m detail-issue-btn m-mr4'"
              :classText="'m-mr8 m-ml8'"
              @click="btnAssign_click"
            />

            <n-dropdown
              trigger="click"
              :options="dropdownMoreOptions"
              :show-arrow="true"
              @select="btnMoreOption_click"
            >
              <MButton
                :text="'Thêm'"
                :title="'Thêm'"
                :classCustom="'m-button-m detail-issue-btn m-mr8'"
                rightIcon="mi-16 mi-carret-down"
                :classText="'m-mr8 m-ml8'"
              />
            </n-dropdown>

            <MButton
              v-if="checkDisableItem('start')"
              :text="'Bắt đầu'"
              :title="'Bắt đầu thực hiện vấn đề'"
              :classCustom="'m-button-m detail-issue-btn m-mr4'"
              :classText="'m-mr8 m-ml8'"
              @click="btnStartProgress_click"
            />

            <MButton
              v-if="checkDisableItem('stop')"
              :text="'Tạm dừng'"
              :title="'Tạm dừng thực hiện vấn đề'"
              :classCustom="'m-button-m detail-issue-btn m-mr4'"
              :classText="'m-mr8 m-ml8'"
              @click="btnStopProgress_click"
            />

            <MButton
              v-if="checkDisableItem('resolve')"
              :text="'Giải quyết'"
              :title="'Giải quyết'"
              :classCustom="'m-button-m detail-issue-btn m-mr4'"
              :classText="'m-mr8 m-ml8'"
              @click="btnResolve_click"
            />

            <MButton
              v-if="checkDisableItem('close')"
              :text="'Đóng'"
              :title="'Đóng'"
              :classCustom="'m-button-m detail-issue-btn'"
              :classText="'m-mr8 m-ml8'"
              @click="btnCloseIssue_click"
            />

            <MButton
              v-if="checkDisableItem('open')"
              :text="'Mở lại'"
              :title="'Mở lại'"
              :classCustom="'m-button-m detail-issue-btn m-ml8'"
              :classText="'m-mr8 m-ml8'"
              @click="btnReOpen_click"
            />
          </div>

          <div class="flex-1"></div>

          <div class="tool-bar-right flex-row">
            <MButton
              :title="'Lấy lại dữ liệu'"
              :classCustom="'m-button-m detail-issue-btn'"
              leftIcon="mi-24 mi-reload"
              :classText="'m-mr8 m-ml8'"
              @click="btnReload_click"
            />
          </div>
        </div>

        <div class="issue-detail-content flex-row">
          <div class="issue-detail-main">
            <div class="info-section m-pb16">
              <n-collapse :default-expanded-names="['1']">
                <n-collapse-item title="Chi tiết vấn đề" name="1">
                  <div class="detail-row">
                    <div class="detail-row row-2">
                      <div class="detail-label">Loại:</div>
                      <div
                        class="detail-value flex-row flex-align-center"
                        :title="issue.IssueTypeDescription"
                      >
                        <div class="mi-16 m-mr8">
                          <img :src="issue.IssueTypeAvatar" />
                        </div>
                        <div class="">{{ issue.IssueTypeName }}</div>
                      </div>
                    </div>

                    <div class="detail-row row-2">
                      <div class="detail-label">Trạng thái:</div>
                      <div class="detail-value">
                        {{ issue.IssueStatusName }}
                      </div>
                    </div>
                  </div>

                  <div class="detail-row">
                    <div class="detail-row row-2">
                      <div class="detail-label">Độ ưu tiên:</div>
                      <div class="detail-value">{{ issue.PriorityName }}</div>
                    </div>

                    <div class="detail-row row-2">
                      <div class="detail-label">Giải pháp:</div>
                      <div class="detail-value">
                        {{
                          issue.SolutionName ? issue.SolutionName : "Chưa có"
                        }}
                      </div>
                    </div>
                  </div>

                  <div class="detail-row">
                    <div class="detail-row row-2">
                      <div class="detail-label">Phiên bản ảnh hưởng:</div>
                      <div class="detail-value">
                        {{
                          issue.ProjectVersionID
                            ? issue.ProjectVersionID
                            : "Không"
                        }}
                      </div>
                    </div>

                    <div class="detail-row row-2">
                      <div class="detail-label">Phiên bản cập nhật:</div>
                      <div class="detail-value">
                        {{ "Không" }}
                      </div>
                    </div>
                  </div>

                  <div class="detail-row">
                    <div class="detail-label">Đã tiếp nhận yêu cầu:</div>
                    <div class="detail-value">
                      {{ issue.AssigneeID ? "Đã tiếp nhận" : "Chưa tiếp nhận" }}
                    </div>
                  </div>

                  <div class="detail-row">
                    <div class="detail-label">Diễn giải:</div>
                    <div class="detail-value" v-html="issue.Description"></div>
                  </div>

                  <div class="detail-row">
                    <div class="detail-row row-2">
                      <div class="detail-label">Số ĐT khách hàng:</div>
                      <div class="detail-value">
                        {{ issue.CustomerPhoneNumber }}
                      </div>
                    </div>

                    <div class="detail-row row-2">
                      <div class="detail-label">Email khách hàng:</div>
                      <div class="detail-value">{{ issue.CustomerEmail }}</div>
                    </div>
                  </div>

                  <div class="detail-row">
                    <div class="detail-label">
                      Thông tin liên hệ của khách hàng:
                    </div>
                    <div
                      style="white-space: pre-wrap"
                      class="detail-value"
                      v-html="issue.CustomerContactInfo"
                    ></div>
                  </div>
                </n-collapse-item>
              </n-collapse>
            </div>

            <div class="attachment-section m-pb16">
              <n-collapse :default-expanded-names="['1']">
                <n-collapse-item title="Tệp đính kèm" name="1">
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
                </n-collapse-item>
              </n-collapse>
            </div>

            <div class="activity-section m-pb16">
              <n-collapse :default-expanded-names="['1']">
                <n-collapse-item title="Hoạt động" name="1">
                  <n-tabs type="line" animated class="m-tabs m-pl16">
                    <n-tab-pane name="task-tab_Comment" tab="Bình luận">
                      <CommentTab
                        v-if="loading.CommentTab"
                        :issueID="issue.IssueID"
                      />
                    </n-tab-pane>
                    <n-tab-pane name="task-tab_Activity" tab="Hoạt động">
                      <ActivityTab :issueID="issue.IssueID" />
                    </n-tab-pane>
                  </n-tabs>
                </n-collapse-item>
              </n-collapse>

              <div class="m-mt16">
                <MButton
                  :text="'Bình luận'"
                  :title="'Bình luận'"
                  :classCustom="'m-button-m detail-issue-btn m-mr8'"
                  leftIcon="mi-24 mi-comment"
                  :classText="'m-mr8 m-ml8'"
                  v-if="!showEl.commentInput"
                  @click="btnComment_click"
                />

                <div class="issue-comment-input" v-if="showEl.commentInput">
                  <div class="text-bold m-mb8">Bình luận</div>
                  <n-input
                    v-model:value="commentText"
                    type="textarea"
                    placeholder="Bình luận"
                    rows="6"
                    ref="commentInputEl"
                  />

                  <div class="m-mt8 flex-row flex-align-center">
                    <MButton
                      :text="'Thêm'"
                      :title="'Thêm bình luận'"
                      :classCustom="'m-button-m detail-issue-btn m-mr16'"
                      :classText="'m-mr8 m-ml8'"
                      @click="btnAddComment_click"
                    />

                    <div class="" @click="showEl.commentInput = false">
                      <div class="text-link-v3">Huỷ</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="issue-detail-sidebar">
            <div class="human-section m-pb16">
              <n-collapse :default-expanded-names="['1']">
                <n-collapse-item title="Tham gia" name="1">
                  <div class="detail-row m-mb8">
                    <div class="detail-label">Người thực hiện:</div>
                    <div class="detail-value flex-row flex-align-center">
                      <div class="card-avt mi-24 m-mr8">
                        <img class="round" :src="issue.AssigneeAvatar" />
                      </div>
                      <div class="">{{ issue.AssigneeName }}</div>
                    </div>
                  </div>

                  <div class="detail-row m-mb8">
                    <div class="detail-label">Người báo cáo:</div>
                    <div class="detail-value flex-row flex-align-center">
                      <div class="card-avt mi-24 m-mr8">
                        <img class="round" :src="issue.CreatorAvatar" />
                      </div>
                      <div class="">{{ issue.CreatorName }}</div>
                    </div>
                  </div>

                  <div class="detail-row m-mb8">
                    <div class="detail-label">Người liên quan:</div>
                    <div class="detail-value flex-row flex-align-center">
                      <n-avatar-group
                        :options="issue.Relates"
                        :size="28"
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
                    </div>
                  </div>

                  <div class="detail-row">
                    <div class="detail-label">Người theo dõi:</div>
                    <div class="detail-value flex-row flex-align-center">
                      <n-badge
                        :value="issue.Watchers?.length || 0"
                        color="grey"
                        show-zero
                      />
                      <div
                        class="text-link-v3 m-ml8"
                        v-if="!isWatchingIssue"
                        @click="btnWatchIssue_click"
                      >
                        Theo dõi vấn đề này
                      </div>
                      <div
                        class="text-link-v3 m-ml8"
                        v-else
                        @click="btnWatchIssue_click"
                      >
                        Huỷ theo dõi vấn đề này
                      </div>
                    </div>
                  </div>
                </n-collapse-item>
              </n-collapse>
            </div>

            <div class="date-section m-pb16">
              <n-collapse :default-expanded-names="['1']">
                <n-collapse-item title="Thời gian" name="1">
                  <div class="detail-row">
                    <div class="detail-label">Ngày tạo:</div>
                    <div class="detail-value">
                      {{
                        issue.CreatedDate
                          ? commonFn.formatDate(issue.CreatedDate)
                          : ""
                      }}
                    </div>
                  </div>

                  <div class="detail-row">
                    <div class="detail-label">Cập nhật:</div>
                    <div class="detail-value">
                      {{
                        issue.ModifiedDate
                          ? commonFn.formatDate(issue.ModifiedDate)
                          : ""
                      }}
                    </div>
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
.issue-detail--wrapper {
  background-color: #fff;
  margin: 16px 8px;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 8px 8px 8px 16px;
  height: calc(100vh - 90px);
}

.issue-detail-main {
  width: 65%;
}

.issue-detail-sidebar {
  width: 35%;
  padding-left: 20px;
}

.detail-issue-btn {
  background-color: rgba(9, 30, 66, 0.08) !important;
  color: var(--text-color-blue-grey) !important;
  font-size: 14px !important;
  font-weight: 300 !important;
}

.detail-issue-btn:hover {
  background-color: rgba(9, 30, 66, 0.13) !important;
}

.detail-row {
  display: flex;
}

.detail-row .row-2 {
  flex: 1;
}

.detail-label {
  width: 150px;
  max-width: 150px;
  padding: 2px 8px 2px 4px;
  opacity: 0.8;
}

.detail-value {
  width: calc(100% - 150px);
  padding: 2px 8px 2px 4px;
}
</style>
