<template>
  <div class="background-image">
    <n-scrollbar x-scrollable>
      <div class="d-flex project-board" style="white-space: nowrap">
        <div class="row-group" v-for="(taskGroup, index) in taskGroupsData">
          <div
            ref="column4"
            class="w-[300px] h-[70px] text-white text-large align-center flex flex-wrap items-center gap-[4px]"
            :style="{ backgroundColor: commonFn.getColorTitleBoards(index) }"
          >
            <n-dropdown
              trigger="click"
              :options="dropdownTaskOptions"
              :show-arrow="true"
              @select="(key, option) => handleSelectDropdownTaskGroup(key, option, taskGroup)"
              size="large"
              v-if="!checkInitTaskGroup(taskGroup)"
            >
              <div class="pointer flex-center m-ml8">
                <div class="mi-16 mi-carret-down-white"></div>
              </div>
            </n-dropdown>
            <div class="m-ml8 ellipsis" :class="[checkInitTaskGroup ? 'm-ml16' : '']">{{ taskGroup.TaskGroupName }}</div>
            <div class="flex-1"></div>
            <div
              class="w-[30px] h-[30px] flex justify-center items-center round bg-opacity-30 bg-gray-100 m-mr16"
            >
              {{ taskGroup.Tasks.length }}
            </div>
          </div>

          <n-scrollbar :style="`max-height: ${getMaxHeight}px`">
            <div class="row-drag-content">
              <VueDraggableNext
                class="list-group bg-opacity-30 h-full p-2"
                :class="[index % 2 == 0 ? '' : 'bg-gray-100']"
                v-model="taskGroup.Tasks"
                :options="draggableOptions"
                group="people"
                :item-key="taskGroup.TaskGroupID"
                @add="handleOnAddItem"
              >
                <TaskCard
                  class="list-group-item m-mb8 pointer"
                  v-for="(item, itemIndex) in taskGroup.Tasks"
                  :key="itemIndex"
                  :task="item"
                  :item-key="item.TaskID"
                  @click="(e) => cardTask_click(e, item)"
                >
                </TaskCard>
                <button
                  class="w-10 h-10 rounded-full text-2xl bg-white hover:bg-blue-700 m-auto flex items-center justify-center text-[#3b82f6]"
                  @click="addItem"
                >
                  +
                </button>
              </VueDraggableNext>
            </div>
          </n-scrollbar>
        </div>

        <div class="row-group">
          <div
            class="w-[300px] h-[70px] text-white text-large align-center bg-[#ffffff] flex flex-wrap items-center pointer"
            @click="btnAddTaskGroup_click"
          >
            <div class="m-ml16">
              <div class="mi-24 mi-plus-blue"></div>
            </div>
            <div class="m-mr16 text-primary">Thêm nhóm công việc</div>
          </div>
        </div>
      </div>
    </n-scrollbar>
  </div>
</template>

<script setup>
import { defineComponent, onMounted, ref, h, computed } from "vue";
import { VueDraggableNext } from "vue-draggable-next";
import HeaderLayout from "@/views/layouts/HeaderLayout.vue";
import TaskCard from "@/components/cards/TaskCard.vue";
import { useStore } from "vuex";
import { useModal } from "vue-final-modal";
import TaskView from "@/components/popup/form/TaskView.vue";
import {
  ModuleProject,
  ModuleContext,
  ModuleTask,
  ModuleEmployee,
} from "@/store/moduleConstant";
import { useRoute } from "vue-router";
import commonFn from "@/utils/helper/commonFn";
import { cloneDeep } from "lodash";
import { pProps } from "naive-ui";
import { useMessages } from "@/utils/uses/base/useMessages";
import AddTaskGroup from "@/components/popup/form/AddTaskGroup.vue";
import MConstant from "@/common/consts/MConstant";

const store = useStore();
const route = useRoute();
const { success, error } = useMessages();

const taskData = ref([]);

const taskGroupsData = ref([]);

const currentTaskGroup = ref({});

const columns = ref([
  { title: "Cần thiết", color: "", icon: "", items: ["Chạy hệ thống"] },
  { title: "Đang thực hiên", color: "", items: ["Test"] },
  {
    title: "Đã hoàn thành",
    color: "",
    items: ["Item 7", "Item 8", "Item 9"],
  },
  { title: "Gấp", color: "", items: ["Item 10", "Item 11", "Item 12"] },
  {
    title: "Thêm công việc",
    color: "",
    items: ["Item 10", "Item 11", "Item 12"],
  },
]);

const dropdownTaskOptions = [
  {
    label: () => h("div", { class: "" }, "Sửa"),
    key: "key_edit",
  },
  {
    label: () => h("div", { class: "danger" }, "Xoá"),
    key: "key_delete",
  },
];

const draggableOptions = {
  group: "itemsGroup",
};

const getMaxHeight = computed(() => {
  let maxHeight = window.innerHeight - 56 - 70;
  return maxHeight;
});

const checkInitTaskGroup = computed(() => (taskGroup) => {
  let initTaskGroupName = ['Cần thực hiện', 'Đang thực hiện', 'Đã hoàn thành'];
  return initTaskGroupName.includes(taskGroup.TaskGroupName);
});

const taskGroupModal = useModal({
  component: AddTaskGroup,
  attrs: {
    mode: MConstant.FormMode.Add,
    taskGroup: currentTaskGroup,

    onCloseModal() {
      taskGroupModal.close();
    },
    async onUpdated() {
      await getTaskByTaskGroups();
      bindMasterData();
    },
  },
});

onMounted(async () => {
  await getTaskByTaskGroups();
  bindMasterData();
});

const getTaskByTaskGroups = async () => {
  let param = {
    data: {
      ProjectID: route.params.ProjectID,
    },
  };

  taskData.value = await store.dispatch(
    ModuleTask + "/getTaskByTaskGroups",
    param
  );
};

const bindMasterData = () => {
  taskGroupsData.value = commonFn.getTaskGroupTask(cloneDeep(taskData.value));
};

const handleOnAddItem = async (event) => {
  let fromDrag = event.from;
  let toDrag = event.to;
  let taskID = event.item.id;

  let oldTaskGroupID = fromDrag[Object.keys(fromDrag)[0]].options.itemKey;
  let newTaskGroupID = toDrag[Object.keys(toDrag)[0]].options.itemKey;

  let oldTaskGroup = taskGroupsData.value.find(
    (taskgroup) => taskgroup.TaskGroupID == oldTaskGroupID
  );
  let newTaskGroup = taskGroupsData.value.find(
    (taskgroup) => taskgroup.TaskGroupID == newTaskGroupID
  );

  let onFailure = async () => {
    error("Có lỗi xảy ra");
    await getTaskByTaskGroups();
    bindMasterData();
  };
  let onSuccess = () => success("Cập nhật công việc thành công");

  let param = {
    data: {
      OldTaskGroupID: oldTaskGroupID,
      NewTaskGroupID: newTaskGroupID,
      TaskID: taskID,
    },
    onFailure,
    onSuccess,
  };

  await store.dispatch(ModuleTask + "/updateTaskGroupTask", param);

  let task = newTaskGroup.Tasks.find((item) => item.TaskID == taskID);
};

const deleteTaskGroup = async(taskgroup) => {
  if(taskgroup.Tasks.length > 0){
    error('Nhóm công việc đang được sử dụng. Bạn không thể xoá nhóm công việc này');
    return;
  }
  let param = {
    data: {
      TaskGroupID: taskgroup.TaskGroupID
    },
    onSuccess: () => success('Xoá nhóm công việc thành công'),
    onFailure: () => error('Xoá nhóm công việc không thành công')
  }

  await store.dispatch(ModuleTask + '/deleteTaskGroup', param);

  await getTaskByTaskGroups();
  bindMasterData();
}

const btnAddTaskGroup_click = () => {
  taskGroupModal.patchOptions({
    attrs: {
      mode: MConstant.FormMode.Add,
    },
  });
  taskGroupModal.open();
};

const addItem = () => {
  columns.value[0].items.push("New Item");
};

const handleSelectDropdownTaskGroup = async (key, option, taskgroup) => {
  if(key == "key_delete"){
    await deleteTaskGroup(taskgroup);
  }
  
  if(key == "key_edit"){
    taskGroupModal.patchOptions({
      attrs: {
        mode: MConstant.FormMode.Edit,
        taskGroup: taskgroup
      }
    });

    taskGroupModal.open();
  }
}

const taskViewModal = useModal({
  component: TaskView,
  attrs: {
    async onCloseModal(isEdited) {
      if (isEdited) {
      }
      taskViewModal.close();
    },

    async onDeleteTask(isEdited) {
      taskViewModal.close();
    },

    TaskID: null,
  },
});

const cardTask_click = (e, task) => {
  debugger
  taskViewModal.patchOptions({
    attrs: {
      TaskID: task.TaskID
    }
  });

  taskViewModal.open();
}
</script>
<style scoped>
.background-image {
  background: url(@/assets/background/dashboard-bg-1.jpg) no-repeat;
  background-size: cover;
  height: 100%;
}

.row-group {
  width: 300px;
}

.row-group .row-drag-content {
  height: calc(100vh - 56px - 70px);
}
</style>
