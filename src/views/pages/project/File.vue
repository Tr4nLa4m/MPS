<script setup>
import { defineComponent, h, ref, reactive, computed } from "vue";
import { useMessages } from "@/utils/uses/base/useMessages";
import { useStore } from "vuex";
import models from "@/utils/helper/models";
import { onMounted } from "vue";
import { useRoute } from "vue-router";
import { ModuleContext, ModuleFile, ModuleProject } from "@/store/moduleConstant";
import { cloneDeep } from "lodash";
import EmployeeCard from "@/components/cards/Employee.vue";
import FileCard from "@/components/cards/FileCard.vue";
import commonFn from "@/utils/helper/commonFn.js";
import { useUploadFile } from "@/utils/uses/base/useUploadFile";

const store = useStore();
const route = useRoute();
const { success, error } = useMessages();
const employee = computed(() => store.state[ModuleContext]?.employee);
const masterData = reactive({
  Data: [],
  TotalRecord: 0,
});
const masterParam = reactive(models.createGetPagingFileProjectParam());

const listFile = ref([]);

const initFileTab = [
  {
    name: "Chung",
    key: "General",
    FileType: 0,
  },
  {
    name: "Công việc",
    key: "Task",
    FileType: 1,
  },
  {
    name: "Vấn đề",
    key: "Issue",
    FileType: 2,
  },
];

const handleAttachFile = async (file, response) => {
  let projectFile = cloneDeep(file);
  projectFile["ProjectID"] = route.params.ProjectID;
  projectFile["CreatedBy"] = employee.value.EmployeeCode;

  let param = {
    data: projectFile,
    onSuccess: async () => {
      success("Tải lên file thành công");
      await getData();
    },
    onFailure: () => error("Tải lên file không thành công"),
  };

  await store.dispatch(ModuleProject + "/uploadFile", param);
};

const methodsHandleFile = {
  onFinish: handleAttachFile,
};

const {
  UPLOAD_DOMAIN,
  beforeUploadFile,
  finishUploadFile,
  errorUploadFile,
  removeFile,
} = useUploadFile({}, methodsHandleFile);

const currentTabName = ref(initFileTab[0].name);

const getShowBtnUpload = computed(
  () => currentTabName.value == initFileTab[0].name
);

const columns = ref([
  {
    type: "selection",
  },
  {
    title: "Tên tài liệu",
    key: "FileName",
    width: 250,
    resizable: true,
    ellipsis: true,
    render(row, index) {
      const item = {
        Avatar: row.Url,
        Name: row.FileName,
        Type: row.Type,
      };
      const clickr = () => {};
      return h(FileCard, {
        onClick: clickr,
        item: item,
        class: "m-w100",
      });
    },
  },
  {
    title: "Công việc",
    key: "TaskName",
    width: 250,
    cellProps: (row, index) => {
      return {
        style: "cursor: pointer;",
        onClick: () => {
          openTaskView(row.TaskID);
        },
      };
    },
  },
  {
    title: "Vấn đề",
    key: "IssueName",
    width: 250,
  },
  {
    title: "Người tải lên",
    key: "FullName",
    render(row, index) {
      const item = {
        Avatar: row.Avatar,
        FullName: row.FullName,
      };
      const clickr = () => {};
      return h(EmployeeCard, {
        onClick: clickr,
        clickable: true,
        item: item,
        class: "m-w100",
      });
    },
    width: 130,
  },

  {
    title: "Ngày tài lên",
    key: "CreateDate",
    width: 120,
    render(row, index) {
      let value = row.CreateDate ? commonFn.formatDate(row.CreateDate) : null;
      return h("div", value);
    },
  },

  {
    title: "Dung lượng",
    key: "Size",
    width: 80,
    render(row, index) {
      let value = commonFn.convertToMB(row.Size);
      return h("div", value);
    },
  },
]);

const rowKey = (row) => {
  return row.FileID;
};

const getColumns = computed(() => {
  let res = cloneDeep(columns.value);

  switch (currentTabName.value) {
    case initFileTab[1].name:
      res = res.filter((item) => item.key != "IssueName");
      break;
    case initFileTab[2].name:
      res = res.filter((item) => item.key != "TaskName");
      break;
    default:
      res = res.filter(
        (item) => item.key != "IssueName" && item.key != "TaskName"
      );
      break;
  }

  return res;
});

const getFileType = computed(() => {
  let tab = initFileTab.find((tab) => tab.name == currentTabName.value);
  if (tab) {
    return tab.FileType;
  }
  return 0;
});

onMounted(async () => {
  initMasterParam();

  await getData();
});

const getData = async () => {
  let param = {
    data: masterParam,
    onFailure: () => error("Có lỗi xảy ra"),
  };

  let res = await store.dispatch(ModuleProject + "/getFilePaging", param);
  masterData.Data = res.data;
  masterData.TotalRecord = res.totalRecord;
};

const initMasterParam = () => {
  masterParam.ProjectID = route.params.ProjectID;
  masterParam.FileType = 0;
  masterParam.PageIndex = 1;
  masterParam.PageSize = 10;
  masterParam.EmployeeID = employee.value.EmployeeID;
};

const btnTab_click = async (tabName) => {
  let tab = initFileTab.find((tab) => tab.name == tabName);
  masterParam.KeySearch = "";
  masterParam.FileType = tab.FileType;

  await getData();
};

const handleChooseFile = (rowKeys) => {
  let files = masterData.Data.filter((item) => rowKeys.includes(item.FileID));
  listFile.value = files;
  console.log(files);
};

const handleSearch = async () => {
  await getData();
};

const btnDeleteFiles_click = async () => {
  let listFileIds = listFile.value.map((file) => file.FileID);
  let param = {
    data: {
      FileIDs: listFileIds,
      FileType: getFileType.value,
      ProjectID: route.params.ProjectID,
    },
    onSuccess: async () => {
      success("Xoá tài liệu thành công");
      await getData();
    },
    onFailure: () => error("Có lỗi xảy ra"),
  };

  await store.dispatch(ModuleProject + "/deleteFiles", param);
};

const btnDownload_click = async () => {
  let listFileName = listFile.value.map((file) => file.OriginalName);
  for (const fileName of listFileName) {
    await downloadFile(fileName);
  }
};

const downloadFile = async (fileName) => {
  try {
    let param = {
      data: {
        FileName: fileName
      },
    }
    const response = await store.dispatch(ModuleFile + '/download', param);
    // const contentType = response.headers.get('content-type');
    const blob = new Blob([response.data]);
    const filename = fileName;
    const link = document.createElement("a");
    link.href = URL.createObjectURL(blob);
    link.download = filename;
    link.click();
    URL.revokeObjectURL(link.href);
  } catch (error) {
    console.error("Error downloading file:", error);
  }
};
</script>

<template>
  <div class="project-container project-content-wrapper m-p16">
    <div class="file-list-header flex-row line-bottom m-pb8">
      <div class="flex-row flex-align-center">
        <div class="m-mr16">
          <n-tabs
            type="bar"
            animated
            class="m-tabs"
            v-model:value="currentTabName"
            @update:value="btnTab_click"
          >
            <n-tab
              v-for="tab in initFileTab"
              :key="tab.key"
              :name="tab.name"
            ></n-tab>
          </n-tabs>
        </div>

        <MIconInput
          :placeholder="'Tìm kiếm'"
          :iconLeft="'mi-18 mi-search-before'"
          :customClass="'m-m0'"
          :inputClass="'no-border'"
          v-model="masterParam.KeySearch"
          :submitOnKeydown="true"
          @onEnter="handleSearch"
          @onIconClick="handleSearch"
        />
      </div>

      <div class="flex-row flex-align-center m-ml80" v-if="listFile.length > 0">
        <div class="m-mr32">
          <span class="text-bold">{{ listFile.length }}</span>
          Đang chọn
        </div>

        <div class="flex-row">
          <MButton
            :text="'Tải xuống'"
            :title="'Tải xuống tài liệu'"
            :classCustom="'m-button-l m-btn-secondary m-mr8'"
            :classText="'m-mr8 m-ml8'"
            @click="btnDownload_click"
          />

          <MButton
            :text="'Xoá'"
            :title="'Xoá tài liệu'"
            :classCustom="'m-button-l btn-danger m-mr8'"
            :classText="'m-mr8 m-ml8'"
            @click="btnDeleteFiles_click"
          />
        </div>
      </div>

      <div class="flex-1"></div>

      <div class="flex-row">
        <n-upload
          :action="UPLOAD_DOMAIN"
          :show-file-list="false"
          @finish="finishUploadFile"
          @beforeUpload="beforeUploadFile"
          @error="errorUploadFile"
          @remove="removeFile"
        >
          <MButton
            v-if="getShowBtnUpload"
            :text="'Tải lên tài liệu'"
            :title="'Tải lên tài liệu'"
            :classCustom="'m-button-l m-btn-secondary m-mr8'"
            :classText="'m-mr8 m-ml8'"
          />
        </n-upload>
      </div>
    </div>

    <div class="file-list-content">
      <div class="data-table">
        <n-data-table
          id="resizeMe"
          class="text-medium table-2"
          :columns="getColumns"
          :data="masterData.Data"
          :max-height="466"
          :min-height="460"
          :row-key="rowKey"
          :single-line="false"
          @update:checked-row-keys="handleChooseFile"
        />

        <div class="m-pt8 m-pl16 m-pr16 flex-row flex-align-center">
          <div class="">
            Tổng cộng :
            <span class="text-bold">{{ masterData.TotalRecord }}</span>
            bản ghi
          </div>

          <div class="flex-1"></div>

          <n-pagination
            v-model:page="masterParam.PageIndex"
            v-model:item-count="masterData.TotalRecord"
            :page-size="masterParam.PageSize"
            :on-update:page="onPage_change"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.project-content-wrapper {
  background: #fff;
  margin: 16px;
  position: absolute;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 8px 0;
  height: calc(100vh - 90px);
  width: calc(100vw - 32px);
}
</style>
