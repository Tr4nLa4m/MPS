<script setup>
import { ModuleIssue, ModuleContext } from "@/store/moduleConstant";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";
import { onMounted } from "vue";
import { h, reactive, computed, nextTick, inject, ref } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";

const store = useStore();
const route = useRoute();
const { goToDetailIssue } = useRoutePath();
const models = inject("Model");
const masterParam = reactive(models.createGetPagingIssueByProjectParam());
const employee = computed(() => store.state[ModuleContext]?.employee);
const totalRecord = ref(0);
const masterData = ref([]);
const projectID = ref(route.params.ProjectID);

const createColumns = () => [
  {
    title: "Loại",
    key: "IssueType",
    width: 40,
    fixed: "left",
    render(row, index) {
      return h("div", { class: "card-issue-avt", title: row.IssueTypeName }, [
        h("img", { src: row.IssueTypeAvatar }),
      ]);
    },
  },
  {
    title: "Mã vấn đề",
    key: "IssueCode",
    width: 60,
    fixed: "left",
    render(row, index) {
      let onClick = () => {
        goToDetailIssue(row.IssueID);
      };
      return h(
        "div",
        { class: "text-hover-primary", onClick: onClick },
        row.IssueCode
      );
    },
  },
  {
    title: "Tiêu đề",
    key: "IssueName",
    width: 300,
    render(row, index) {
      let onClick = () => {
        goToDetailIssue(row.IssueID);
      };
      return h(
        "div",
        { class: "text-hover-primary", onClick: onClick },
        row.IssueName
      );
    },
  },
  {
    title: "Trạng thái",
    key: "IssueStatusName",
    width: 100,
  },
  {
    title: "Người xử lý",
    key: "AssigneeName",
    render(row, index) {
      return h("div", { class: "text-link-v2" }, row.AssigneeName);
    },
    width: 120,
  },
  {
    title: "Người báo cáo",
    key: "CreatorName",
    render(row, index) {
      return h("div", { class: "text-link-v2" }, row.CreatorName);
    },
    width: 120,
  },
];

const tableConfig = reactive({
  maxHeight: 460,
  minHeight: 450,
});

const pageSizes = [
  {
    label: "10 bản ghi / trang",
    value: 10,
  },
  {
    label: "20 bản ghi / trang",
    value: 20,
  },
  {
    label: "30 bản ghi / trang",
    value: 30,
  },
  {
    label: "40 bản ghi / trang",
    value: 40,
  },
];

const statusFilter = reactive({
  text: "Trạng thái hoàn thành Tất cả",
  value: "",
});

const sortFilter = reactive({
  text: "Sắp xếp theo Ngày tạo (Tăng dần)",
  value: "",
});

const menuContextConfig = reactive({
  xRef: 0,
  yRef: 0,
  showDropdownRef: false,
  options: [
    {
      label: "Edit",
      key: "edit",
    },
    {
      label: () => h("span", { style: { color: "red" } }, "Delete"),
      key: "delete",
    },
  ],
  handleSelect() {
    menuContextConfig.showDropdownRef = false;
  },
  onClickoutside() {
    menuContextConfig.showDropdownRef = false;
  },
  rowProps(row) {
    return {
      onContextmenu: (e) => {
        e.preventDefault();
        menuContextConfig.showDropdownRef = false;
        nextTick().then(() => {
          menuContextConfig.showDropdownRef = true;
          menuContextConfig.xRef = e.clientX;
          menuContextConfig.yRef = e.clientY;
        });
      },
    };
  },
});

onMounted(async () => {
  getTableHeight();

  initMasterParam();

  await getData();
});

const initMasterParam = () => {
  masterParam.IssueStatus = 0; // All
  masterParam.SortBy = 1; // Created Date DESC
  masterParam.ProjectID = projectID.value;
  masterParam.PageIndex = 1;
  masterParam.PageSize = 10;
  masterParam.EmployeeID = employee.value.EmployeeID;
  masterParam.CreatorID = employee.value.EmployeeID;
};

const getData = async () => {
  let param = {
    data: masterParam,
    onFailure: () => {},
  };
  let res = await store.dispatch(ModuleIssue + "/getIssuesByProject", param);
  masterData.value = res.data;
  totalRecord.value = res.totalRecord;
};

const getTableHeight = () => {
  tableConfig.minHeight = window.innerHeight - 56 - 32 - 40 - 16 - 92;
  tableConfig.maxHeight = tableConfig.minHeight + 10;
};

const onPage_change = async (page) => {
  if (masterParam.PageIndex != page) {
    masterParam.PageIndex = page;
    await getData();
  }
};

const onPageSize_change = async (pageSize) => {
  if (masterParam.PageSize != pageSize) {
    masterParam.PageSize = pageSize;
    await getData();
  }
};

const columns = createColumns();
</script>

<template>
  <div class="list-issue m-pl16 m-mr16 m-pb16">
    <div class="grid-issue-filter flex-row flex-jsp m-pb8">
      <div class="">
        <div class="text-large">Vấn đề gần đây</div>
      </div>

      <div class="flex-row">
        <div class="m-mr24">
          <n-dropdown
            trigger="click"
            :options="dropdownStatusOptions"
            :show-arrow="true"
            @select="handleSelectStatusFilter"
            size="large"
          >
            <MButton
              :text="statusFilter.text"
              :title="'Chọn loại trạng thái hoàn thành công việc'"
              :tag="'TypeStatusTask'"
              :classCustom="'m-button-m grid-filter-btn'"
              leftIcon="mi-16 mi-grid-status-done"
              rightIcon="mi-16 mi-carret-down"
              :classText="'m-mr8 m-ml8'"
            />
          </n-dropdown>
        </div>

        <div class="m-mr24">
          <n-dropdown
            trigger="click"
            :options="dropdownSortOptions"
            :show-arrow="true"
            @select="handleSelectSortFilter"
            size="large"
          >
            <MButton
              :text="sortFilter.text"
              :title="'Chọn loại trạng thái hoàn thành công việc'"
              :tag="'TypeStatusTask'"
              :classCustom="'m-button-m grid-filter-btn'"
              leftIcon="mi-16 mi-grid-status-done"
              rightIcon="mi-16 mi-carret-down"
              :classText="'m-mr8 m-ml8'"
            />
          </n-dropdown>
        </div>

        <div class="m-mr16">
          <MButton
            :text="'Lấy dữ liệu'"
            :title="'Lấy lại dữ liệu'"
            :classCustom="'m-button-m grid-filter-btn'"
            leftIcon="mi-24 mi-reload"
            :classText="'m-mr8 m-ml8'"
            @click="getData"
          />
        </div>
      </div>
    </div>
    <n-data-table
      :columns="columns"
      :data="masterData"
      class="table-issue"
      :max-height="tableConfig.maxHeight"
      :min-height="tableConfig.minHeight"
      :single-line="false"
      :row-props="menuContextConfig.rowProps"
    />

    <div class="m-pt8 m-pl16 m-pr16 flex-row flex-align-center">
      <div class="">
        Tổng cộng :
        <span class="text-bold">{{ totalRecord }}</span>
        bản ghi
      </div>

      <div class="flex-1"></div>

      <n-pagination
        v-model:page="masterData.PageIndex"
        v-model:item-count="totalRecord"
        :page-sizes="pageSizes"
        :on-update:page="onPage_change"
        :on-update:page-size="onPageSize_change"
        show-size-picker
      />
    </div>

    <n-dropdown
      placement="bottom-start"
      trigger="manual"
      :x="menuContextConfig.xRef"
      :y="menuContextConfig.yRef"
      :options="menuContextConfig.options"
      :show="menuContextConfig.showDropdownRef"
      :on-clickoutside="menuContextConfig.onClickoutside"
      @select="menuContextConfig.handleSelect"
    />
  </div>
</template>

<style>
.list-issue {
  background-color: #fff;
  margin: 16px 8px;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 8px 0;
  height: calc(100vh - 90px);
}

/* Customize */
.table-issue {
  --n-th-padding: 8px !important;
  --n-td-padding: 8px !important;
}

.grid-filter-btn {
  background-color: #fff !important;
  color: #1f1f1f !important;
  font-size: 13px !important;
  font-weight: 400 !important;
}

.card-issue-avt {
  display: flex;
  justify-content: center;
  cursor: pointer;
}
</style>
