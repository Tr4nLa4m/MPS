<script setup>
import {
  DxPieChart,
  DxSeries,
  DxExport,
  DxTooltip,
  DxLegend,
  DxHoverStyle,
  DxLabel,
  DxConnector,
} from "devextreme-vue/pie-chart";
import commonFn from "@/utils/helper/commonFn";
import TemplateCenter from "@/views/pages/project/report/templates/TemplateCenterLabel.vue";
import { useStore } from "vuex";
import { ref, reactive, computed } from "vue";
import { onMounted } from "vue";
import { useRoute } from "vue-router";
import { ModuleProject } from "@/store/moduleConstant";
import ListTaskStatusReport from "@/components/popup/form/report/ListTaskStatusReport.vue";
import { useModal } from "vue-final-modal";
import ListTaskGroupReport from "@/components/popup/form/report/ListTaskGroupReport.vue";

const store = useStore();
const route = useRoute();
const REPORT_TASK_STATUS = "task_status";
const REPORT_TASK_GROUP = "task_group";
const reportData = reactive({
  Data: {},
});
const currentTargetStatus = ref(1);
const currentTargetGroup = ref('');
const dateInfo = reactive({
  EarliestStartDate: '',
  LatestEndDate: ''
})

const reportTaskGroupData = reactive({
  Data: [],
});

const currentReportKey = ref("task_status");

const detailListTaskStatusModal = useModal({
  component: ListTaskStatusReport,
  attrs: {
    data: reportData,
    initTab: currentTargetStatus,
    onCloseModal() {
      detailListTaskStatusModal.close();
    },
  },
});

const detailListTaskGroupModal = useModal({
  component: ListTaskGroupReport,
  attrs: {
    data: reportTaskGroupData,
    initTab: currentTargetGroup,
    dateInfo: dateInfo,
    onCloseModal() {
      detailListTaskGroupModal.close();
    },
  },
});

const dropdownSelectReportOptions = [
  {
    label: "Trạng thái công việc",
    key: REPORT_TASK_STATUS,
  },
  {
    label: "Loại công việc",
    key: REPORT_TASK_GROUP,
  },
];

const getCurrentReport = computed(() => {
  let report = dropdownSelectReportOptions.find(
    (item) => item.key == currentReportKey.value
  );
  if (report) {
    return report.label;
  }

  return "";
});

const getProgressTask = computed(() => {
  let numTaskDone = reportData.Data.NumTaskDone || 0;
  let numTaskDoneOverDeadline = reportData.Data.NumTaskDoneOverDeadline || 0;
  let total = reportData.Data.NumTask || 0;
  if (total == 0) {
    return 0;
  }

  return ((numTaskDone + numTaskDoneOverDeadline) / total) * 100;
});

const getProgressDate = computed(() => {
  if (!reportData.Data.EarliestStartDate) {
    return null;
  }
  debugger;
  if (!reportData.Data.LatestEndDate) {
    return null;
  }

  let rangeProjectTask =
    new Date(reportData.Data.LatestEndDate).getTime() -
    new Date(reportData.Data.EarliestStartDate).getTime();
  let todayRange =
    new Date().getTime() -
    new Date(reportData.Data.EarliestStartDate).getTime();

  if (!rangeProjectTask || rangeProjectTask <= 0) {
    return null;
  }

  return (todayRange / rangeProjectTask) * 100;
});

const getReportTaskStatusData = computed(() => {
  let data = [];
  data.push({
    type: "Hoàn thành trước hạn",
    value: reportData.Data.NumTaskDone || 0,
    key: 5,
  });
  data.push({
    type: "Hoàn thành quá hạn",
    value: reportData.Data.NumTaskDoneOverDeadline || 0,
    key: 6,
  });
  data.push({
    type: "Chưa hoàn thành",
    value: reportData.Data.NumTaskNotDone || 0,
    key: 4,
  });
  data.push({
    type: "Trễ hạn",
    value: reportData.Data.NumTaskNotDoneOverDeadline || 0,
    key: 7,
  });

  return data;
});

const getReportTaskGroupData = computed(() => {
  let data = reportTaskGroupData.Data || [];
  if (data.length == 0) {
    return data;
  }
  return data.map((item) => {
    return {
      label: item.TaskGroupName,
      value: item.TotalTasks,
      key: item.TaskGroupID,
    };
  });
});

onMounted(async () => {
  await getReportData();
});

const getReportData = async () => {
  let param = {
    data: {
      ProjectID: route.params.ProjectID,
    },
  };

  let reportAction = "/getNumberTaskStatusReport";
  if (currentReportKey.value == REPORT_TASK_GROUP) {
    reportAction = "/getNumberTaskGroupReport";
    reportTaskGroupData.Data = await store.dispatch(
      ModuleProject + reportAction,
      param
    );

    return;
  }

  reportData.Data = await store.dispatch(ModuleProject + reportAction, param);

  bindDateInfo(reportData.Data);
  
}

const bindDateInfo = (data) => {
  dateInfo.EarliestStartDate = data.EarliestStartDate;
  dateInfo.LatestEndDate = data.LatestEndDate;
}

const customizeTooltip = ({ valueText, percent }) => {
  return `${percent} - ${valueText} công việc`;
};

const pointReportTaskStatus_click = ({ target }) => {
  currentTargetStatus.value = target.data.key;
  detailListTaskStatusModal.open();
};

const pointReportTaskGroup_click = ({ target }) => {
  currentTargetGroup.value = target.data.key;
  detailListTaskGroupModal.open();
};

const btnReport_click = async (key, options) => {
  if (key == currentReportKey.value) {
    return;
  }

  let report = dropdownSelectReportOptions.find((item) => item.key == key);
  if (report) {
    currentReportKey.value = report.key;
    await getReportData();
  }
};
</script>

<template>
  <div class="tab-content">
    <div class="report-label m-pl16 m-pr16 m-pt8 m-pb16">
      <div class="text-large">Báo cáo tổng quan dự án</div>
    </div>

    <n-scrollbar :style="`max-height: 600px`">
      <div class="report-content">
        <div class="report-toolbar m-pl16">
          <div class="">
            <div class="fit-content">
              <n-dropdown
                trigger="click"
                :options="dropdownSelectReportOptions"
                :show-arrow="true"
                @select="btnReport_click"
              >
                <div class="flex-row flex-align-center pointer">
                  <div class="title-filter title-m m-pr8">
                    {{ getCurrentReport }}
                  </div>
                  <div class="mi-24 mi-arrow-bottom"></div>
                </div>
              </n-dropdown>
            </div>

            <div class="title">
              {{
                `${commonFn.formatDate(
                  reportData.Data?.EarliestStartDate,
                  true
                )} - ${commonFn.formatDate(
                  reportData.Data?.LatestEndDate,
                  true
                )}`
              }}
            </div>
          </div>
        </div>
        <div class="report-pie-chart">
          <DxPieChart
            v-if="currentReportKey == REPORT_TASK_STATUS"
            id="pieChart"
            :key="'report-task-status'"
            :data-source="getReportTaskStatusData"
            :inner-radius="0.75"
            resolve-label-overlapping="shift"
            size-group="piesGroup"
            type="doughnut"
            center-template="centerTemplate"
            @point-click="pointReportTaskStatus_click"
          >
            <DxSeries argument-field="type" value-field="value">
              <DxHoverStyle color="#ffd700" />
            </DxSeries>
            <DxLegend
              :margin="16"
              horizontal-alignment="right"
              vertical-alignment="top"
            />
            <DxTooltip
              :enabled="true"
              :customize-tooltip="customizeTooltip"
            ></DxTooltip>
            <template #centerTemplate="data">
              <TemplateCenter :pie-chart="data.data" />
            </template>
          </DxPieChart>

          <DxPieChart
            v-if="currentReportKey == REPORT_TASK_GROUP"
            id="pieChart"
            :key="'report-task-group'"
            :data-source="getReportTaskGroupData"
            :inner-radius="0.75"
            resolve-label-overlapping="shift"
            size-group="piesGroup"
            type="doughnut"
            center-template="centerTemplate"
            @point-click="pointReportTaskGroup_click"
          >
            <DxSeries argument-field="label" value-field="value">
              <DxHoverStyle color="#ffd700" />
            </DxSeries>
            <DxLegend
              :margin="16"
              horizontal-alignment="right"
              vertical-alignment="top"
            />
            <DxTooltip
              :enabled="true"
              :customize-tooltip="customizeTooltip"
            ></DxTooltip>
            <template #centerTemplate="data">
              <TemplateCenter :pie-chart="data.data" />
            </template>
          </DxPieChart>
        </div>

        <div class="report-progress">
          <div class="" id="myProgress">
            <div class="" id="divBorder1"></div>

            <div
              class=""
              id="myBar"
              :style="{ width: getProgressTask + '%' }"
            ></div>

            <div class="date-percent" :style="{ left: getProgressDate + '%' }">
              <div class="today">Hôm nay</div>
            </div>

            <div class="" id="divBorder2"></div>
          </div>

          <div class="textProgressStart">
            <p>Bắt đầu</p>
          </div>

          <div class="textProgressEnd">
            <p>Kết thúc</p>
          </div>
        </div>
      </div>
    </n-scrollbar>
  </div>
</template>

<style>
.report-content {
  padding: 16px;
}
#pieChart {
  width: 100%;
  height: 360px;
}

.report-progress {
  display: flex;
  position: relative;
  width: 400px;
  height: 40px;
  left: 44%;
  transform: translateX(-50%);
  margin-top: 36px;
}

.report-progress #myProgress {
  position: absolute;
  left: 48%;
  transform: translateX(-50%);
  width: calc(100% - 30px);
  height: 8px;
  background-color: #ebeef1;
  margin-top: 5px;
}

.report-progress #myProgress #divBorder1 {
  display: inline-block;
  position: absolute;
  left: -19px;
  bottom: -5px;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: var(--primary-color);
}

.report-progress #myProgress #myBar {
  width: 0%;
  height: 8px;
  background-color: var(--primary-color);
}

.date-percent {
  position: absolute;
  top: -5px;
  transform: translate(-50%);
  background-color: #052946;
  border-radius: 1px;
  width: 2px;
  height: 20px;
  z-index: 2;
}

.date-percent .today {
  position: absolute;
  top: -155%;
  transform: translateX(-44%);
  width: 60px;
  display: inline-block;
  font-size: 15px !important;
  color: #1f1f1f;
  white-space: nowrap;
}

#divBorder2 {
  position: absolute;
  right: -19px;
  bottom: -5px;
  display: inline-block;
  width: 20px;
  height: 20px;
  background: #ebeef1;
  border-radius: 50%;
}

.textProgressStart {
  position: absolute;
  bottom: -4px;
  left: -15px;
}

.textProgressEnd {
  position: absolute;
  bottom: -4px;
  right: -20px;
}
</style>
