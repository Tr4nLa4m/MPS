<script setup>
import { computed, inject, ref, reactive, h } from "vue";
import { useStore } from "vuex";
import {
  ModuleEmployee,
  ModuleProject,
  ModuleContext,
} from "@/store/moduleConstant";
import { onMounted } from "vue";
import EmployeeCardV2 from "@/components/cards/EmployeeV2.vue";
import _ from "lodash";
import { useMessages } from "@/utils/uses/base/useMessages";
import eventBus, { GlobalEventName } from "@/utils/helper/eventBus";
import MConstant, {
  DEPARTMENT_KEY_PREFIX,
  GUID_EMPTY,
} from "@/common/consts/MConstant";
import project from "@/store/modules/project";

const store = useStore();
const models = inject("Model");
const commonFn = inject("CommonFn");
const emit = defineEmits(["closeModal"]);
const { error, success } = useMessages();
const employeeInProjects = computed(() => store.state[ModuleProject]?.employees);
const employeeFilters = ref([]);
const master = reactive(models.createAddEmployeeParam());
const tfFilterEmployee = ref(null);
const searchEmployeeText = ref("");

const dropdownFilterEmployeeConfig = reactive({
  show: false,
  xRef: 0,
  yRef: 0,
  onClickoutside: () => {
    dropdownFilterEmployeeConfig.show = false;
  },
  renderOption: ({ node, option }) => {
    let click = () => {
      dropdownFilterEmployeeConfig.handleSelectEmployee(option);
    };
    return h(EmployeeCardV2, {
      onClick: click,
      clickable: true,
      item: option,
      class: "m-w100",
    });
  },
  handleSelectEmployee: (item) => {
    let employee = {
      ...item,
      PermissionGroupID: permissiongroup_member.PermissionGroupID,
    };

    master["Employees"].push(employee);
    dropdownFilterEmployeeConfig.show = false;
    searchEmployeeText.value = "";
    deleteEmployeeFromFilter(employee);
  },
});
const dropdownFilterEmployeeEl = ref(null);

let permissiongroup_member = null;

const departmentProjects = computed(() => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];

    // disable project
  rawDepartmentProjects.forEach((department) => {
    if (!department.Projects || department.Projects.length < 1) {
      return;
    }

    let initProjectIndex = department.Projects.findIndex(
      (project) => project.IsInitProject
    );
    if (initProjectIndex > -1) {
      department.Projects[initProjectIndex]["disabled"] = true;
    }
  });

  return rawDepartmentProjects?.map((item) => {
    return {
      ...item,
      ProjectID: DEPARTMENT_KEY_PREFIX + item.DepartmentID,
      ProjectName: item.DepartmentName,
      disabled: true,
    };
  });
});
const employee = computed(() => store.state[ModuleContext]?.employee);
const defaultPermissionGroups = computed(
  () => store.state[ModuleContext]?.projectPermissionGroups
);

onMounted(async () => {
  await getProjects();

  await getInitPermissionGroups();

  await bindInitMasterData();
});

const bindInitMasterData = async () => {
  let permissiongroup_full = _.cloneDeep(
    defaultPermissionGroups.value.find((item) =>
      item.PermissionGroupName.includes("Toàn quyền")
    )
  );
  permissiongroup_member = _.cloneDeep(
    defaultPermissionGroups.value.find((item) =>
      item.PermissionGroupName.includes("Thành viên")
    )
  );

  master.ProjectID = getDefaultDepartmentProject();

  await getEmployeeInProject();
};

const getDefaultDepartmentProject = () => {
  let rawDepartmentProjects =
    store.getters[ModuleProject + "/departmentProjects"];
  for (let index = 0; index < rawDepartmentProjects.length; index++) {
    let department = rawDepartmentProjects[index];
    for(let item of department.Projects){
        if(!item.IsInitProject){
            return item.ProjectID;
        }
    }
  }
  return "";
};

const getEmployeeInProject = async () => {
  let param = {
    ProjectID: master.ProjectID,
  };

  await store.dispatch(ModuleProject + "/getEmployees", param);

  console.log(employeeInProjects.value);
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
  dropdownFilterEmployeeConfig.xRef = tfFilterEmployee.value.$el.offsetLeft;
  dropdownFilterEmployeeConfig.yRef = tfFilterEmployee.value.$el.offsetTop;
};

const closeModal = () => {
  emit("closeModal");
};

const tfSearchEmployee_click = () => {
  getPositionTfFilter();
  if (employeeFilters.value.length > 0) {
    dropdownFilterEmployeeConfig.show = true;
  }
};

const tfSearchEmployee_change = async (val) => {
  getPositionTfFilter();
  if (val.length < 2) {
    return;
  }
  let res = await getFilterEmployee(val);

  
  employeeFilters.value = commonFn.deleteElementsInArray(
    res,
    [...master.Employees, ...employeeInProjects.value],
    "EmployeeID"
  );
  dropdownFilterEmployeeConfig.show = true;
};

const deleteEmployeeFromFilter = (employee) => {
  const index = employeeFilters.value.findIndex(
    (item) => item.EmployeeID == employee.EmployeeID
  );
  if (index > -1) {
    employeeFilters.value.splice(index, 1);
  }
};

const getProjects = async () => {
  // lấy danh sách các dự án
  let param = {
    EmployeeID: employee?.value.EmployeeID,
  };
  await store.dispatch(ModuleProject + "/getProjectByEmployee", param);
};

const btnDeleteEmployee = (e, index) => {
  master.Employees?.splice(index, 1);
};

const btnSave_click = async () => {

  let data = _.cloneDeep(master);

  let payload = {
    data,
    onSuccess: () => {
      success("Thêm nhân viên vào dự án thành công");
      
    },
    onFailure: () => error('Có lỗi xảy ra')
  };

  await store.dispatch(ModuleProject + "/insertEmployees", payload);
  emit("closeModal");
};

const selectProject_change = async (value, option) => {
  await getEmployeeInProject();

  master.Employees = [];
};
</script>

<template>
  <VModal customClass="form-project">
    <template #default>
      <div class="form-project--wrapper">
        <div class="form-header">
          <div class="flex-row flex-jsp m-pl8">
            <div class="text-xl">Thêm nhân viên vào dự án/nhóm</div>

            <MButtonIcon
              classCustom="m-ml8 m-p8"
              icon="mi-close mi-16"
              title="Đóng"
              @click="closeModal"
            />
          </div>
        </div>

        <div class="form-body m-w100">
          <div class="flex-1 m-mr8">
            <div class="form-label m-pb4">
              Chọn dự án: <span class="danger">*</span>
            </div>
            <MTreeSelect
              :data="departmentProjects"
              v-model="master.ProjectID"
              class="m-select"
              label-field="ProjectName"
              key-field="ProjectID"
              children-field="Projects"
              placeholder="Dự án"
              :isExpandAll="true"
              :enableChange="true"
              @onChange="selectProject_change"
            />
          </div>

          <div class="m-pt8">
            <div class="flex-row m-pb8 flex-jsp">
              <div class="form-label">
                Chọn thành viên ({{ master.Employees?.length }})
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

            <div
              class="employees"
              :class="master.Employees.length > 0 ? 'border' : ''"
            >
              <n-scrollbar style="max-height: 300px">
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

                    <div
                      class="m-p8 pointer"
                      v-if="!item.default"
                      @click="btnDeleteEmployee($event, index)"
                    >
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
          ref="dropdownFilterEmployeeEl"
          :show="dropdownFilterEmployeeConfig.show"
          key-field="EmployeeID"
          label-field="FullName"
          placement="bottom-start"
          :options="employeeFilters"
          :on-clickoutside="dropdownFilterEmployeeConfig.onClickoutside"
          @select="dropdownFilterEmployeeConfig.handleSelectEmployee"
          :render-option="dropdownFilterEmployeeConfig.renderOption"
          trigger="manual"
          :x="dropdownFilterEmployeeConfig.xRef"
          :y="dropdownFilterEmployeeConfig.yRef + 30"
        >
        </n-dropdown>
      </div>
    </template>
  </VModal>
</template>

<style>
.form-employee--wrapper {
  width: 680px;
}

.form-body .employees {
  min-height: 300px;
}

.form-employee--wrapper .form-body {
  padding: 16px 8px 0 8px;
}

.form-employee--wrapper .btn-choose-employee {
  height: 38px;
  color: var(--primary-color) !important;
  border: 1px solid var(--primary-color);
}

.n-virtual-list {
  --n-option-text-color-active: var(--primary-color) !important;
  --n-option-check-color: var(--primary-color) !important;
}

.dropdown-search-employee.n-dropdown-menu {
  width: 640px !important;
  box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px !important;
}

.employee-permission .n-base-selection {
  --n-border: 0 !important;
  min-width: 130px;
}

.v-binder-follower-content:has(.dropdown-search-employee) {
  max-height: 300px !important;
  overflow-y: auto;
}
</style>
