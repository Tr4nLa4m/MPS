<script setup>
import { inject, computed, ref, reactive, onMounted } from 'vue';
import { useStore } from 'vuex';
import {
  ModuleProject,
  ModuleContext,
  ModulePost,
} from "@/store/moduleConstant";
import MConstant, { DEPARTMENT_KEY_PREFIX, GUID_EMPTY } from "@/common/consts/MConstant";
import Editor from "@tinymce/tinymce-vue";
import { cloneDeep, some } from 'lodash';
import { useMessages } from '@/utils/uses/base/useMessages';

const store = useStore();
const models = inject("Model");
const commonFn = inject("CommonFn");
const emit = defineEmits(["closeModal", "updatedPost"]);
const {success, error} = useMessages();
const employee = computed(() => store.state[ModuleContext]?.employee);
const tags = computed(() => store.state[ModulePost].tags);
const categories = computed(() => store.state[ModulePost].categories);
const currentPost = computed(() => store.state[ModulePost].post);

const departmentProjects = computed(() => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  return rawDepartmentProjects?.map((item) => {
    return {
      ...item,
      ProjectID: DEPARTMENT_KEY_PREFIX + item.DepartmentID,
      ProjectName: item.DepartmentName,
      disabled: true,
    };
  });
});
const tinymceInit = {
  plugins: ["preview", "importcss", "autolink", "image", "media", "table", "charmap", "anchor", "link", "lists", "autoresize"], // Add any other plugins you want to use
  toolbar:
    "bold italic underline fontsize forecolor backcolor alignleft aligncenter alignright alignfull lineheight bullist numlist  ", // Customize the toolbar buttons
  // Add any other initialization options you need
  line_height_formats: "1 1.2 1.4 1.6 1.8 2",
  statusbar: false,
  menubar: 'file edit view insert format tools table',
  height: 350,
  min_height: 250,
  toolbar_sticky: true,
  content_style: "body { background-color: #ffffff; }" + "p {margin-block-start: 4px;margin-block-end: 4px;}",
  font_family_formats: "'GoogleSans-Regular',Roboto, Helvetica, Arial, sans-serif",
  auto_focus: true,
  importcss_append: true,
  toolbar_mode: 'sliding',
  noneditable_class: 'mceNonEditable',
  setup: (editor) => {
  },
};
const props = defineProps({
  mode: {
    type: Number,
    default: MConstant.FormMode.Add,
  },
  postID: {
    type: String,
    default: null,
  },
});

const isEditMode = () => {
  return props.mode == MConstant.FormMode.Edit;
}

const formConfig = reactive({
  Title: isEditMode() ? "Sửa bài viết" : "Thêm bài viết",
});

const master = reactive({
  Data: models.createAddPostParam()
});

const getDefaultDepartmentProject = () => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  for (let index = 0; index < rawDepartmentProjects.length; index++) {
    const project = rawDepartmentProjects[index];
    if (project.Projects?.length > 0) {
      return project.Projects[0].ProjectID;
    }
  }
  return "";
};

//#region Lifecycle hooks
onMounted(async () => {
  await getProjects();

  await bindInitMasterData();
});

const getProjects = async () => {
  // lấy danh sách các dự án
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);
};

const bindInitMasterData = async () => {
    if(isEditMode()){
      await getPost();
      bindCurrentPostData();
    }

    if(!isEditMode()){
      master.Data.ProjectID = getDefaultDepartmentProject();
    }
    await getCategories();
    await getTags();
}

const bindCurrentPostData = () => {
  let post = cloneDeep(currentPost.value);
  master.Data = post;
  master.Data.Tags = post.PostTags.map((tag) => tag.PostTagID);
}

const getCategories = async () => {
    let param = {
        data: {
            ProjectID: master.Data.ProjectID
        }
    }
    let res = await store.dispatch(ModulePost + '/getCategoriesByProject', param);
    console.log(res);
}

const getTags = async () => {
    let param = {
        data: {
            ProjectID: master.Data.ProjectID
        }
    }
    await store.dispatch(ModulePost + '/getTagsByProject', param);
}

const getPost = async () => {
  let param = {
    data: {
      PostID: props.postID,
    },
  };
  await store.dispatch(ModulePost + "/getPost", param);
}

const selectProject_change = async () => {
    master.Data.PostCategoryID = null;
    await getCategories();
    await getTags();
}

const btnSave_click = async () => {
    let data = cloneDeep(master.Data);
    let action = "/insertPost";
    let onSuccess = () => success('Thêm mới bài viết thành công');
    let onFailure = () => error('Có lỗi xảy ra khi thêm mới bài viết');

    if(isEditMode()){
      action = '/updatePostV2'; 
      onSuccess = () => {
        success('Sửa bài viết thành công');
        emit("updatedPost");
      }
    }
    if(!data.PostCategoryID){
        data.PostCategoryID = GUID_EMPTY;
    }

    if(!isEditMode()){
      data.AuthorID = employee.value.EmployeeID;
    }
    
    let param = {
        data,
        onSuccess,
        onFailure
    }

    await store.dispatch(ModulePost + action, param);

    closeModal();
}

const closeModal = () => {
  emit("closeModal");
};

</script>

<template>
  <VModal customClass="form-post">
    <template #default>
      <div class="form-post--wrapper">
        <div class="form-header line-bottom m-pb8">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">{{ formConfig.Title }}</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <n-scrollbar trigger="hover" style="max-height: 520px">
          <div class="form-body">
            <div class="m-mt8">
              <div class="form-label m-pb4">
                Tiêu đề: <span class="danger">*</span>
              </div>
              <MInput
              v-model="master.Data.Title"
                :placeholder="'Tiêu đề bài viết'"
                :customClass="'m-m0 input-xl text-large'"
                inputClass="m-pl16 m-pr16"
              />
            </div>

            <div class="flex-row m-pb8">
              <div class="flex-1 m-mr8">
                <div class="form-label m-pb4">
                  Chọn dự án: <span class="danger">*</span>
                </div>
                <MTreeSelect
                  :data="departmentProjects"
                  v-model="master.Data.ProjectID"
                  class="m-select"
                  label-field="ProjectName"
                  key-field="ProjectID"
                  children-field="Projects"
                  placeholder="Dự án"
                  :isExpandAll="true"
                  :enableChange="true"
                  :disabled="isEditMode()"
                  @onChange="selectProject_change"
                />
              </div>

              <div class="flex-1 m-ml8">
                <div class="form-label m-pb4">
                  Chọn danh mục: <span class="danger">*</span>
                </div>
                <n-select
                  class="m-select"
                  :options="categories"
                  v-model:value="master.Data.PostCategoryID"
                  label-field="CategoryName"
                  value-field="PostCategoryID"
                  placeholder="Chọn danh mục"
                />
              </div>
            </div>

            <div class="m-pb8">
              <div class="form-label m-pb4">Thẻ:</div>
              <MTreeSelect
                :data="tags"
                class="m-select"
                v-model="master.Data.Tags"
                multiple 
                label-field="PostTagName"
                key-field="PostTagID"
                placeholder="Thẻ"
              />
            </div>

            <div class="">
              <div class="form-label m-pb4">Nội dung:</div>
              <Editor
                api-key="9038dr0d32vvyxk56tg57fbo4w5hgp16g574iyezusedlm3f"
                v-model="master.Data.Content"
                :init="tinymceInit"
              />
            </div>
          </div>
        </n-scrollbar>

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
                text="Lưu"
                class="m-button-l m-pl16 m-pr16 radius-8"
                @click="btnSave_click"
              />
            </div>
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>

.form-post--wrapper{
    width: calc(100vw - 126px);
}

.form-post--wrapper .form-body{
    padding: 0 8px;
}

</style>
