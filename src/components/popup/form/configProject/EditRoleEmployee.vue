<script setup>
import { ModuleContext, ModuleProject } from "@/store/moduleConstant";
import { useMessages } from "@/utils/uses/base/useMessages";
import { includes, cloneDeep } from "lodash";
import { onMounted, ref, watch } from "vue";
import { reactive } from "vue";
import { computed } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";

const store = useStore();
const route = useRoute();
const emits = defineEmits(["closeModal", "updated"]);
const props = defineProps({
  employee: {
    type: Object,
    default: {}
  },
})
const currentRole = reactive({
  Data: {},
});

const {success, error} = useMessages();

const desRole = ref("");

const roles = computed(
  () => store.state[ModuleContext]?.projectPermissionGroups
);

watch(
  () => currentRole.Data.PermissionGroupID,
  (newVal, oldValue) => {
    let roless = cloneDeep(roles.value);
    let roleMember = roless.find((role) => role.PermissionGroupID == newVal);
    if (roleMember) {
      desRole.value = roleMember.Description;
    }
  }
);

onMounted(async () => {
  await getProjectRoles();

  bindInitMasterData();
});

const bindInitMasterData = () => {
  if (roles.value.length <= 0) {
    return;
  }

  let roless = cloneDeep(roles.value);
  let roleMember = roless.find((role) =>
    role.PermissionGroupID == props.employee?.PermissionGroupID
  );
  if (!roleMember) {
    currentRole.Data = roles.value[0];
  }

  currentRole.Data = roleMember;
  desRole.value = roleMember.Description;
};

const getProjectRoles = async () => {
  let param = {
    data: {
      ProjectID: route.params.ProjectID,
    },
  };

  await store.dispatch(ModuleContext + "/getProjectPermissionGroups", param);
};

const btnSave_click = async () => {
  let data = cloneDeep(currentRole.Data);

  data['EmployeeID'] = props.employee.EmployeeID;
  data['ProjectID'] = route.params.ProjectID;

  let param = {
    data,
    onSuccess: () => success('Sửa vai trò thành viên thành công'),
    onFailure: () => error('Có lỗi xảy ra khi sửa vai trò thành viên')
  };

  await store.dispatch(ModuleProject + '/setEmployeeRole', param);
  emits("updated");
  closeModal();

}

const closeModal = () => {
  emits("closeModal");
};
</script>

<template>
  <VModal customClass="edit-employee-role-project">
    <template #default>
      <div class="form-edit-employee-role--wrapper">
        <div class="form-header m-pb16 m-pl8 m-pr8">
          <div class="flex-row flex-jsp">
            <div class="text-xl">Sửa vai trò</div>

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
            <div class="">Nhân viên :</div>
            <div class="m-pl8 text-bold">{{ employee.FullName }}</div>
          </div>

          <div class="m-pt8">
            <div class="m-pb8">Vai trò</div>
            <n-scrollbar style="max-height: 150px">
              <n-radio-group
                v-model:value="currentRole.Data.PermissionGroupID"
                name="radiogroup"
              >
                <n-space>
                  <n-radio
                    v-for="role in roles"
                    :key="role.PermissionGroupID"
                    :value="role.PermissionGroupID"
                    :label="role.PermissionGroupName"
                  />
                </n-space>
              </n-radio-group>
            </n-scrollbar>

            <div class="m-pt8">
              <n-input
                v-model:value="desRole"
                type="textarea"
                placeholder="Nhập mô tả"
                :disabled="true"
                :autosize="{
                  minRows: 3,
                  maxRows: 3  ,
                }"
              />
            </div>
          </div>
        </div>

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
.form-edit-employee-role--wrapper {
  width: 500px;
}
</style>
