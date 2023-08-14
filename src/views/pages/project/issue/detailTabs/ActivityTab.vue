<script setup>
import { ModuleIssue, ModuleContext } from "@/store/moduleConstant";
import { useMessages } from "@/utils/uses/base/useMessages";
import { cloneDeep } from "lodash";
import { inject } from "vue";
import { reactive } from "vue";
import { h, ref, computed, onMounted } from "vue";
import { useStore } from "vuex";
import { DEFAULT_PAGE_SIZE } from "@/common/consts/MConstant";
const props = defineProps({
  issueID: {
    type: String,
    default: "",
  },
});

const store = useStore();
const commonFn = inject("CommonFn");
const { error } = useMessages();
const showDetailEl = reactive({});
const employee = computed(() => store.state[ModuleContext]?.employee);
const activities = computed(() => {
  let dataActivity = cloneDeep(store.state[ModuleIssue]?.activities) || [];
  dataActivity.forEach((element) => {
    showDetailEl[element.ActivityID] = false;
  });
  return dataActivity.reverse();
});
const pageSize = DEFAULT_PAGE_SIZE;
const totalPage = computed(() => {
  return Math.ceil(activities.value.length / pageSize);
});
const pageIndex = ref(0);

const getPagingActivity = computed(() => {
  if (activities.value.length === 0) {
    return [];
  }
  let endIndex = activities.value.length;
  let startIndex = pageSize * (totalPage.value - pageIndex.value - 1);

  return activities.value.slice(startIndex, endIndex);
});

const showDetailBtn = computed(() => {
  return (activity) => {
    return commonFn.getShowActivityDetailBtn(activity);
  };
});

onMounted(async () => {
  if (props.issueID) {
    await getActivites();
  }
});

const getActivites = async () => {
  let pamram = {
    data: {
      IssueID: props.issueID,
    },
  };
  await store.dispatch(ModuleIssue + "/getActivities", pamram);
};

const getActivityAvatar = computed(() => (column) => {
  let arr = [
    "Task",
    "Performer",
    "UpdateTaskDeadline",
    "Description",
    "Checklists",
    "Progress",
    "Attachment",
    "TaskComment",
  ];
  if (arr.includes(column)) {
    return column;
  }

  return "Description";
});

const btnMore_click = () => {
  pageIndex.value += 1;
};

const handleShowDetailActivity = (item) => {
  showDetailEl[item.ActivityID] = !showDetailEl[item.ActivityID];
};
</script>

<template>
  <div class="task-activity">
    <div class="task-list-activity">
      <span
        v-if="pageIndex + 1 < totalPage"
        class="text-link-small pointer m-ml8"
        @click="btnMore_click"
        >Xem thêm</span
      >
      <div
        class="activity-card flex-row m-pt8 m-pb8"
        v-for="item in getPagingActivity"
      >
        <div class="activity-avt">
          <div
            :class="[
              'mi-32 m-mr8',
              `mi-task-log-action-${getActivityAvatar(item.Column)}`,
            ]"
          ></div>
        </div>

        <div class="activity-body m-w100">
          <div class="activity-content">
            <div class="activity-main">
              <span class="activity-author-title text-bold">{{
                item.FullName
              }}</span>
              <span> &nbsp;{{ item.ActionText }}</span>
              <span
                v-if="showDetailBtn"
                class="text-link-small pointer m-ml8"
                @click="() => handleShowDetailActivity(item)"
                >Xem chi tiết</span
              >
            </div>

            <n-collapse-transition
              :show="showDetailEl[item.ActivityID]"
              class="activity-detail"
            >
              <div
                class="text-line-throught"
                v-html="commonFn.getIssuekActivityValueText(item, true)"
              ></div>
              <div
                class="text-bold"
                v-html="commonFn.getIssuekActivityValueText(item, false)"
              ></div>
            </n-collapse-transition>
          </div>

          <div class="activity-info">
            <div class="activity-time text-small text-fade">
              <span>{{ commonFn.formatDate(item.CreatedDate) }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style></style>
