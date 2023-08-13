<script setup>
import { ModuleProject } from "@/store/moduleConstant";
import models from "@/utils/helper/models";
import {
  DxChart,
  DxSeries,
  DxCommonSeriesSettings,
  DxValueAxis,
  DxTitle,
  DxLegend,
  DxExport,
  DxTooltip,
} from "devextreme-vue/chart";
import { ref, computed, onMounted, reactive } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";

const store = useStore();
const route = useRoute();
const reportData = ref([]);
const reportParam = reactive(models.createTaskStatusByEmployeeReportParam());


// const filterDateOptions = getFilterDateOptions();

const reportBars = [
  {
    name: "Đã hoàn thành",
    value: "NumTaskDone",
    color: "#1db2f5",
  },
  {
    name: "Chưa hoàn thành",
    value: "NumTaskNotDone",
    color: "#8DA3A6",
  },
];

onMounted(async () => {
  bindInitMasterParam();

  await getReportData();
});

const getReportData = async () => {
  let param = {
    data: reportParam,
  };

  reportData.value = await store.dispatch(
    ModuleProject + "/getNumberTaskStatusByAssigneeReport",
    param
  );
};

const bindInitMasterParam = () => {
  reportParam.ProjectID = route.params.ProjectID;
  reportParam.StartDate = new Date("2020-01-01");
  reportParam.EndDate = new Date("2024-01-01");
};

const customizeTooltip = (pointInfo) => {
  return {
    text: `${pointInfo.seriesName}: ${pointInfo.valueText}`,
  };
};
</script>

<template>
  <div class="tab-content">
    <div class="report-label m-pl16 m-pr16 m-pt8 m-pb16">
      <div class="text-large">
        Báo cáo số lượng công việc theo người thực hiện
      </div>
    </div>

    <n-scrollbar :style="`max-height: 600px`">
      <div class="report-content">
        <div class="report-toolbar m-pl16">
          <div class="">
            <div class="fit-content">
              <!-- <n-select
                class="m-select employee-permission"
                :disabled="item.default"
                v-model:value="item.PermissionGroupID"
                :options="defaultPermissionGroups"
                label-field="PermissionGroupName"
                value-field="PermissionGroupID"
                placeholder="Quyền hạn"
              /> -->
            </div>
          </div>
        </div>

        <div class="report-stackedbar-chart m-pl16 m-pr16">
          <DxChart id="chart" :data-source="reportData" :rotated="true">
            <DxCommonSeriesSettings
              argument-field="FullName"
              type="stackedbar"
            />
            <DxValueAxis position="right">
              <DxTitle text="công việc" />
            </DxValueAxis>
            <DxSeries
              :barWidth="50"
              v-for="item in reportBars"
              :value-field="item.value"
              :name="item.name"
              :color="item.color"
            />
            <DxLegend
              vertical-alignment="bottom"
              horizontal-alignment="center"
              item-text-position="top"
            />
            <DxExport :enabled="false" />
            <DxTooltip
              :enabled="true"
              :customize-tooltip="customizeTooltip"
              location="center"
            />
          </DxChart>
        </div>
      </div>
    </n-scrollbar>
  </div>
</template>
