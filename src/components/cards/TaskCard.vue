<script setup>
import { defineComponent, computed } from "vue";
import commonFn from "@/utils/helper/commonFn.js";
import MConstant from "@/common/consts/MConstant";

const props = defineProps({
  task: {
    type: Object,
    default: "",
  },
  clickable: {
    type: Boolean,
    default: false,
  },
  itemKey: {
    type: String,
    default: ''
  }
});

const getTaskStatus = computed(() => {
  let task = props.task;
  if (task.Status == MConstant.TaskStatus.NotDone) {
  }
});

const getDeadline = computed(() => {
  let task = props.task;
  let isNotOverDeadline =
    task.Status == 2 && new Date(task.EndDate) <= new Date();
  if (isNotOverDeadline) {
    return false;
  }
  return task.EndDate;
});

const isOverDeadline = computed(() => {
  let task = props.task;
  if (!getDeadline.value) return false;
  let isEndDateOver = new Date(task.EndDate) > new Date();
  return task.Status == MConstant.TaskStatus.NotDone && isEndDateOver;
});

const isDone = computed(
  () => props.task.Status == MConstant.TaskStatus.Done && props.task.Progress == 100
);

const isOverEndDate = computed(() => props.task.EndDate && new Date(props.task.EndDate) < new Date())

const getTaskStatusText = computed(() => {
  if (isOverDeadline.value) {
    return "Quá hạn";
  }
  if (isDone.value) {
    return "Hoàn thành";
  }
});
</script>

<template>
  <div class="task-card" :id="itemKey">
    <div
      class="task-card-header flex-row"
      :class="[isOverDeadline ? 'over-deadline' : '', isDone ? 'done' : '']"
      v-if="getDeadline"
    >
      <div class="card-header-icon">
        <div class="mi-24 mi-calender-circle-img" v-if="isOverDeadline"></div>
        <div class="mi-24 mi-green-done" v-if="isDone"></div>
      </div>

      <div class="card-header-label m-pl8">{{ getTaskStatusText }}</div>
    </div>

    <div class="task-card-body">
      <div class="task-title m-pb16">{{ task.TaskName }}</div>

      <div class="task-assign-info flex-row m-pb16">
        <div class="task-assignee m-mr16">
          <div class="mi-24">
            <img :src="task.PerformerAvatar" alt="avt" class="round" />
          </div>
        </div>

        <div class="flex-row flex-align-center" :class="[isOverEndDate ? 'task-overdeadline' : '']">
          <div class="mi-24 mi-calender-circle-img"></div>
          <div class="text-small m-pl8">
            {{ task.EndDate ? commonFn.formatDate(task.EndDate, true) : '' }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
.task-card {
  border-radius: 8px;
  background-color: #ffffff;
  white-space: initial !important;
}

.task-card-header {
  border-radius: 8px 8px 0 0;
  padding-left: 12px;
  height: 40px;
  display: flex;
  align-items: center;
}

.task-card-header.over-deadline {
  background-color: #ffe6e6 !important;
}

.task-card-header.done {
  background-color: #d8f6db !important;
}

.task-card-header.done .card-header-label {
  color: #35be45;
}

.task-card-header.over-deadline .card-header-label {
  color: #e8384f;
}

.task-card-header.over-deadline .mi-calender-circle-img {
  background-color: #e8384f !important;
}

.task-card-body {
  padding: 12px 12px 0 12px;
}

.task-card-body .mi-calender-circle-img {
  background-color: #666666;
}

.task-overdeadline .mi-calender-circle-img{
  background-color: #e8384f !important;
}

.task-overdeadline .text-small{
  color: #e8384f;
}
</style>
