<script setup>
import GeneralTab from "@/views/popup/bodyForm/configProject/General.vue";
</script>

<template>
  <VModal customClass="form-config-project">
    <template #default>
      <div class="form-config-project--wrapper">
        <div class="form-header m-pb16 m-pl8 m-pr8">
          <div class="flex-row flex-jsp">
            <div class="text-xl">Thiết lập</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body">
          <div class="tabs">
            <n-tabs type="line" animated class="m-tabs">
              <n-tab-pane name="Chung" tab="general"> <GeneralTab /> </n-tab-pane>
              <n-tab-pane name="the beatles" tab="the Beatles">
                Hey Jude
              </n-tab-pane>
              <n-tab-pane name="jay chou" tab="Jay Chou">
                Qilixiang
              </n-tab-pane>
            </n-tabs>
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>
.form-config-project--wrapper {
  width: 950px;
}
</style>
