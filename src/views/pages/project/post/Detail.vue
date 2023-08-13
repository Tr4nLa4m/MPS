<script setup>
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";
import { ref, inject, onMounted, reactive, computed } from "vue";
import { ModulePost, ModuleContext } from "@/store/moduleConstant";
import PostCommentList from "@/views/pages/project/post/detailTabs/PostCommentList.vue";
import { useModal } from "vue-final-modal";
import AddPost from "@/components/popup/form/AddPost.vue";
import SharePost from "@/components/popup/form/post/SharePost.vue";
import MConstant from "@/common/consts/MConstant";
import DeleteConfirm from "@/components/popup/form/DeleteConfirm.vue";
import { useMessages } from "@/utils/uses/base/useMessages";

const store = useStore();
const route = useRoute();
const { goTo404, goToPostTab } = useRoutePath();
const { success } = useMessages();
const commonFn = inject("CommonFn");
const models = inject("Model");
const post = computed(() => store.state[ModulePost].post);
const employee = computed(() => store.state[ModuleContext]?.employee);
const userPermissions = computed(() => store.getters[ModuleContext + '/getUserProjectPermission']());
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

const isWatchingPost = computed(() => {
  if (!post.value.Watchers || !post.value.Watchers.length) {
    return false;
  }
  let watchers = post.value.Watchers;
  let employeeIndex = watchers.findIndex(
    (watcher) => watcher.EmployeeID == employee.value.EmployeeID
  );
  return employeeIndex >= 0;
});

const editPostModal = useModal({
  component: AddPost,
  attrs: {
    mode: MConstant.FormMode.Edit,
    postID: route.params.PostID,

    onCloseModal() {
      editPostModal.close();
    },
    async onUpdatedPost() {
      await loadPost();
    },
  },
});

const sharePostModal = useModal({
  component: SharePost,
  attrs: {
    post: post.value,

    onCloseModal() {
      sharePostModal.close();
    },
  },
});

const deleteConfirmModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá bài viết",
    content:
      "Dữ liệu bài viết sẽ bị xóa khỏi hệ thống. Bạn có chắc chắn muốn xóa bài viết này?",

    onCloseModal() {
      deleteConfirmModal.close();
    },

    async onDelete() {
      deleteConfirmModal.close();
      await deletePost();
    },
  },
});

onMounted(async () => {
  await loadPost();
});

const loadPost = async () => {
  await getPost();
};

const getPost = async () => {
  let param = {
    data: {
      PostID: route.params.PostID,
    },
  };

  await store.dispatch(ModulePost + "/getPost", param);
};

const watchPost = async () => {
  let param = {
    data: {
      PostID: post.value.PostID,
      EmployeeID: employee.value.EmployeeID,
      IsWatching: !isWatchingPost.value,
    },
  };

  return await store.dispatch(ModulePost + "/watchPost", param);
};

const deletePost = async () => {
  let onSuccess = () => {
    success("Xoá bài viết thành công");
    goToPostTab("allPosts", route.params.ProjectID);
  };
  let param = {
    data: {
      PostID: route.params.PostID,
    },
    onSuccess,
  };

  let res = await store.dispatch(ModulePost + "/deletePost", param);
};

const btnWatchPost_click = async () => {
  let res = await watchPost();

  if (res) {
    await getPost();
  }
};

const btnEditPost_click = () => {
  editPostModal.open();
};

const btnDeletePost_click = () => {
  deleteConfirmModal.open();
};

const btnSharePost_click = () => {
  sharePostModal.patchOptions({
    attrs: {
      post: post.value,
    },
  });
  sharePostModal.open();
};
</script>

<template>
  <div class="post-details">
    <n-scrollbar :style="`max-height: 600px`">
      <div class="post-detail-header m-pt8">
        <div class="flex-row">
          <div class="flex-row">
            <div class="post-author-avt m-mt4 m-mr8">
              <div class="mi-32">
                <img class="round" :src="post.AuthorAvatar" />
              </div>
            </div>

            <div class="post-author-info">
              <div class="author">
                <span class="title-medium">{{ post.AuthorName }}</span>
                <span class=""> &nbsp;-&nbsp; </span>
                <span class="">&nbsp;{{ post.AuthorCode }}</span>
              </div>

              <div class="flex-row">
                <div class="update">
                  Cập nhật {{ commonFn.formatDate(post.CreatedDate) }}
                </div>

                
              </div>

              <div class="update" v-if="post.SharedByID">
                  Chia sẻ bởi: &nbsp <span class="text-link">{{ post.ShareUserName }}</span>
                </div>
            </div>
          </div>

          <div class="flex-1"></div>

          <div class="toolbar flex-row m-pr16">
            <MButtonIcon
              v-if="!isWatchingPost"
              classCustom="m-ml8"
              icon="mi-star mi-24"
              title="Lưu"
              @click="btnWatchPost_click"
            />

            <MButtonIcon
              v-if="isWatchingPost"
              classCustom="m-ml8"
              icon="mi-star-gold mi-24"
              title="Huỷ lưu"
              @click="btnWatchPost_click"
            />

            <MButtonIcon
            v-if="checkUserDisableItem(MConstant.ProjectPermissions.Post.Post_Edit_All)"
              classCustom="m-ml8"
              icon="mi-pencil-edit mi-24"
              title="Sửa"
              @click="btnEditPost_click"
            />

            <MButtonIcon
            v-if="checkUserDisableItem(MConstant.ProjectPermissions.Post.Post_Share)"
              classCustom="m-ml8"
              icon="mi-share mi-24"
              title="Chia sẻ"
              @click="btnSharePost_click"
            />

            <MButtonIcon
            v-if="checkUserDisableItem(MConstant.ProjectPermissions.Post.Post_Delete)"
              classCustom="m-ml8"
              icon="mi-delete-red mi-24"
              title="Xoá"
              @click="btnDeletePost_click"
            />
          </div>
        </div>

        <div class="m-pt8">
          <div class="text-xl">{{ post.Title }}</div>
        </div>
      </div>

      <div class="post-detail-content m-pt24">
        <div class="" v-html="post.Content"></div>
      </div>

      <div class="post-detail-footer line">
        <div class="category-section flex-row m-mb8 m-mt8">
          <div class="m-mr8">Danh mục :</div>
          <div class="text-link pointer">{{ post.PostCategoryName }}</div>
        </div>

        <div class="tag-section flex-row m-mb8">
          <div class="tag" v-for="item in post.PostTags">
            <div class="">{{ item.PostTagName }}</div>
          </div>
        </div>
      </div>

      <div class="post-comments line m-mt16">
        <n-collapse :default-expanded-names="['1']" class="m-pt16 m-pb16">
          <n-collapse-item title="Bình luận" name="1">
            <n-tabs type="line" animated class="m-tabs m-pl16">
              <n-tab-pane name="task-tab_Comment" tab="Bình luận">
                <PostCommentList />
              </n-tab-pane>
            </n-tabs>
          </n-collapse-item>
        </n-collapse>
      </div>
    </n-scrollbar>
  </div>
</template>

<style>
.post-details {
  background-color: #fff;
  margin: 16px 8px;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 8px 16px;
  height: calc(100vh - 90px);
}

.post-author-info .update {
  font-size: 13px;
  color: #555555;
}

.tag {
  border: 1px solid var(--border-button-color);
  background-color: var(--background-hover-color-1);
  border-radius: 4px;
  cursor: pointer;
  margin-right: 8px;
  padding: 4px 16px;
}

.toolbar .m-button {
  height: 40px;
}
</style>
