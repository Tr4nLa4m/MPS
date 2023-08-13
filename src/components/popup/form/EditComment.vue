<script setup>
import { ref } from 'vue';
import { onMounted } from 'vue';
import { inject } from 'vue';
import { useStore } from 'vuex';
import { cloneDeep } from "lodash"
import { ModuleIssue } from '@/store/moduleConstant';
import { useMessages } from '@/utils/uses/base/useMessages';


const props = defineProps({
    comment: {}
});

const store = useStore();
const models = inject("Model");
const commonFn = inject("CommonFn");
const {error, success} = useMessages();
const emit = defineEmits(["closeModal", "updatedComment"]);
const commentText = ref('');

onMounted(() => {
    commentText.value = props.comment.Content || '';
});

const btnSaveComment_click = async () => {
    let param = cloneDeep(props.comment);
    param.Content = commentText.value;
    const onSuccess = () => success('Cập nhật bình luận thành công');
    const onFailure = () => error('Có lỗi xảy ra')
    let res = await store.dispatch(ModuleIssue + '/updateComment', {data : param, onSuccess, onFailure});
    if(res){
        emit("updatedComment");
    }

    closeModal();
}

const closeModal = () => {
  emit("closeModal");
};
</script>

<template>
  <VModal customClass="form-edit-issue-comment">
    <template #default>
      <div class="form-edit-comment--wrapper">
        <div class="form-header line-bottom">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">Sửa bình luận</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-mt16 m-pl24">
            <div class="flex-row m-mb8">
                <div class="label">Tác giả</div>
                <div class="text-bold text-primary">{{ comment.FullName }}</div>
            </div>

            <div class="flex-row m-mb8">
                <div class="label">Ngày tạo</div>
                <div class="">{{ commonFn.formatDate(comment.CreatedDate) }}</div>
            </div>

            <div class="flex-row m-mb8">
                <div class="label">Bình luận</div>
                <div class="m-w100 m-pl12">
                    <n-input
                    v-model:value="commentText"
                    type="textarea"
                    placeholder="Bình luận"
                    rows="6"
                    ref="commentInputEl"
                  />
                </div>
            </div>
        </div>

        <div class="form-footer">
          <div class="flex-row-end flex-align-center">
            <MButton
              :text="'Lưu'"
              :title="'Lưu bình luận'"
              :classCustom="'m-button-m detail-issue-btn m-mr16'"
              :classText="'m-mr8 m-ml8'"
              @click="btnSaveComment_click"
            />

            <div class="" @click="closeModal">
              <div class="text-link-v3">Huỷ</div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>

.form-edit-comment--wrapper{
    width: 680px;
}

.form-edit-comment--wrapper .label{
    width: 100px;
}

</style>
