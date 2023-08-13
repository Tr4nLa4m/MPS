<script setup>
import { ModuleIssue } from '@/store/moduleConstant';
import { onMounted } from 'vue';
import { computed } from 'vue';
import { reactive, inject } from 'vue';
import { useStore } from 'vuex';
import { useRoute } from "vue-router";
import { cloneDeep } from 'lodash';
import { useMessages } from '@/utils/uses/base/useMessages';

const store = useStore();
const route = useRoute();
const models = inject("Model");
const {error} = useMessages();
const emit = defineEmits(["closeModal", "updateIssue"]);
const solutions = computed(() => store.state[ModuleIssue].solutions);

const master = reactive({
    IssueID: null,
    Comment: ''
});

onMounted(async () => {

    bindInitMasterData();
});

const bindInitMasterData = () => {
    master.IssueID = route.params.IssueID;
}

// const getSolutions = async () => {
//     let param = {
//         data: {
//             ProjectID : route.params.ProjectID
//         }
//     }

//     await store.dispatch(ModuleIssue + '/getSolutions', param);
// }

const btnSave_click = async () => {
    let data = cloneDeep(master);

    let onFailure = () => error('Có lỗi xảy ra');

    let param = {
        data,
        onFailure
    }


    let res = await store.dispatch(ModuleIssue + '/reOpenIssue', param);
    if(res > 0){
        emit("updateIssue");
    }

    closeModal();
}

const closeModal = () => {
  emit("closeModal");
};

</script>

<template>
  <VModal customClass="form-reopen-issue">
    <template #default>
      <div class="form-reopen-issue--wrapper">
        <div class="form-header line-bottom">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">Mở lại vấn đề</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-mt16 m-pl8 m-pr8">
            <div class="m-pt16 m-pb16 text-center issue-form-info">
                <div class="text-link">Mở lại vấn đề khi vấn đề chưa được giải quyết hoàn tất hoặc chưa đạt yêu cầu</div>
            </div>

          <!-- <div class="">
            <div class="form-label m-pb4">
              Giải pháp: <span class="danger">*</span>
            </div>
            <n-select
              class="m-select"
              v-model:value="master.SolutionID"
              :options="solutions"
              label-field="SolutionName"
              value-field="SolutionID"
              placeholder="Chọn giải pháp"
            />
          </div> -->

          <div class="m-mt8">
            <div class="form-label m-pb4">Bình luận:</div>
            <n-input
              v-model:value="master.Comment"
              type="textarea"
              placeholder="Bình luận"
              rows="6"
              ref="commentInputEl"
            />
          </div>
        </div>

        <div class="form-footer">
          <div class="flex-row-end flex-align-center">
            <MButton
              :text="'Lưu'"
              :title="'Lưu'"
              :classCustom="'m-button-m detail-issue-btn m-mr16'"
              :classText="'m-mr8 m-ml8'"
              @click="btnSave_click"
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
.form-reopen-issue--wrapper{
    width: 620px;
}

.issue-form-info{
    background-color: var(--background-comment);
}
</style>
