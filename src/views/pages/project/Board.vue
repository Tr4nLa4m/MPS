<template>
  <div class="background-image d-flex flex-wrap">
    <div class="col-3" v-for="(item, index) in columns" :key="index">
      <div ref="column1"
          class="w-[250px] h-[70px] text-white text-xl align-center flex items-center gap-[10px]" :style="{backgroundColor: item.color}">
        <img v-if="item.id !== 5" class="w-[20px] h-[20px] ml-[10px]" :src="item.icon" alt="logo"/>
        <img v-else class="w-[20px] h-[20px] ml-[10px]" :src="item.icon" alt="logo" @click="handleImageClick"/>
        <div class="">{{ item.title }}</div>
        <img v-if="item.icon2" class="w-[20px] h-[20px]" :src="item.icon2" alt="logo"/>
        <div v-if="item.id === 1" class="w-[30px] h-[30px] flex justify-center items-center rounded-full bg-opacity-50 bg-gray-100 ml-[30px]">2</div>
      </div>
      <draggable class="list-group bg-opacity-50 bg-gray-100 h-full p-2"  v-model="item.items" :options="draggableOptions" @start="handleDragStart" @end="handleDragEnd" group="people">
        <div
            class="list-group-item p-2"
            v-for="(item, itemIndex) in item.items" :key="itemIndex"
        >
          <div class="bg-white h-[110px] p-2 rounded-lg">
            <div> {{ item }}</div>
            <br>
            <div class="flex items-center">
              <img class="w-[30px] h-[30px] ml-[10px]" src="@/assets/board/man.png" alt="logo"/>
              <img class="w-[20px] h-[20px] ml-[10px]" src="@/assets/board/event.png" alt="logo"/>
              <div class="ml-[10px] text-xs">07/06/2023</div>
            </div>
          </div>
        </div>
        <button v-if="item.id !== 5"
            class="w-10 h-10 rounded-full text-2xl bg-white hover:bg-blue-700 m-auto flex items-center justify-center text-[#3b82f6]" @click="addItem(index)">
          +
        </button>
      </draggable>
    </div>
  </div>
</template>

<script>
import {defineComponent, onMounted, ref } from 'vue'
import {VueDraggableNext} from 'vue-draggable-next'
import HeaderLayout from "@/views/layouts/HeaderLayout.vue";

export default defineComponent({
  components: {
    HeaderLayout,
    draggable: VueDraggableNext,
  },
  setup() {
    const sourceGroup = ref(null)
    const targetGroup = ref(null)
    const columns = ref([
      { id: 1, title: 'Cần thiết', color: '#22d3ee', icon: '/src/assets/board/finish_flag.png', icon2: '/src/assets/board/thunder.png', items: ['Chạy hệ thống'] },
      { id: 2, title: 'Đang thực hiên', color: '#3b82f6', icon: '/src/assets/board/email.png', icon2: '/src/assets/board/thunder.png', items: ['Test'] },
      { id: 3, title: 'Đã hoàn thành', color: '#4ade80', icon: '/src/assets/board/like.png', items: [] },
      { id: 4, title: 'Gấp', color: '#059669', icon: '/src/assets/board/leaf.png', items: [] },
      { id: 5, title: 'Thêm công việc', color: '#65a30d', icon: '/src/assets/board/add.png', items: [] },
    ]);

    const draggableOptions = {
      group: 'itemsGroup',
    };

    const columnRefs = {
      column1: ref(null),
      column2: ref(null),
      column3: ref(null),
      column4: ref(null),
    };

    const addItem = (index) => {
      columns.value[index].items.push('New Item');
    };

    const handleImageClick = (item) => {
      columns.value.push({
        title: 'Công việc mới', color: '#0fe18c', icon: '/src/assets/board/add.png', items: []
      });
      console.log('Clicked item:', item);
    }

    const handleDragStart = (event) => {
      console.log('Drag started:', event)
    }

    const handleDragEnd = (event) => {
      console.log('Drag ended:', event)
    }

    return {
      columns,
      draggableOptions,
      columnRefs,
      addItem,
      handleImageClick,
      handleDragStart,
      handleDragEnd
    }
  }
})
</script>
<style scoped>
.background-image {
  background: url(@/assets/background/dashboard-bg-1.jpg) no-repeat;
  background-size: cover;
  height: 100%;
}
</style>