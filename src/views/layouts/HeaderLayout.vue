<template>
  <header>
    <div class="m-header d-flex flex-align-center">
      <div class="m-header-left">
        <div class="m-header-left-logo pointer d-flex">
          <div class="m-header-left-logo__icon mi-32">
            <img src="@/assets/logo/logo.png" title="Công việc" alt="logo" />
          </div>
          <div class="m-header-left-logo__brand">Công việc</div>
        </div>
      </div>

      <div class="flex-1"></div>

      <div class="m-header-right d-flex flex-align-center">
        <MSplitButton
          :text="'Thêm công việc'"
          :title="'Thêm công việc'"
          :classCustom="'m-button-m'"
          :leftIcon="'mi-24 mi-plus-white'"
          :options="dropdownAddTaskOptions"
          @onOptionClick="onOptionClick"
          @onClick="onClickBtn"
        />

        <div class="divider m-mr32 m-w1"></div>

        <div class="m-icon-btn mi-24 mi-search m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-notification m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-question m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-book m-mr32"></div>

        <div class="m-icon-btn mi-24 mi-show-detail m-mr32"></div>

        <n-dropdown
          trigger="click"
          :options="dropdownUserOptiops"
          :show-arrow="true"
        >
          <div class="m-icon-btn avatar m-mr8">
            <img :src="user.Avatar" />
          </div>
        </n-dropdown>
      </div>
    </div>
  </header>
</template>

<script setup>
import MSplitButton from "@/components/button/MSplitButton.vue";
import { getCurrentInstance, inject, computed, h, ref } from "vue";
import { useModal } from "vue-final-modal";
import AddTaskForm from "@/views/popup/form/AddTask.vue";
import AddProjectForm from "@/views/popup/form/AddProject.vue";
import DropdownUserInfo from "@/views/pages/common/dropdown/DropdownUserInfo.vue";
import { useStore } from "vuex";
import { ModuleUser } from "@/store/moduleConstant";

const store = useStore();
const commonFn = inject("CommonFn");

const user = computed(() => store.state[ModuleUser]?.user);
const employee = computed(() => store.state[ModuleUser]?.employee);

const renderDropdownUser = () => {
  return h(DropdownUserInfo, {
    user: {
      Avatar: user?.value.Avatar,
      FullName: employee?.value.FullName,
      Email: employee?.value.Email,
    },
  });
};

const dropdownUserOptiops = commonFn.initDropdownOptions(renderDropdownUser);

const dropdownAddTaskOptions = ref([
  {
    label: "Thêm dự án/nhóm",
    key: "AddProject",
  },
  {
    label: "Thêm phòng ban",
    key: "AddDepartment",
  },
  {
    label: "Thêm nhân viên vào phòng ban/dự án",
    key: "AddEmployee",
  },
]);

const { open, close } = useModal({
  component: AddTaskForm,
  attrs: {
    onCloseModal() {
      close();
    },
  },
});

const modalAddProject = useModal({
  component: AddProjectForm,
  attrs: {
    onCloseModal() {
      modalAddProject.close();
    },  
  },
})

const onClickBtn = (event) => {
  try {
    open();
  } catch (error) {
    console.log(error);
  }
};

const onOptionClick = (key) => {
  modalAddProject.open();
}
</script>
<style>
@import url("@/assets/style/layouts/layout-header.css");
</style>
