<script setup>
import { ModuleTask, ModuleContext } from "@/store/moduleConstant";
import { useMessages } from "@/utils/uses/base/useMessages";
import { cloneDeep } from "lodash";
import { inject } from "vue";
import { reactive } from "vue";
import { h, ref, computed, onMounted } from "vue";
import { useStore } from "vuex";
import {DEFAULT_PAGE_SIZE } from "@/common/consts/MConstant";

const props = defineProps({
  taskID: {
    type: String,
    default: "",
  },
});

const store = useStore();
const commonFn = inject("CommonFn");
const models = inject("Model");
const { error } = useMessages();
const showEditEl = reactive({});
const employee = computed(() => store.state[ModuleContext]?.employee);
const comments = computed(() => {
  let dataComment = cloneDeep(store.state[ModuleTask]?.comments) || [];
  dataComment.forEach((element) => {
    showEditEl[element.CommentID] = false;
  });
  return dataComment.reverse();
});

const pageSize = DEFAULT_PAGE_SIZE;
const totalPage = computed(() => {
  return Math.ceil(comments.value.length / pageSize);
});
const pageIndex = ref(0);

const getPagingComment = computed(() => {
  if(comments.value.length === 0){
    return [];
  }
  let endIndex = comments.value.length;
  let startIndex = pageSize * (totalPage.value - pageIndex.value - 1);

  return comments.value.slice(startIndex, endIndex);
});

const getShowAction = computed(() => {
  return (comment) => {
    let isAuthor = comment?.EmployeeID == employee.value.EmployeeID;
    if (!isAuthor) {
      return false;
    }
    if (isAuthor) {
      return !showEditEl[comment.CommentID];
    }
  };
});

onMounted(async () => {
  if (props.taskID) {
    await getComments();
  }
});

const getComments = async () => {
  let pamram = {
    data: {
      TaskID: props.taskID,
    },
  };
  await store.dispatch(ModuleTask + "/getCommentByTask", pamram);
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

const handleSaveComment = async () => {
  if (commentInput.value.length > 0) {
    await saveComment();
  }
};

const handleSaveCommentEdit = async (item) => {
  if (commentEditInput.value.length > 0) {
    await updateComment(item);
  }
};

const saveComment = async () => {
  let data = models.createTaskCommentParam();
  data.TaskID = props.taskID;
  data.CreatedBy = employee.value.EmployeeCode;
  data.Content = commentInput.value;

  let param = {
    data,
    onFailure: () => {
      error("Có lỗi xảy ra khi lưu bình luận");
    },
  };

  await store.dispatch(ModuleTask + "/insertComment", param);

  commentInput.value = "";

  await getComments();
};

const updateComment = async (comment) => {
  let data = cloneDeep(comment);
  data.Content = commentEditInput.value;

  let param = {
    data
  }

  await store.dispatch(ModuleTask + '/updateComment', param);

  await getComments();
};

const deleteComment = async (comment) => {
  let param = {
    data: {
        CommentID: comment.CommentID
    }
  }

  await store.dispatch(ModuleTask + '/deleteComment', param);

  await getComments();
}

const handleSelectDropdownComment = async (key, option, comment) => {

  if(key == "edit"){
    showEditEl[comment.CommentID] = true;
    commentEditInput.value = comment.Content;
  }

  if(key == "delete"){
    await deleteComment(comment);
  }
};

const btnMore_click = () => {
  pageIndex.value += 1;
}
</script>

<template>
  <div class="task-comment">
    <span
      v-if="pageIndex + 1 < totalPage "
        class="text-link-small pointer m-ml8"
        @click="btnMore_click"
        >Xem thêm</span
      >
    <div class="task-list-comment">
      
      <div class="comment-card flex-row" v-for="item in comments">
        <div class="comment-avt">
          <div class="mi-32 m-mr8">
            <img :src="item.Avatar" class="round" />
          </div>
        </div>

        <div class="comment-body m-w100">
          <div class="comment-content flex-row flex-align-center">
            <div class="comment-main" v-if="!showEditEl[item.CommentID]">
              <div class="comment-author-title title-small">
                {{ item.FullName }}
              </div>
              <div class="comment-text">{{ item.Content }}</div>
            </div>

            <div
              class="comment-edit task-comment-input m-w100"
              v-if="showEditEl[item.CommentID]"
            >
              <MIconInput
                :placeholder="'Nhập và nhấn enter để gửi'"
                :iconRight="[
                  'mi-24 mi-send-blue',
                  commentEditInput.length == 0 ? 'icon-disable' : '',
                ]"
                :customClass="'m-m0'"
                :submitOnKeydown="true"
                @onEnter="() => handleSaveCommentEdit(item)"
                @onIconClick="() => handleSaveCommentEdit(item)"
                v-model="commentEditInput"
              />
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

              <div
                class="pointer text-hover-link"
                v-if="showEditEl[item.CommentID]"
                @click="showEditEl[item.CommentID] = false"
              >
                Huỷ
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="task-comment-input">
      <MIconInput
        :placeholder="'Nhập và nhấn enter để gửi'"
        :iconRight="[
          'mi-24 mi-send-blue',
          commentInput.length == 0 ? 'icon-disable' : '',
        ]"
        :customClass="'m-m0'"
        :submitOnKeydown="true"
        @onEnter="handleSaveComment"
        @onIconClick="handleSaveComment"
        v-model="commentInput"
      />
    </div>
  </div>
</template>

<style>
.task-comment .comment-main {
  background-color: var(--background-comment);
  padding: 8px 16px 8px 12px;
  border-radius: 8px;
}

.task-comment .comment-content {
  width: 100%;
}

.task-comment .comment-content .comment-action {
  display: none;
}

.task-comment .comment-action .comment-action-wrap {
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
