<script setup>
import { useStore } from "vuex";
import EmployeeCard from "@/components/cards/Employee.vue";
import { ref, reactive, h, computed, onMounted } from "vue";
import { ModuleContext, ModuleProject } from "@/store/moduleConstant";
import MButton from "@/components/button/MButton.vue";
import { useRoute } from "vue-router";
import EditRoleEmployee from "@/components/popup/form/configProject/EditRoleEmployee.vue";
import { useModal } from "vue-final-modal";
import DeleteConfirm from "@/components/popup/form/DeleteConfirm.vue";
import { useMessages } from "@/utils/uses/base/useMessages";

const store = useStore();
const route = useRoute();
const {success, error} = useMessages();
const employeeProjects = computed(() => store.state[ModuleProject]?.employees);
const employee = computed(() => store.state[ModuleContext]?.employee);
const projectID = route.params.ProjectID;
const editEmployee = ref({});
const deleteEmployeeTarget = reactive({
  Data: {}
})

const editRoleEmployeeModal = useModal({
  component: EditRoleEmployee,
  attrs: {
    employee: editEmployee,
    onCloseModal() {
      editRoleEmployeeModal.close();
    },

    async onUpdated() {
      await getEmployeeProjects();
    },
  },
});

const deleteEmployeeConfirmModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá thành viên",
    content:
      `Bạn có chắc chắn muốn xoá người dùng <b></b> khỏi dự án không?`,

    onCloseModal() {
      deleteEmployeeConfirmModal.close();
    },

    async onDelete() {
      await deleteEmployeeFromProject();
      deleteEmployeeConfirmModal.close();
    },
  },
});

const employeeColumns = ref([
  {
    title: "Họ và tên",
    key: "FullName",
    width: 200,
    render(row, index) {
      const item = {
        Avatar: row.Avatar,
        FullName: row.FullName,
      };
      return h(EmployeeCard, {
        clickable: false,
        item: item,
        class: "m-w100",
      });
    },
  },
  {
    title: "Vị trí công việc",
    key: "PositionName",
    width: 250,
    ellipsis: true,
  },
  {
    title: "Email",
    key: "Email",
    width: 300,
    ellipsis: true,
  },
  {
    title: "Vai trò",
    key: "PermissionGroupName",
    width: 100,
    ellipsis: true,
  },
  {
    title: "",
    key: "EditRow",
    width: 50,
    render(row, index) {
      let onClick = () => {
        editEmployee.value = row;
        editRoleEmployeeModal.open();
      };
      let disabled = isCurrentEmployee(row);
      return h(MButton, {
        title: "Sửa vai trò",
        onClick: onClick,
        disabled,
        classCustom: "m-button-m detail-issue-btn m-mr8",
        leftIcon: "mi-24 mi-pencil-edit",
        classText: "m-mr8",
        class: "btn-transparent",
      });
    },
  },

  {
    title: "",
    key: "DeleteRow",
    width: 50,
    render(row, index) {
      const clickDelete = () => {
        deleteEmployeeTarget.Data = row;
        deleteEmployeeConfirmModal.patchOptions({
          attrs: {
            content:
            `Bạn có chắc chắn muốn xoá người dùng <b>${row.FullName}</b> khỏi dự án không?`,
          }
        })
        deleteEmployeeConfirmModal.open();
      }
      let disabled = isCurrentEmployee(row);
      return h(MButton, {
        title: "Xoá thành viên",
        onClick: clickDelete,
        classCustom: "m-button-m detail-issue-btn m-mr8",
        disabled,
        leftIcon: "mi-24 mi-delete-close",
        classText: "m-mr8",
        class: "btn-transparent",
      });
    },
  },
]);

const isCurrentEmployee = (row) => {
  return employee.value.EmployeeID == row.EmployeeID;
}

onMounted(async () => {
  await getEmployeeProjects();
});

const getEmployeeProjects = async () => {
  let param = {
    ProjectID: projectID,
  };

  await store.dispatch(ModuleProject + "/getEmployees", param);
};

const deleteEmployeeFromProject = async () => {
  let param = {
    data: {
      EmployeeID: deleteEmployeeTarget.Data.EmployeeID,
      ProjectID: projectID
    },
    onSuccess: async () => {
      success('Xoá thành viên khỏi dự án thành công');
      await getEmployeeProjects();
    },
    onFailure: () => error('Có lỗi xảy ra')
  }

  await store.dispatch(ModuleProject + '/removeEmployee', param);
}

const btnUpdate_click = async () => {
  await getEmployeeProjects();
}
</script>

<template>
  <div class="authen-employee-tab">
    <div class="tool-bar flex-jsp">
      <div class="">
        <MIconInput
          :placeholder="'Tìm kiếm nhân viên'"
          :iconLeft="'mi-18 mi-search-before'"
          :customClass="'m-m0'"
          :inputClass="'no-border'"
          v-model="searchText"
        />
      </div>

      <div class="flex-row">
        <MButton
          text="Thêm thành viên"
          :title="'Thêm'"
          :classCustom="'m-button-m detail-issue-btn m-mr8'"
          leftIcon="mi-24 mi-plus-blue"
          :classText="'m-mr8'"
          class="btn-transparent"
        />
        <MButton
          text="Cập nhật"
          :title="'Cập nhật'"
          :classCustom="'m-button-m m-mr8'"
          leftIcon="mi-24 mi-sync"
          :classText="'m-mr8'"
          class="btn-transparent"
          @click="btnUpdate_click"
        />
      </div>
    </div>

    <div class="authen-employee-list">
      <n-data-table
        id="resizeMe"
        striped 
        class="text-medium table-2"
        :columns="employeeColumns"
        :data="employeeProjects"
        :max-height="430"
        :min-height="400"
        :single-line="false"
      />
    </div>
  </div>
</template>

<style></style>
