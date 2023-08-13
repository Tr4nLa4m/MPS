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
import MConstant, { GUID_EMPTY } from "@/common/consts/MConstant";
import RoleForm from "@/components/popup/form/configProject/RoleForm.vue";

const store = useStore();
const route = useRoute();
const { success, error } = useMessages();
const employee = computed(() => store.state[ModuleContext]?.employee);
const projectID = route.params.ProjectID;
const roles = computed(() => store.state[ModuleProject]?.roles);
const deleteRoleTarget = reactive({
  Data: {},
});

const editRoleModal = useModal({
  component: RoleForm,
  attrs: {
    mode: null,
    role: null,
    permissions: [],
    roleProjects: roles.value,
    onCloseModal() {
      editRoleModal.close();
    },

    async onUpdated() {
      await getRoleProjects();
    },
  },
});

const deleteRoleConfirmModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá vai trò",
    content: `Bạn có chắc chắn muốn xoá vai trò <b></b> khỏi dự án không?`,

    onCloseModal() {
      deleteRoleConfirmModal.close();
    },

    async onDelete() {
      let isUsingRole = await checkRoleInUse();
      if (isUsingRole) {
        error("Không thể xoá vai trò đang được sử dụng");
        deleteRoleConfirmModal.close();
        return;
      }
      await deleteRoleProject();
      deleteRoleConfirmModal.close();
    },
  },
});

const roleColumns = ref([
  {
    title: "Tên vai trò",
    key: "PermissionGroupName",
    width: 120,
    render(row, index) {
      let onClick = async () => {
        let permissions = await getProjectRolePermissions(
          row.PermissionGroupID
        );
        editRoleModal.patchOptions({
          attrs: {
            mode: MConstant.FormMode.Watch,
            role: row,
            permissions,
          },
        });
        editRoleModal.open();
      };
      return h("div", { class: "pointer", onClick, title: "Xem chi tiết" }, [
        row.PermissionGroupName,
      ]);
    },
  },
  {
    title: "Mô tả",
    key: "Description",
    width: 380,
    ellipsis: true,
  },
  {
    title: "",
    key: "EditRow",
    width: 50,
    render(row, index) {
      let onClick = async () => {
        let permissions = await getProjectRolePermissions(
          row.PermissionGroupID
        );
        editRoleModal.patchOptions({
          attrs: {
            mode: MConstant.FormMode.Edit,
            role: row,
            permissions,
            roleProjects: roles.value,
          },
        });
        editRoleModal.open();
      };
      let disabled = isInitRole(row);
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
        deleteRoleTarget.Data = row;
        deleteRoleConfirmModal.patchOptions({
          attrs: {
            content: `Bạn có chắc chắn muốn xoá vai trò <b>${row.PermissionGroupName}</b> khỏi dự án không?`,
          },
        });
        deleteRoleConfirmModal.open();
      };
      let disabled = isInitRole(row);
      return h(MButton, {
        title: "Xoá vai trò",
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

const isInitRole = (row) => {
  return row.ProjectID == GUID_EMPTY;
};

onMounted(async () => {
  await getRoleProjects();
});

const getRoleProjects = async () => {
  let param = {
    data: {
      ProjectID: projectID,
    },
  };

  await store.dispatch(ModuleProject + "/getProjectRoles", param);
};

const deleteRoleProject = async () => {
  let param = {
    data: {
      PermissionGroupID: deleteRoleTarget.Data.PermissionGroupID,
      ProjectID: projectID,
    },
    onSuccess: async () => {
      success("Xoá vai trò khỏi dự án thành công");
      await getRoleProjects();
    },
    onFailure: () => error("Có lỗi xảy ra"),
  };

  await store.dispatch(ModuleProject + "/deleteProjectRole", param);
};

const getProjectRolePermissions = async (permissionGroupID) => {
  let param = {
    data: {
      PermissionGroupID: permissionGroupID,
    },
  };

  return await store.dispatch(
    ModuleProject + "/getProjectRolePermissions",
    param
  );
};

const checkRoleInUse = async () => {
  let param = {
    data: {
      ProjectID: projectID,
      PermissionGroupID: deleteRoleTarget.Data.PermissionGroupID,
    },
  };

  return await store.dispatch(ModuleProject + "/checkProjectRoleInUse", param);
};

const btnAddRole_click = async () => {
  editRoleModal.patchOptions({
    attrs: {
      mode: MConstant.FormMode.Add,
      role: null,
      permissions: [],
      roleProjects: roles.value,
    },
  });
  editRoleModal.open();
};

const btnUpdate_click = async () => {
  await getRoleProjects();
};
</script>

<template>
  <div class="authen-role-tab">
    <div class="tool-bar">
      <div class="flex-jsp m-pb8">
        <MButton
          text="Thêm vai trò"
          :title="'Thêm vai trò'"
          :classCustom="'m-button-m detail-issue-btn m-mr8'"
          leftIcon="mi-24 mi-plus-blue"
          :classText="'m-mr8'"
          class="btn-transparent"
          @click="btnAddRole_click"
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
        :columns="roleColumns"
        :data="roles"
        :max-height="430"
        :min-height="400"
        :single-line="false"
      />
    </div>
  </div>
</template>

<style></style>
