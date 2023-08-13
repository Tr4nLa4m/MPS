<script setup>
import { ref, h } from "vue";
import EmployeeCardV3 from "@/components/cards/EmployeeV3.vue";
import { useStore } from "vuex";
import { ModuleProject } from "@/store/moduleConstant";
import { computed } from "vue";
import { onMounted } from "vue";

const emits = defineEmits(["closeModal", "chooseEmployee"]);
const props = defineProps({
  project: {
    type: Object,
    default: {},
  },
});
const store = useStore();
const employees = computed(() => store.state[ModuleProject]?.employees);
const searchText = ref("");

const getFilterEmployee = computed(() => {
  if (!searchText.value) {
    return employees.value;
  }

  let n_text = searchText.value.toLowerCase();

  return employees.value.filter(
    (item) =>
      item.FullName.toLowerCase().includes(n_text) ||
      item.Email.toLowerCase().includes(n_text)
  );
});

const renderCommonTitle = (titleClass, title) => {
  return h(
    "div",
    {
      class: "text-bold" + titleClass,
    },
    { default: () => "" + title }
  );
};

const createColumns = () => [
  {
    type: "selection",
    width: 40,
  },
  {
    title: (column) => {
      return renderCommonTitle(" m-pl40", "Người thực hiện");
    },
    key: "FullName",
    width: 210,
    render(row, index) {
      const item = {
        Avatar: row.Avatar,
        FullName: row.FullName,
      };
      const clickr = () => {};
      return h(EmployeeCardV3, {
        onClick: clickr,
        item: item,
        class: "m-w100",
      });
    },
  },
  {
    title: (column) => {
      return renderCommonTitle("", "Email");
    },
    key: "Email",
    width: 210,
  },
  {
    title: (column) => {
      return renderCommonTitle("", "Vị trí công việc");
    },
    key: "PositionName",
    width: 200,
  },
];

const rowKey = (row) => row.EmployeeID;

const listEmployee = ref([]);

const handleChooseEmployee = (rowKeys) => {
  let listEmployees = employees.value.filter((item) => rowKeys.includes(item.EmployeeID));
  listEmployee.value = listEmployees;
};

const columns = createColumns();

const closeModal = () => {
  emits("closeModal");
};

onMounted(async () => {
  let param = {
    ProjectID: props.project?.ProjectID,
  };
  // lấy danh sách nhân viên theo project
  await store.dispatch(ModuleProject + "/getEmployees", param);
});

const btnSave_click = () => {
  emits("chooseEmployee", listEmployee.value);
  closeModal();
};
</script>

<template>
  <VModal customClass="relate-employee">
    <template #default>
      <div class="form-relate-employee">
        <div class="form-header line-bottom m-pb8">
          <div class="flex-row flex-jsp">
            <div class="text-xl">Thêm người liên quan</div>

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
            <div class="flex-row m-pt16 w-100">
              <div class="w-100 flex-1 m-pb16">
                <MIconInput
                  :placeholder="'Tìm kiếm nhân viên theo tên hoặc email'"
                  :iconLeft="'mi-18 mi-search-before'"
                  :customClass="'m-m0'"
                  :inputClass="'no-border'"
                  v-model="searchText"
                />
              </div>

              <div class="flex-1"></div>
            </div>

            <div class="">
              <n-data-table
                :columns="columns"
                class="table-employee-relate"
                :data="getFilterEmployee"
                :max-height="400"
                :min-height="390"
                :single-line="false"
                :row-key="rowKey"
                @update:checked-row-keys="handleChooseEmployee"
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
                text="Thêm"
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
.form-relate-employee {
  width: 860px;
}

/* Customize */
.table-employee-relate {
  --n-th-padding: 8px !important;
  --n-td-padding: 8px !important;
}
</style>
