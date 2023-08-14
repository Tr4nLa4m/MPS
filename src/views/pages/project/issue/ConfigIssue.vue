<script setup>
import { ModulePost, ModuleContext } from "@/store/moduleConstant";
import commonFn from "@/utils/helper/commonFn";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";
import { onMounted } from "vue";
import { h, reactive, computed, nextTick, inject, ref } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
import CategoryTab from "@/views/pages/project/post/detailTabs/CategoryTab.vue";
import TagTab from "@/views/pages/project/post/detailTabs/TagTab.vue";
import IssueTypeTab from "./detailTabs/IssueTypeTab.vue";

const store = useStore();
const route = useRoute();
const { goToDetailPost } = useRoutePath();
const models = inject("Model");
const masterParam = reactive(models.createGetPagingPostByProjectParam());
const employee = computed(() => store.state[ModuleContext]?.employee);
const totalRecord = ref(0);
const masterData = ref([]);
const projectID = ref(route.params.ProjectID);
const categories = computed(() => store.state[ModulePost].categories);

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

const quickFilter = reactive({
  text: "Tất cả công việc",
  value: "",
});

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

const getCategories = async () => {
  let param = {
    data: {
      ProjectID: projectID.value,
    },
  };
  let res = await store.dispatch(ModulePost + "/getCategoriesByProject", param);
};

onMounted(async () => {
  getTableHeight();

  initMasterParam();

  await getCategories();

  await getData();
});

const initMasterParam = () => {
  masterParam.IssueStatus = 0; // All
  masterParam.SortBy = 1; // Created Date DESC
  masterParam.ProjectID = projectID.value;
  masterParam.PageIndex = 1;
  masterParam.PageSize = 10;
  masterParam.EmployeeID = employee.value.EmployeeID;
  masterParam.AuthorID = employee.value.EmployeeID;
};

const getData = async () => {
  let param = {
    data: masterParam,
    onFailure: () => {},
  };
  let res = await store.dispatch(ModulePost + "/getPostsByProject", param);
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

const btnPost_click = (post) => {
  let postID = post.PostID;
  goToDetailPost(postID, projectID);
};

const columns = createColumns();
</script>

<template>
  <div class="config-issue m-pl16 m-mr16 m-pb16">
    <n-scrollbar :style="`max-height: 600px`">
      <div class="flex-row m-pb8">
        <div class="list-content">
          <div class="config-issue-header">
            <div class="">
              <div class="text-large">Thiết lập</div>
            </div>
          </div>

          <div class="config-issue-content">
            <div class="tabs m-pl8 m-pr8">
                <n-tabs type="line" animated class="m-tabs">
              <n-tab-pane name="IssueType" tab="Loại vấn đề">
                <IssueTypeTab></IssueTypeTab
              ></n-tab-pane>
            </n-tabs>
            </div>
          </div>

        </div>
      </div>
    </n-scrollbar>
  </div>
</template>

<style>
.config-issue {
  background-color: #fff;
  margin: 16px 8px;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 8px 0;
  height: calc(100vh - 90px);
}

.post-title {
  font-size: 18px;
  font-family: "GoogleSans-Bold", Roboto, Helvetica, Arial, sans-serif !important;
  color: #3a3a3a;
}

.post-title:hover {
  color: var(--primary-color);
  text-decoration: underline;
  cursor: pointer;
}

.post-sub-title {
  font-family: "GoogleSans-Medium", Roboto, Helvetica, Arial, sans-serif !important;
  font-size: 14px !important;
  color: #aab2bd;
  font-weight: 300;
  padding: 0 8px;
  border-left: 1px solid #aab2bd;
}

.post-sub-title.link:hover {
  color: var(--primary-color);
  cursor: pointer;
}

.post-content-preview {
  font-size: 13px;
  font-weight: lighter;
  color: #555555;
}

.post-content-preview.more {
  color: var(--primary-color);
  cursor: pointer;
}

.list-content {
  padding: 0 48px;
}

</style>
