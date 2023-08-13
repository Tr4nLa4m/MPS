<script setup>
const props = defineProps({
  title: String,

  content: String,
});

const emit = defineEmits(["closeModal", "Delete"]);

const closeModal = (e) => {
  emit("closeModal");
};

const btnDelete_click = () => {
  emit("delete");
};
</script>

<template>
  <VModal customClass="form-confirm-delete">
    <template #default>
      <div class="form-confirm-delete--wrapper">
        <div class="form-header m-pb16 m-pl8 m-pr8">
          <div class="flex-row flex-jsp">
            <div class="text-xl">{{ props.title }}</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-pl8 m-pr8">
          <div class="m-pt8 m-pb8" v-html="props.content">
          </div>
        </div>

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
                text="Xoá"
                class="m-button-l m-pl16 m-pr16 radius-8 btn-danger"
                @click="btnDelete_click"
              />
            </div>
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>
.form-confirm-delete--wrapper {
  width: 450px;
}
</style>
