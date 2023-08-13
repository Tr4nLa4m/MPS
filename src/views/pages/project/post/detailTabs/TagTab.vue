<script setup>
import { useStore } from "vuex";
import { ref, reactive, h, computed, onMounted } from "vue";
import { ModuleContext, ModulePost } from "@/store/moduleConstant";
import MButton from "@/components/button/MButton.vue";
import { useRoute } from "vue-router";
import { useModal } from "vue-final-modal";
import DeleteConfirm from "@/components/popup/form/DeleteConfirm.vue";
import { useMessages } from "@/utils/uses/base/useMessages";
import FormCategory from "@/components/popup/form/post/FormCategory.vue";
import MConstant from "@/common/consts/MConstant";

const store = useStore();
const route = useRoute();
const {success, error} = useMessages();
const employee = computed(() => store.state[ModuleContext]?.employee);
const projectID = route.params.ProjectID;
const editEmployee = ref({});
const deleteEmployeeTarget = reactive({
  Data: {}
})

const categoryModal = useModal({
  component: FormCategory,
  attrs: {
    mode: MConstant.FormMode.Add,
    onCloseModal() {
        categoryModal.close();
    },

    async onUpdated() {
      await getCategories();
    },
  },
});

const btnAddCategory_click = () => {
    categoryModal.open();
}

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

const categoryColumns = ref([
  {
    title: "Tên danh mục",
    key: "PostCategoryName",
    width: 200,
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
    await getCategories();
});

const getCategories = async () => {
  let param = {
    data: {
      ProjectID: route.params.ProjectID,
    },
  };
  let res = await store.dispatch(ModulePost + "/getCategoriesByProject", param);
};

const btnUpdate_click = async () => {
  await getCategories();
}
</script>

<template>
  <div class="authen-employee-tab">
    <div class="tool-bar flex-jsp">
      <div class="">
      </div>

      <div class="flex-row">
        <MButton
          text="Thêm danh mục"
          :title="'Thêm'"
          :classCustom="'m-button-m detail-issue-btn m-mr8'"
          leftIcon="mi-24 mi-plus-blue"
          :classText="'m-mr8'"
          class="btn-transparent"
          @click="btnAddCategory_click"
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
        :columns="categoryColumns"
        :data="employeeProjects"
        :max-height="430"
        :min-height="400"
        :single-line="false"
      />
    </div>
  </div>
</template>

<style></style>
