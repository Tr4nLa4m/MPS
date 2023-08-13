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
import MConstant, { GUID_EMPTY } from "@/common/consts/MConstant";

const store = useStore();
const route = useRoute();
const { success, error } = useMessages();
const employee = computed(() => store.state[ModuleContext]?.employee);
const categories = computed(() => store.state[ModulePost].categories);
const projectID = route.params.ProjectID;
const editEmployee = ref({});
const deleteCategoryTarget = reactive({
  Data: {},
});

const categoryModal = useModal({
  component: FormCategory,
  attrs: {
    mode: MConstant.FormMode.Add,
    category: {},
    onCloseModal() {
      categoryModal.close();
    },

    async onUpdated() {
      await getCategories();
    },
  },
});

const btnAddCategory_click = () => {
  categoryModal.patchOptions({
    attrs: {
      mode: MConstant.FormMode.Add,
    },
  });
  categoryModal.open();
};

const deleteConfirmModal = useModal({
  component: DeleteConfirm,
  attrs: {
    title: "Xoá danh mục",
    content: `Bạn có chắc chắn muốn xoá danh mục <b></b> khỏi dự án không?`,

    onCloseModal() {
        deleteConfirmModal.close();
    },

    async onDelete() {
      await deleteCategory();
      deleteConfirmModal.close();
    },
  },
});

const categoryColumns = ref([
  {
    title: "Tên danh mục",
    key: "CategoryName",
    width: 200,
  },
  {
    title: "",
    key: "EditRow",
    width: 50,
    render(row, index) {
      let onClick = () => {
        categoryModal.patchOptions({
          attrs: {
            mode: MConstant.FormMode.Edit,
            category: row,
          },
        });
        categoryModal.open();
      };
      let disabled = isInitCategory(row);
      return h(MButton, {
        title: "Sửa danh mục",
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
        deleteCategoryTarget.Data = row;
        deleteConfirmModal.patchOptions({
          attrs: {
            content: `Bạn có chắc chắn muốn xoá danh mục <b>${row.CategoryName}</b> khỏi dự án không?`,
          },
        });
        deleteConfirmModal.open();
      };
      let disabled = isInitCategory(row);
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

const deleteCategory = async () => {
    let param = {
        data: {
            PostCategoryID: deleteCategoryTarget.Data.PostCategoryID
        },
        onSuccess: async () => {
            success('Xoá danh mục thành công');
            await getCategories();
        },
        onFailure: () => error('Có lỗi xảy ra')
    }

    await store.dispatch(ModulePost + '/deleteCategory', param);
}

const isInitCategory = (row) => {
  return row.ProjectID == GUID_EMPTY;
};

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
};
</script>

<template>
  <div class="authen-employee-tab">
    <div class="tool-bar flex-jsp">
      <div class=""></div>

      <div class="flex-row m-mb8">
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
        :data="categories"
        :max-height="430"
        :min-height="400"
        :single-line="false"
      />
    </div>
  </div>
</template>

<style></style>
