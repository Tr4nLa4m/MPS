<script setup>
import EditCommentVue from "@/components/popup/form/EditComment.vue";
import { ModuleIssue, ModuleContext } from "@/store/moduleConstant";
import { GlobalEventName } from "@/utils/helper/eventBus";
import { useMessages } from "@/utils/uses/base/useMessages";
import { cloneDeep } from "lodash";
import { inject } from "vue";
import { reactive } from "vue";
import { h, ref, computed, onMounted } from "vue";
import { useStore } from "vuex";
import useEventBus from "@/utils/uses/base/useEventBus";
import { useModal } from "vue-final-modal";

const props = defineProps({
  issueID: {
    type: String,
    default: "",
  },
});

const emits = defineEmits(["updateComment"]);

const store = useStore();
const commonFn = inject("CommonFn");
const models = inject("Model");
let a = useEventBus(
  GlobalEventName.loadIssueComment,
  async () => await getComments()
);
const { error } = useMessages();
const employee = computed(() => store.state[ModuleContext]?.employee);
const comments = computed(() => {
  let dataComment = cloneDeep(store.state[ModuleIssue]?.comments) || [];
  return dataComment.reverse();
});
const commentEdit = ref({});

const getShowAction = computed(() => {
  return (comment) => {
    let isAuthor = comment?.EmployeeID == employee.value.EmployeeID;
    if (!isAuthor) {
      return false;
    }
    if (isAuthor) {
      return true;
    }
  };
});

const editCommentModal = useModal({
  component: EditCommentVue,
  attrs: {
    comment: commentEdit,

    onCloseModal() {
        editCommentModal.close();
    },
    async onUpdatedComment() {
        await getComments();
    },
  },
});

onMounted(async () => {
  if (props.issueID) {
    let res = await getComments();
  }
});

const getComments = async () => {
  let pamram = {
    data: {
      IssueID: props.issueID,
    },
  };
  await store.dispatch(ModuleIssue + "/getIssueComments", pamram);
};

const commentInput = ref("");
const commentEditInput = ref("");

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

const dropdownCommentOptions = [
  {
    label: "Sửa bình luận",
    key: "edit",
    icon: renderIcon("mi-pencil-edit"),
  },
  {
    label: () => h("div", { class: "danger" }, "Xoá"),
    key: "delete",
    icon: renderIcon("mi-delete-close"),
  },
];

const deleteComment = async (comment) => {
  let param = {
    data: {
      CommentID: comment.CommentID,
    },
  };

  await store.dispatch(ModuleIssue + "/deleteComment", param);

  await getComments();
};

const handleSelectDropdownComment = async (key, option, comment) => {
  if (key == "edit") {
    commentEdit.value = comment;
    editCommentModal.open();
  }

  if (key == "delete") {
    await deleteComment(comment);
  }
};
</script>

<template>
  <div class="issue-comment">
    <div class="issue-list-comment">
      <div class="comment-card flex-row" v-for="item in comments">
        <div class="comment-avt">
          <div class="mi-32 m-mr8">
            <img :src="item.Avatar" class="round" />
          </div>
        </div>

        <div class="comment-body m-w100">
          <div class="comment-content flex-row flex-align-center">
            <div class="comment-main">
              <div class="comment-author-title title-small">
                {{ item.FullName }}
              </div>
              <div class="comment-text" style="white-space: pre-wrap;">{{  item.Content }}</div>
            </div>

            <div class="comment-action" v-if="getShowAction(item)">
              <n-dropdown
                trigger="click"
                :options="dropdownCommentOptions"
                :show-arrow="true"
                @select="
                  (index, option) =>
                    handleSelectDropdownComment(index, option, item)
                "
              >
                <div class="comment-action-wrap">
                  <div class="mi-24 mi-more"></div>
                </div>
              </n-dropdown>
            </div>
          </div>

          <div class="comment-info">
            <div class="flex-row text-small fade m-mt8 m-mb8">
              <div class="m-pr16">
                {{
                  commonFn.calculateTimeAgo(
                    item.ModifiedDate ? item.ModifiedDate : item.CreatedDate
                  )
                }}
              </div>
              <div class="m-pr16" v-if="item.ModifiedDate">Đã chỉnh sửa</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.issue-comment .comment-main {
  background-color: var(--background-comment);
  padding: 8px 16px 8px 12px;
  border-radius: 8px;
}

.issue-comment .comment-content {
  width: 100%;
}

.issue-comment .comment-content .comment-action {
  display: none;
}

.issue-comment .comment-action .comment-action-wrap {
  margin-left: 8px;
  border-radius: 15px;
  background-color: #eeeeef;
  padding: 4px;
  cursor: pointer;
}

.comment-content:hover .comment-action,
.comment-action:hover {
  display: block; /* Show the comment-action when hovering over comment-main or comment-action itself */
}

.task-comment-input .m-input {
  padding: 12px 16px !important;
}

.task-comment-input .m-row-input {
  border-radius: 16px !important;
}
</style>
