<script setup>
import MConstant, { PERMISSION_KEY_PREFIX } from "@/common/consts/MConstant";
import { ModuleContext, ModuleProject } from "@/store/moduleConstant";
import { useMessages } from "@/utils/uses/base/useMessages";
import { includes, cloneDeep } from "lodash";
import models from "@/utils/helper/models";
import { onMounted, ref, watch } from "vue";
import { reactive } from "vue";
import { computed } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import commonFn from "@/utils/helper/commonFn";

const store = useStore();
const route = useRoute();
const ACTION_CHECK = "check",
  ACTION_UNCHECK = "uncheck";
const emits = defineEmits(["closeModal", "updated"]);
const { success, warning, error } = useMessages();
const props = defineProps({
  mode: {
    type: String,
    default: MConstant.FormMode.Add,
  },
  role: {
    type: Object,
    default: {},
  },
  permissions: {
    type: Array,
    default: [],
  },

  roleProjects: {
    type: Array,
    default: [],
  },
});
const master = reactive({
  Data: models.createAddProjectRoleParam(),
});

const formConfig = ref({
  title: "Thêm vai trò",
});

const tfPermissionGroupName = ref(null);

const projectPermissons = computed(
  () => store.getters[ModuleProject + "/roleProjects"]
);

const getRoleData = computed(() => (component) => {
  if (projectPermissons.value.length == 0) {
    return [];
  }
  let taskPermissions = projectPermissons.value.find(
    (roleGroup) => roleGroup.Component == component
  );
  if (!taskPermissions) {
    return [];
  }

  return [taskPermissions];
});

const getDefaultCheckPermission = computed(() => (component) => {
  if (props.mode == MConstant.FormMode.Add) {
    return [];
  }

  if (props.permissions.length == 0) {
    return [];
  }

  return props.permissions
    .filter((permission) => permission.Component === component)
    .map((item) => item.PermissionID);
});

const isEditMode = () => {
  return props.mode == MConstant.FormMode.Edit;
};

const isWatchMode = () => {
  return props.mode == MConstant.FormMode.Watch;
};

onMounted(async () => {
  await getProjectPermissions();

  if (isEditMode() || isWatchMode()) {
    bindMasterData();
  } else {
    bindInitMasterData();
  }
});

const bindInitMasterData = () => {
  master.Data.ProjectID = route.params.ProjectID;
};

const bindMasterData = () => {
  master.Data = cloneDeep(props.role);
  debugger;
  master.Data.Permissions = props.permissions;
};

const getProjectPermissions = async () => {
  await store.dispatch(ModuleProject + "/getProjectPermissions");
};

const btnSave_click = async () => {
  let data = collecData();
  let { isValid, errMsg } = validateData(data);
  if (!isValid) {
    warning(errMsg);
    return;
  }
  let actionName = "/insertProjectRole";
  let successMsg = "Thêm mới vai trò thành công";
  let errorMsg = "Có lỗi xảy ra khi thêm mới vai trò";

  if (isEditMode()) {
    successMsg = "Sửa vai trò thành công";
    errorMsg = "Có lỗi xảy ra khi sửa vai trò";
    actionName = "/updateProjectRole";
  }

  let param = {
    data,
    onSuccess: () => success(successMsg),
    onFailure: () => error(errorMsg),
  };

  await store.dispatch(ModuleProject + actionName, param);
  emits("updated");
  closeModal();
};

const collecData = () => {
  let data = cloneDeep(master.Data);
  return data;
};

const validateData = (data) => {
  let res = {
    errMsg: "",
    isValid: true,
  };

  if (!data.PermissionGroupName) {
    res.isValid = false;
    res.errMsg = "Tên vai trò không được để trống !";
    tfPermissionGroupName.value.invalid();
    return res;
  }

  if (data.Permissions.length == 0) {
    res.isValid = false;
    res.errMsg = "Phải có ít nhất một quyền đối với dự án !";
    return res;
  }

  if (props.roleProjects.length > 0) {
    let exitsNameRole = props.roleProjects.find(
      (role) => role.PermissionGroupName == data.PermissionGroupName
    );
    if (exitsNameRole) {
      res.isValid = false;
      res.errMsg = "Tên vai trò đã tồn tại trong dự án";
      return res;
    }
  }

  return res;
};

const updateCheckedKeys = (keys, options, meta) => {
  if (meta.action == ACTION_CHECK) {
    let addPermissions = options.filter(
      (permission) => !permission.PermissionID.includes(PERMISSION_KEY_PREFIX)
    );
    master.Data.Permissions = commonFn.addElementsInArrayIfNotExist(
      master.Data.Permissions,
      addPermissions,
      "PermissionID"
    );
  } else if (meta.action == ACTION_UNCHECK) {
    let isGroupPermissions = meta.node?.PermissionID.includes(
      PERMISSION_KEY_PREFIX
    );
    let arrDel = isGroupPermissions ? meta.node?.Permissions : [meta.node];
    master.Data.Permissions = commonFn.deleteElementsInArray(
      cloneDeep(master.Data.Permissions),
      arrDel,
      "PermissionID"
    );
  }

  console.log(master.Data.Permissions);
};

const closeModal = () => {
  emits("closeModal");
};

const checkDisable = computed(() => {
  if (isWatchMode()) {
    return true;
  }
  return false;
});
</script>

<template>
  <VModal customClass="form-role-detail">
    <template #default>
      <div class="form-role-detail--wrapper">
        <div class="form-header m-pb16 m-pl8 m-pr8">
          <div class="flex-row flex-jsp">
            <div class="text-xl">{{ formConfig.title }}</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-pl8 m-pr8">
          <div class="flex-row">
            <div class="flex-1 m-mr8">
              <div class="form-label m-pb4">
                Tên vai trò: <span class="danger">*</span>
              </div>
              <MInput
                ref="tfPermissionGroupName"
                :require="true"
                :placeholder="'Nhập tên phòng ban'"
                :customClass="'m-m0 input-l'"
                :disable="checkDisable"
                inputClass="m-pl16 m-pr16"
                v-model="master.Data.PermissionGroupName"
              />
            </div>

            <div class="flex-1 m-ml8">
              <div class="form-label m-pb4">Mô tả:</div>
              <MInput
                :placeholder="'Nhập mô tả'"
                :customClass="'m-m0 input-l'"
                :disable="checkDisable"
                inputClass="m-pl16 m-pr16"
                v-model="master.Data.Description"
              />
            </div>
          </div>

          <n-scrollbar style="max-height: 400px">
            <div class="flex-row">
              <div class="flex-1">
                <n-tree
                  block-line
                  cascade
                  checkable
                  :disabled="checkDisable"
                  default-expand-all
                  :data="getRoleData('Task')"
                  :default-checked-keys="getDefaultCheckPermission('Task')"
                  key-field="PermissionID"
                  label-field="PermissionName"
                  children-field="Permissions"
                  @update:checked-keys="updateCheckedKeys"
                />

                <n-tree
                  block-line
                  cascade
                  checkable
                  :disabled="checkDisable"
                  default-expand-all
                  :data="getRoleData('Issue')"
                  :default-checked-keys="getDefaultCheckPermission('Issue')"
                  key-field="PermissionID"
                  label-field="PermissionName"
                  children-field="Permissions"
                  @update:checked-keys="updateCheckedKeys"
                />

                <n-tree
                  block-line
                  cascade
                  checkable
                  :disabled="checkDisable"
                  default-expand-all
                  :data="getRoleData('Post')"
                  :default-checked-keys="getDefaultCheckPermission('Post')"
                  key-field="PermissionID"
                  label-field="PermissionName"
                  children-field="Permissions"
                  @update:checked-keys="updateCheckedKeys"
                />
              </div>

              <div class="flex-1">
                <n-tree
                  block-line
                  cascade
                  checkable
                  :disabled="checkDisable"
                  default-expand-all
                  :data="getRoleData('Project')"
                  :default-checked-keys="getDefaultCheckPermission('Project')"
                  key-field="PermissionID"
                  label-field="PermissionName"
                  children-field="Permissions"
                  @update:checked-keys="updateCheckedKeys"
                />

                <n-tree
                  block-line
                  cascade
                  checkable
                  :disabled="checkDisable"
                  default-expand-all
                  :data="getRoleData('Phase')"
                  :default-checked-keys="getDefaultCheckPermission('Phase')"
                  key-field="PermissionID"
                  label-field="PermissionName"
                  children-field="Permissions"
                  @update:checked-keys="updateCheckedKeys"
                />

                <n-tree
                  block-line
                  cascade
                  checkable
                  :disabled="checkDisable"
                  default-expand-all
                  :data="getRoleData('Report')"
                  :default-checked-keys="getDefaultCheckPermission('Report')"
                  key-field="PermissionID"
                  label-field="PermissionName"
                  children-field="Permissions"
                  @update:checked-keys="updateCheckedKeys"
                />
              </div>
            </div>
          </n-scrollbar>
        </div>

        <div class="form-footer" v-if="!checkDisable">
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
.form-role-detail--wrapper {
  width: 900px;
}
</style>
