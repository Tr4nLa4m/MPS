<script setup>
import { ModuleIssue } from '@/store/moduleConstant';
import issue from '@/store/modules/issue';
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

const master = reactive(models.createResolveIssueParam());

onMounted(async () => {
    await getSolutions();

    bindInitMasterData();
});

const bindInitMasterData = () => {
    master.SolutionID = solutions.value[0].SolutionID;
    master.IssueID = route.params.IssueID;
}

const getSolutions = async () => {
    let param = {
        data: {
            ProjectID : route.params.ProjectID
        }
    }

    await store.dispatch(ModuleIssue + '/getSolutions', param);
}

const btnSave_click = async () => {
    let data = cloneDeep(master);

    let onFailure = () => error('Có lỗi xảy ra');

    let param = {
        data,
        onFailure
    }


    let res = await store.dispatch(ModuleIssue + '/resolveIssue', param);
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
  <VModal customClass="form-resolve-issue">
    <template #default>
      <div class="form-resolve-issue--wrapper">
        <div class="form-header line-bottom">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">Giải quyết vấn đề</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-mt16 m-pl8 m-pr8">
          <div class="">
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
          </div>

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
.form-resolve-issue--wrapper{
    width: 520px;
}
</style>
