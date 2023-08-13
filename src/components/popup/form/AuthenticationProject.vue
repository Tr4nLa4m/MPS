<script setup>
import EmployeeTab from "@/components/tabDetail/authenticationProject/EmployeeTab.vue";
import RoleTab from "@/components/tabDetail/authenticationProject/RoleTab.vue";
import { ModuleProject } from "@/store/moduleConstant";
import { computed } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";

const store = useStore();
const route = useRoute();
const emits = defineEmits(["closeModal"]);

const project = computed(() => store.state[ModuleProject]?.project);

const closeModal = () => {
  emits("closeModal");
};
</script>

<template>
  <VModal customClass="form-config-project">
    <template #default>
      <div class="form-config-project--wrapper">
        <div class="form-header m-pb16 m-pl8 m-pr8">
          <div class="flex-row flex-jsp">
            <div class="text-xl">Phân quyền</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body">
          <div class="tabs m-pl8 m-pr8">
            <n-tabs type="line" animated class="m-tabs">
              <n-tab-pane name="EmployeeTab" tab="Nhân viên">
                <EmployeeTab></EmployeeTab
              ></n-tab-pane>
              <n-tab-pane name="RoleTab" tab="Vai trò">
                <RoleTab></RoleTab>
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
  width: 1150px;
}
</style>
