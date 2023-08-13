<script setup>
import EmployeeV2 from '@/components/cards/EmployeeV2.vue';
import { inject , ref, reactive, h, computed, onMounted} from 'vue';
import { useStore } from 'vuex';
import { ModuleContext, ModuleEmployee } from "@/store/moduleConstant";
import { cloneDeep } from "lodash" 


const store = useStore();
const models = inject("Model");
const commonFn = inject("CommonFn");
const emit = defineEmits(["closeModal"]);

const employee = computed(() => store.state[ModuleContext]?.employee); 
const defaultPermissionGroups = computed(
  () => store.state[ModuleContext]?.departmentPermissionGroups
);
const tfFilterEmployee = ref(null);
const dropdownFilterEmployee = reactive({
    show: false,
    xRef: 0,
    yRef: 0
})
const employeeFilters = ref([]);
const searchEmployeeText = ref('');

const master = reactive(models.createAddDepartmentParam());

let permissiongroup_member = null;

const renderOption = ({ node, option }) => {
  let click = () => {
    handleSelectEmployee(option);
  };
  return h(EmployeeV2, {
    onClick: click,
    clickable: true,
    item: option,
    class: "m-w100",
  });
};

//#region Hàm xử lý sự kiện
const onClickoutside = () => {
    dropdownFilterEmployee.show = false;
};

const handleSelectEmployee = (item) => {
  let employee = {
    ...item,
    PermissionGroupID: permissiongroup_member.PermissionGroupID
  }

  master['Employees'].push(employee);
  dropdownFilterEmployee.show = false;
  searchEmployeeText.value = '';
  deleteEmployeeFromFilter(employee);
};

const tfSearchEmployee_change = async (val) => {
  getPositionTfFilter();
  if (val.length < 2) {
    return;
  }

  let res = await getFilterEmployee(val);
  employeeFilters.value = commonFn.deleteElementsInArray(res, master.Employees, 'EmployeeID');
  dropdownFilterEmployee.show = true;
};

const tfSearchEmployee_click = () => {
  getPositionTfFilter();
  if (employeeFilters.value.length > 0) {
    dropdownFilterEmployee.show = true;
  }
};

const btnDeleteEmployee = (e, index) => {
  master.Employees?.splice(index, 1);
}
//#endregion

//#region Hàm xử lý logic
const closeModal = () => {
  emit("closeModal");
};

const getFilterEmployee = async (val) => {
  let paramFilter = {
    data: {
      KeySearch: val,
    },
  };
  return await store.dispatch(ModuleEmployee + "/filterEmployee", paramFilter);
};

const deleteEmployeeFromFilter = (employee) => {
  const index = employeeFilters.value.findIndex((item) => item.EmployeeID == employee.EmployeeID);
  if(index > -1){
    employeeFilters.value.splice(index, 1);
  }
}

const getPositionTfFilter = () => {
  dropdownFilterEmployee.xRef = tfFilterEmployee.value.$el.offsetLeft;
  dropdownFilterEmployee.yRef = tfFilterEmployee.value.$el.offsetTop;
};
//#endregion

//#region Life cycle hooks
onMounted(async () => {

  await getInitDepartmentPermissionGroups();

  bindInitMasterData();
});


const getInitDepartmentPermissionGroups = async () => {
  await store.dispatch(ModuleContext + "/getInitDepartmentPermissionGroups");
};

const bindInitMasterData = () => {
  let permissiongroup_full = cloneDeep(defaultPermissionGroups.value.find((item) =>
    item.PermissionGroupName.includes("Toàn quyền")
  ));
  permissiongroup_member = cloneDeep( defaultPermissionGroups.value.find((item) =>
    item.PermissionGroupName.includes("Thành viên")
  ));
  master["Employees"]?.push({
    ...employee.value,
    PermissionGroupID: permissiongroup_full.PermissionGroupID,
    default: true,
  });

};
//#endregion
</script>

<template>
  <VModal customClass="form-department">
    <template #default>
      <div class="form-department--wrapper">
        <div class="form-header">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">Thêm phòng ban</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body">
          <div class="">
            <div class="form-label m-pb8">
              Tên phòng ban: <span class="danger">*</span>
            </div>
            <MInput
              :placeholder="'Nhập tên phòng ban'"
              :customClass="'m-m0 input-l'"
              inputClass="m-pl16 m-pr16"
              v-model="master.DepartmentName"
            />
          </div>

          <div class="m-pb8">
            <div class="form-label m-pb8">Mô tả:</div>
            <n-input
              v-model:value="master.Description"
              type="textarea"
              placeholder="Nhập mô tả"
            />
          </div>

          <div class="">
            <div class="flex-row flex-jsp m-pb8">
              <div class="form-label">Thành viên ({{ master.Employees?.length }})</div>
            </div>

            <div class="flex-row">
              <MInput
                ref="tfFilterEmployee"
                :placeholder="'Tìm theo tên hoặc email'"
                :customClass="'m-m0 input-l'"
                inputClass="m-pl16 m-pr16"
                :enableChange="true"
                v-model="searchEmployeeText"
                @onTextChange="tfSearchEmployee_change"
                @click="tfSearchEmployee_click"
              />

            </div>

            <div class="border employees-department">
              <n-scrollbar style="max-height: 250px">
                <div
                  class="flex-row flex-align-center m-pt8 m-pb8 m-pl16 m-pr16"
                  v-for="(item, index) in master.Employees"
                >
                  <div class="employee-avt mi-32 round m-mr16">
                    <img class="round" :src="item.Avatar || ''" />
                  </div>

                  <div class="employee-info flex-1">
                    <div class="text-bold-l line-small">
                      {{ item.FullName }}
                    </div>
                    <div class="text-fade line-small">
                      {{ item.PositionName }}
                    </div>
                    <div class="text-small text-fade line-small">
                      {{ item.Email }}
                    </div>
                  </div>

                  <div class="employee-toolbar flex-row flex-align-center">
                    <div class="pointer m-mr8">
                      <n-select
                        class="m-select employee-permission"
                        :disabled="item.default"
                        v-model:value="item.PermissionGroupID"
                        :options="defaultPermissionGroups"
                        label-field="PermissionGroupName"
                        value-field="PermissionGroupID"
                        placeholder="Quyền hạn"
                      />
                    </div>

                    <div class="m-p8 pointer" v-if="!item.default" @click="btnDeleteEmployee($event, index)">
                      <div class="mi-16 mi-close"></div>
                    </div>

                    <div class="m-p4" v-else>
                      <div class="mi-24 mi-lock"></div>
                    </div>
                  </div>
                </div>
              </n-scrollbar>
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

        <n-dropdown
          class="dropdown-search-employee"
          :show="dropdownFilterEmployee.show"
          key-field="EmployeeID"
          label-field="FullName"
          placement="top-start"
          :options="employeeFilters"
          :on-clickoutside="onClickoutside"
          @select="handleSelectEmployee"
          :render-option="renderOption"
          trigger="manual"
          :x="dropdownFilterEmployee.xRef"
          :y="dropdownFilterEmployee.yRef"
        >
        </n-dropdown>
      </div>
    </template>
  </VModal>
</template>

<style>

.form-department--wrapper {
  width: 680px;
}

.form-department--wrapper .form-body {
  padding:8px 8px 0 8px;
}</style>
