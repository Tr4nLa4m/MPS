<script>
import { defineComponent, h, ref, computed, reactive, nextTick } from "vue";
import Editor from "@tinymce/tinymce-vue";
import { NInput, useMessage } from "naive-ui";
import SearchList from "@/components/SearchList.vue";
import { useModal } from "vue-final-modal";
import FilterEmployeeForm from "@/views/popup/form/FilterEmployee.vue";
function renderCustomHeader1() {
  return h(
    "div",
    {
      style: "display: flex; align-items: center; padding: 8px 12px;",
    },
    [h(SearchList, {})]
  );
}
export default defineComponent({
  name: "AddTaskForm",
  props: {},
  components: { Editor },
  setup(props, { emit }) {
    const options = [
      {
        label: "Cá nhân",
        key: "Cá nhân",
        disabled: true,
        children: [
          {
            label: "Dự án cá nhân",
            key: "Dự án cá nhân",
          },
          {
            label: "Công việc cá nhân",
            key: "Công việc cá nhân",
          },
        ],
      },
      {
        label: "Dự án Internal",
        key: "Dự án Internal",
        disabled: true,
        children: [
          {
            label: "Internal_1",
            key: "Internal_1",
          },
        ],
      },
    ];

    const filterEmployeeModal = useModal({
      component: FilterEmployeeForm,
      attrs: {
        onCloseModal() {
          filterEmployeeModal.close();
        },
      },
    });

    const btnChooseEmployee_click = (e) => {
      filterEmployeeModal.open();
    };

    const message = useMessage();
    const tinymceInit = {
      plugins: ["autolink", "link", "image", "lists"], // Add any other plugins you want to use
      toolbar:
        "bold italic underline fontsize forecolor backcolor alignleft aligncenter alignright alignfull bullist numlist  | customInsertButton ", // Customize the toolbar buttons
      // Add any other initialization options you need
      statusbar: false,
      menubar: false,
      height: 120,
      content_style: "body { background-color: #f5f5f5; }",
      auto_focus: true,
      setup: (editor) => {
        editor.ui.registry.addButton("customInsertButton", {
          text: "My Button",
          onAction: (_) => {
            const localizedContent = editor.getContent({ format: "text" });
            message.info("Localized content: " + localizedContent);
          },
        });
      },
      init_instance_callback: function (editor) {
        editor.on("blur", function () {
          if (!content.value) {
            showEl.editor = false;
            showEl.btnDescription = true;
          }
        });
      },
    };

    const dropdownSearchEmployee = [
      {
        key: "header",
        type: "render",
        render: renderCustomHeader1,
      },
      {
        key: "header-divider",
        type: "divider",
      },
      {
        label: "Brown's Hotel, London",
        key: "Brown's Hotel, London",
      },
      {
        label: "Atlantis Bahamas, Nassau",
        key: "Atlantis Bahamas, Nassau",
      },
    ];

    const showEl = reactive({
      btnDescription: true,
      btnCheckList: true,
      editor: false,
      checklist: false,
    });

    const closeModal = (e) => {
      emit("closeModal");
    };

    const checklists = ref([]);

    const subtasks = ref([
      {
        id: "adadad",
        text: "Chọn",
      },
    ]);

    const btnAddCheckList_click = () => {
      if (!showEl.checklist) {
        showEl.checklist = true;
      }
      checklists.value.push({ text: "" });
    };

    const btnDeleteCheckList_click = (index) => {
      checklists.value.splice(index, 1);
      if (checklists.value.length === 0) {
        showEl.checklist = false;
      }
    };

    const onClickAway = (e) => {
      const newChecklist = checklists.value.filter(
        (item) => item.text.length > 0
      );

      checklists.value = newChecklist;

      if (checklists.value.length == 0) {
        showEl.checklist = false;
      }
    };

    const clickExpandEditor = () => {
      showEl.editor = true;
      showEl.btnDescription = false;
    };

    const content = ref("");

    const options1 = [
      {
        label: "Cần thực hiện",
        key: "Cần thực hiện",
      },
      {
        label: "Đang thực hiện",
        key: "Đang thực hiện",
      },
    ];
    const handleUpdateValue = (value, option) => {
      console.log(value, option);
    };

    return {
      options,
      options1,
      handleUpdateValue,
      content,
      tinymceInit,
      clickExpandEditor,
      showEl,
      onClickAway,
      checklists,
      subtasks,
      btnAddCheckList_click,
      btnDeleteCheckList_click,
      closeModal,
      dropdownSearchEmployee,
      btnChooseEmployee_click,
    };
  },
});
</script>

<template>
  <VModal customClass="form-task">
    <template #default>
      <div class="form-task--wrapper">
        <!-- Header form -->
        <div class="form-header flex-row-end m-pt8 m-pb16">
          <MButtonIcon
            classCustom="m-ml8 m-p4"
            icon="mi-sub-task"
            title="Công việc con"
          />

          <MButtonIcon
            classCustom="m-ml8 m-p4"
            icon="mi-attachment"
            title="Tài liệu"
          />

          <MButtonIcon
            classCustom="m-ml8 m-p4"
            icon="mi-label"
            title="Gắn thẻ"
          />

          <MButtonIcon
            classCustom="m-ml8 m-p8"
            icon="mi-close mi-16"
            title="Đóng"
            @click="closeModal"
          />
        </div>

        <!-- Body form -->
        <div class="form-body line">
          <div class="header-task m-mb18">
            <div class="row">
              <div class="form-label m-pl12">Dự án:</div>
              <n-tree-select
                :options="options"
                class="project"
                default-value="Công việc cá nhân"
                @update:value="handleUpdateValue"
              >
              </n-tree-select>
            </div>

            <div class="row">
              <div class="form-label m-pl12">Nhóm công việc:</div>
              <n-tree-select
                :options="options1"
                class="project"
                :default-value="options1[0].label"
                @update:value="handleUpdateValue"
              >
              </n-tree-select>
            </div>
          </div>

          <div class="task-name">
            <MInput
              placeholder="Nhập tên công việc"
              customClass="text-large"
              :border="false"
            />
          </div>

          <div class="flex-jsp flex-align-center m-mt16 m-mb16">
            <MButton
              text="Chọn người thực hiện"
              leftIcon="mi-question-circle"
              classCustom="btn-custom-1 text-medium m-mr16 m-w100"
              @click="btnChooseEmployee_click"
            />

            <n-dropdown trigger="click" :options="dropdownSearchEmployee" :show-arrow="true">
              <MButton
                text="Chọn hạn hoàn thành"
                leftIcon="mi-calender-circle "
                classCustom="btn-custom-1 text-medium m-w100"
              />
            </n-dropdown>
          </div>

          <div class="task-description">
            <MButton
              v-if="showEl.btnDescription"
              leftIcon="mi-add-description mi-16 m-ml4 m-mr4"
              text="Nhập mô tả"
              classCustom="btn-expand text-link m-button-m"
              @click="clickExpandEditor"
            />

            <div v-if="showEl.editor" class="">
              <div class="flex-row flex-align-center m-mb8">
                <div class="mi-24 mi-description-v2 m-mr8"></div>
                <div class="title-medium">Mô tả</div>
              </div>
              <Editor
                api-key="9038dr0d32vvyxk56tg57fbo4w5hgp16g574iyezusedlm3f"
                v-model="content"
                :init="tinymceInit"
                :value="content"
              />
            </div>
          </div>

          <div class="task-checklist" v-click-away="onClickAway">
            <div v-if="showEl.checklist" class="">
              <div class="flex-row flex-align-center m-mb8">
                <div class="mi-24 mi-checklist-v2 m-mr8"></div>
                <div class="title-medium">Checklist</div>
              </div>

              <div class="">
                <div v-for="(item, index) in checklists" class="checklist-item">
                  <div class="prefix">{{ `${index + 1}. ` }}</div>
                  <input v-model="item.text" class="checklist-item-text" />
                  <div class="">
                    <MButtonIcon
                      icon="mi-delete-red mi-24"
                      title="Xoá"
                      @click="btnDeleteCheckList_click(index)"
                    />
                  </div>
                </div>
              </div>
            </div>

            <MButton
              v-if="showEl.btnCheckList"
              leftIcon="mi-plus-blue"
              text="Thêm checklist"
              classCustom="btn-expand text-link m-button-m m-mt8"
              @click="btnAddCheckList_click"
            />
          </div>

          <div class="task-subtask m-pb8">
            <div class="">
              <div class="flex-row flex-align-center m-mb8">
                <div class="mi-24 mi-subtask-v2 m-mr8"></div>
                <div class="title-medium">Công việc con</div>
              </div>

              <div class="subtask-list">
                <div class="line"></div>
                <div
                  v-for="(item, index) in subtasks"
                  class="subtask-item flex-row flex-align-center"
                >
                  <input
                    v-model="item.text"
                    class="subtask-item-text text-input-m"
                  />
                  <div class="flex-row">
                    <MButtonIcon
                      icon="mi-relevant-circle-dash mi-24"
                      title="Người thực hiện"
                      @click=""
                    />

                    <MButtonIcon
                      icon="mi-calendar-circle-dash mi-24"
                      title="Hạn hoàn thành"
                      @click=""
                    />
                  </div>
                </div>
              </div>
            </div>

            <MButton
              v-if="showEl.btnCheckList"
              leftIcon="mi-plus-blue"
              text="Thêm công việc con"
              classCustom="btn-expand text-link m-button-m m-mt8 "
              @click=""
            />
          </div>
        </div>

        <div class="form-footer line">
          <div class="flex-row-end">
            <div class="m-mr8">
              <MButton
                text="Huỷ bỏ"
                class="m-button-l m-pl16 m-pr16 btn-transparent radius-8"
              />
            </div>
            <div class="">
              <MButton text="Lưu" class="m-button-l m-pl16 m-pr16 radius-8" />
            </div>
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>
@import "@/assets/style/base.css";
.form-task--wrapper {
  min-width: 840px;
}

.form-task--wrapper .form-header .m-button.m-btn-primary {
  width: unset !important;
}

.form-header {
}
.form-body {
}

.form-body .header-task {
  padding-top: 16px;
  display: flex;
}

.form-body .header-task .form-label {
  font-size: 14px;
  font-weight: 600;
}

.form-body .btn-custom-1 {
  background-color: #f5f5f5 !important;
  border-radius: 8px !important;
  overflow: hidden;
  height: 73px;
  padding: 0 8px;
}

.form-body .btn-expand {
  width: fit-content !important;
  background-color: transparent !important;
}

.form-body .task-checklist .checklist-item {
  display: flex;
  align-items: center;
  padding: 4px 8px;
}

.checklist-item:hover,
.checklist-item:focus-within,
.checklist-item:hover input,
.checklist-item:focus-within input {
  background-color: #f5f5f5;
}

.checklist-item .checklist-item-text,
.subtask-item .subtask-item-text {
  width: 100%;
  text-overflow: ellipsis;
}

.form-body .task-subtask .subtask-item {
  padding: 12px 16px;
  border-bottom: 1px solid var(--surface-300);
}

.form-footer {
  padding: 16px;
}

.header-task .row {
  min-width: 200px;
  max-width: 320px;
}

.project .n-base-selection {
  --n-border: 0px !important;
  --n-border-active: 0px !important;
  --n-border-focus: 0px !important;
  --n-border-hover: 0px !important;
  --n-font-size: 16px !important;
  --n-box-shadow-active: 0 2px 15px rgba(42, 126, 252, 0.25) !important;
  --n-box-shadow-focus: 0 2px 15px rgba(42, 126, 252, 0.25) !important;
}

.project.n-tree-select {
  width: unset !important;
}

.n-tree .n-tree-node-wrapper {
  padding: 0 !important;
}

.n-tree .n-tree-node {
  padding: 8px 0 !important;
}


</style>
