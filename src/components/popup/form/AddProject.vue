<script setup>
import { computed, inject, ref, reactive, h } from "vue";
import { useStore } from "vuex";
import {
  ModuleDepartment,
  ModuleEmployee,
  ModuleProject,
  ModuleContext,
} from "@/store/moduleConstant";
import { onMounted } from "vue";
import EmployeeCardV2 from "@/components/cards/EmployeeV2.vue";
import _ from "lodash"
import { useMessages } from "@/utils/uses/base/useMessages";
import eventBus, {GlobalEventName} from '@/utils/helper/eventBus';

const store = useStore();
const models = inject("Model");
const commonFn = inject("CommonFn");
const emit = defineEmits(["closeModal"]);
const { warning, success } = useMessages();

const employeeFilters = ref([]);

const tfFilterEmployee = ref(null);
const searchEmployeeText = ref('');

const showDropdown = ref(false);
const dropdownFilterEmployee = ref(null);
const positionTfFilter = reactive({
  xRef: 0,
  yRef: 0,
});

let permissiongroup_member = null;

const departments = computed(() => store.state[ModuleDepartment].departments);
const employee = computed(() => store.state[ModuleContext]?.employee);
const defaultPermissionGroups = computed(
  () => store.state[ModuleContext]?.projectPermissionGroups
);

const employeeDepartments = computed(() => store.state[ModuleEmployee]?.employees);
const master = reactive(models.createAddProjectParam());

const renderOption = ({ node, option }) => {
  let click = () => {
    handleSelectEmployee(option);
  };
  return h(EmployeeCardV2, {
    onClick: click,
    clickable: true,
    item: option,
    class: "m-w100",
  });
};

onMounted(async () => {
  let param = {
    data: {
      EmployeeID: employee.value.EmployeeID,
    },
  };
  // lấy dữ liệu danh sách phòng ban của nhân viên
  await store.dispatch(ModuleDepartment + "/getDepartmentByEmployee", param);

  await getInitPermissionGroups();

  bindInitMasterData();
});

const bindInitMasterData = () => {
  let permissiongroup_full = _.cloneDeep(defaultPermissionGroups.value.find((item) =>
    item.PermissionGroupName.includes("Toàn quyền")
  ));
  permissiongroup_member = _.cloneDeep( defaultPermissionGroups.value.find((item) =>
    item.PermissionGroupName.includes("Thành viên")
  ));
  master["Employees"]?.push({
    ...employee.value,
    PermissionGroupID: permissiongroup_full.PermissionGroupID,
    default: true,
  });
  master['DepartmentID'] = departments.value[0].DepartmentID;

};

const getInitPermissionGroups = async () => {
  await store.dispatch(ModuleContext + "/getInitProjectPermissionGroups");
};

const getFilterEmployee = async (val) => {
  let paramFilter = {
    data: {
      KeySearch: val,
    },
  };
  return await store.dispatch(ModuleEmployee + "/filterEmployee", paramFilter);
};

const getPositionTfFilter = () => {
  positionTfFilter.xRef = tfFilterEmployee.value.$el.offsetLeft;
  positionTfFilter.yRef = tfFilterEmployee.value.$el.offsetTop;
};

const onClickoutside = () => {
  showDropdown.value = false;
};

const closeModal = () => {
  emit("closeModal");
};

const tfSearchEmployee_click = () => {
  getPositionTfFilter();
  if (employeeFilters.value.length > 0) {
    showDropdown.value = true;
  }
};

const tfSearchEmployee_change = async (val) => {
  getPositionTfFilter();
  if (val.length < 2) {
    return;
  }

  let res = await getFilterEmployee(val);
  employeeFilters.value = commonFn.deleteElementsInArray(res, master.Employees, 'EmployeeID');
  showDropdown.value = true;
};

const handleSelectEmployee = (item) => {
  let employee = {
    ...item,
    PermissionGroupID: permissiongroup_member.PermissionGroupID
  }

  master['Employees'].push(employee);
  showDropdown.value = false;
  searchEmployeeText.value = '';
  deleteEmployeeFromFilter(employee);
};

const deleteEmployeeFromFilter = (employee) => {
  const index = employeeFilters.value.findIndex((item) => item.EmployeeID == employee.EmployeeID);
  if(index > -1){
    employeeFilters.value.splice(index, 1);
  }
}

const btnAddAllEmployeeDepartment_click = async () => {
  let param = {
    data: {
      DepartmentID: master.DepartmentID
    }
  }
  await store.dispatch(ModuleEmployee + '/getByDepartment', param);
  employeeDepartments.value.forEach(emp => {
    let employeeExist = master.Employees?.find(item => item.EmployeeID == emp.EmployeeID);
    if(!employeeExist){
      master.Employees.push({
        ...emp,
        PermissionGroupID: permissiongroup_member.PermissionGroupID
      })
    }
  });
}

const btnDeleteEmployee = (e, index) => {
  master.Employees?.splice(index, 1);
}

const btnSave_click = async () => {
  let data = _.cloneDeep(master);

  data.StartDate = data.StartDate ? new Date(data.StartDate) : null;
  data.EndDate = data.EndDate ? new Date(data.EndDate) : null;
  data.CreatedBy = employee.value.EmployeeCode;
  
  let payload = {
    data,
    onSuccess : () => {
      success("Thêm mới dự án thành công");
      eventBus.$emit(GlobalEventName.loadProjectSidebar);
      emit("closeModal");
    }
  };

  await store.dispatch(ModuleProject + '/insertProject', payload);


}

</script>

<template>
  <VModal customClass="form-project">
    <template #default>
      <div class="form-project--wrapper">
        <div class="form-header">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">Thêm mới dự án/nhóm</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-w100">
          <div class="">
            <div class="form-label m-pb8">
              Tên dự án/nhóm: <span class="danger">*</span>
            </div>
            <MInput
              :placeholder="'Tên dự án/nhóm'"
              :customClass="'m-m0 input-l'"
              inputClass="m-pl16 m-pr16"
              v-model="master.ProjectName"

            />
          </div>

          <div class="flex-row m-pb8">
            <div class="flex-1">
              <div class="form-label m-pb8">Chọn phòng ban:</div>
              <n-select
                class="m-select"
                v-model:value="master.DepartmentID"
                :options="departments"
                label-field="DepartmentName"
                value-field="DepartmentID"
                placeholder="Chọn phòng ban"
              />
            </div>

            <div class="flex-1 flex-row">
              <div class="project-date m-ml8">
                <div class="form-label m-pb8">Từ ngày:</div>
                <n-date-picker
                  v-model:value="master.StartDate"
                  type="date"
                  format="dd/MM/yyyy"
                  placeholder="Từ ngày"
                />
              </div>

              <div class="project-date m-ml8">
                <div class="form-label m-pb8">Đến ngày:</div>
                <n-date-picker
                  v-model:value="master.EndDate"
                  type="date"
                  format="dd/MM/yyyy"
                  placeholder="Đến ngày"
                />
              </div>
            </div>
          </div>

          <div class="m-pb8">
            <div class="form-label m-pb8">Mô tả:</div>
            <n-input
              v-model:value="master.Description"
              type="textarea"
              placeholder="Mô tả"
            />
          </div>

          <div class="">
            <div class="flex-row m-pb8 flex-jsp">
              <div class="form-label ">Thành viên ({{ master.Employees?.length }})</div>

              <div class="pointer text-bold-l text-primary" @click="btnAddAllEmployeeDepartment_click">
                Thêm thành viên từ phòng ban
              </div>
            </div>

            <div class="flex-row">
              <MInput
                ref="tfFilterEmployee"
                :placeholder="'Tìm theo tên hoặc email'"
                :customClass="'m-m0 input-l'"
                inputClass="m-pl16 m-pr16"
                v-model="searchEmployeeText"
                :enableChange="true"
                @onTextChange="tfSearchEmployee_change"
                @click="tfSearchEmployee_click"
              />

              <!-- <MButton
                class="m-button-l transparent m-ml8 btn-choose-employee"
                leftIcon="mi-16 mi-user-blue"
                text="Chọn"
              /> -->
            </div>

            <div class="border employees-project">
              <n-scrollbar style="max-height: 150px">
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
          ref="dropdownFilterEmployee"
          :show="showDropdown"
          key-field="EmployeeID"
          label-field="FullName"
          placement="top-start"
          :options="employeeFilters"
          :on-clickoutside="onClickoutside"
          @select="handleSelectEmployee"
          :render-option="renderOption"
          trigger="manual"
          :x="positionTfFilter.xRef"
          :y="positionTfFilter.yRef"
        >
        </n-dropdown>
      </div>
    </template>
  </VModal>
</template>

<style>
.form-project--wrapper {
  width: 680px;
}

.form-project--wrapper .form-body {
  padding: 16px 8px 0 8px;
}

.form-project--wrapper .btn-choose-employee {
  height: 38px;
  color: var(--primary-color) !important;
  border: 1px solid var(--primary-color);
}



.n-virtual-list {
  --n-option-text-color-active: var(--primary-color) !important;
  --n-option-check-color: var(--primary-color) !important;
}

.project-date .n-input {
  --n-height: 38px !important;
  --n-border-hover: 1px solid var(--primary-color) !important;
  --n-border-focus: 1px solid var(--primary-color) !important;
}

.dropdown-search-employee.n-dropdown-menu {
  width: 500px !important;
}

.employee-permission .n-base-selection{
  --n-border: 0 !important;
  min-width: 130px;
}



.v-binder-follower-content:has(.dropdown-search-employee) {
  max-height: 300px !important;
  overflow-y: auto;
}
</style>
