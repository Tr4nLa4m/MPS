<template>
  <div class="background-image">
    <n-scrollbar x-scrollable>
      <div class="d-flex" style="white-space: nowrap">
        <div class="">
          <div
            ref="column1"
            class="w-[250px] h-[70px] text-white text-xl align-center bg-[#22d3ee] flex justify-evenly items-center"
          >
            <img
              class="w-[30px] h-[30px] ml-[10px]"
              src="@/assets/board/finish_flag.png"
              alt="logo"
            />
            <div class="">Cần thiết</div>
            <img
              class="w-[30px] h-[30px]"
              src="@/assets/board/thunder.png"
              alt="logo"
            />
            <div
              class="w-[30px] h-[30px] flex justify-center items-center rounded-full bg-opacity-50 bg-gray-100"
            >
              2
            </div>
          </div>
          <draggable
            class="list-group bg-opacity-50 bg-gray-100 h-full p-2"
            v-model="columns[0].items"
            :options="draggableOptions"
            group="people"
          >
            <div
              class="list-group-item p-2"
              v-for="(item, itemIndex) in columns[0].items"
              :key="itemIndex"
            >
              <div class="bg-white h-[110px] p-2 rounded-lg">
                <div>{{ item }}</div>
                <br />
                <div class="flex items-center">
                  <img
                    class="w-[30px] h-[30px] ml-[10px]"
                    src="@/assets/board/man.png"
                    alt="logo"
                  />
                  <img
                    class="w-[20px] h-[20px] ml-[10px]"
                    src="@/assets/board/event.png"
                    alt="logo"
                  />
                  <div class="ml-[10px] text-xs">07/06/2023</div>
                </div>
              </div>
            </div>
            <button
              class="w-10 h-10 rounded-full text-2xl bg-white hover:bg-blue-700 m-auto flex items-center justify-center text-[#3b82f6]"
              @click="addItem"
            >
              +
            </button>
          </draggable>
        </div>
        <div>
          <div
            ref="column2"
            class="w-[300px] h-[70px] text-white text-xl align-center bg-[#3b82f6] flex justify-evenly items-center gap-[4px]"
          >
            <img
              class="w-[20px] h-[20px] ml-[10px]"
              src="@/assets/board/email.png"
              alt="logo"
            />
            <div class="mr-[86px]">Đang thực hiện</div>
            <img
              class="w-[30px] h-[30px]"
              src="@/assets/board/thunder.png"
              alt="logo"
            />
          </div>
          <draggable
            class="list-group bg-opacity-50 bg-gray-300 h-full p-2"
            v-model="columns[1].items"
            :options="draggableOptions"
            group="people"
          >
            <div
              class="list-group-item p-2"
              v-for="(item, itemIndex) in columns[1].items"
              :key="itemIndex"
            >
              <div class="bg-white h-[110px] p-2 rounded-lg">
                <div>{{ item }}</div>
                <br />
                <div class="flex items-center">
                  <img
                    class="w-[30px] h-[30px] ml-[10px]"
                    src="@/assets/board/man.png"
                    alt="logo"
                  />
                  <img
                    class="w-[20px] h-[20px] ml-[10px]"
                    src="@/assets/board/event.png"
                    alt="logo"
                  />
                  <div class="ml-[10px] text-xs">07/06/2023</div>
                  <span class="text-xs ml-[20px]">50 %</span>
                </div>
                <div
                  class="flex-wrap flex gap-[4px] items-center pt-[4px]"
                ></div>
              </div>
            </div>
            <button
              class="w-10 h-10 rounded-full text-2xl bg-white hover:bg-blue-700 m-auto flex items-center justify-center text-[#3b82f6]"
              @click="addItem"
            >
              +
            </button>
          </draggable>
        </div>
        <div>
          <div
            ref="column3"
            class="w-[300px] h-[70px] text-white text-xl align-center bg-[#4ade80] flex flex-wrap items-center gap-[4px]"
          >
            <img
              class="w-[20px] h-[20px] ml-[10px] mr-[10px]"
              src="@/assets/board/like.png"
              alt="logo"
            />
            <div class="mr-[86px]">Đã hoàn thành</div>
          </div>
          <draggable
            class="list-group bg-opacity-50 bg-gray-100 h-full p-2"
            v-model="columns[2].items"
            :options="draggableOptions"
            group="people"
          >
            <div
              class="list-group-item p-2"
              v-for="(item, itemIndex) in columns[2].items"
              :key="itemIndex"
            >
              <div class="bg-white h-[110px] p-2 rounded-lg">
                <div>{{ item }}</div>
                <br />
                <div class="flex items-center">
                  <img
                    class="w-[30px] h-[30px] ml-[10px]"
                    src="@/assets/board/man.png"
                    alt="logo"
                  />
                  <img
                    class="w-[20px] h-[20px] ml-[10px]"
                    src="@/assets/board/event.png"
                    alt="logo"
                  />
                  <div class="ml-[10px] text-xs">07/06/2023</div>
                </div>
              </div>
            </div>
            <button
              class="w-10 h-10 rounded-full text-2xl bg-white hover:bg-blue-700 m-auto flex items-center justify-center text-[#3b82f6]"
              @click="addItem"
            >
              +
            </button>
          </draggable>
        </div>
        <div>
          <div
            ref="column4"
            class="w-[300px] h-[70px] text-white text-xl align-center bg-[#059669] flex flex-wrap items-center gap-[4px]"
          >
            <img
              class="w-[20px] h-[20px] ml-[10px] mr-[10px]"
              src="@/assets/board/leaf.png"
              alt="logo"
            />
            <div class="mr-[86px]">Gấp</div>
          </div>
          <draggable
            class="list-group bg-opacity-50 bg-gray-300 h-full p-2"
            v-model="columns[3].items"
            :options="draggableOptions"
            group="people"
            @change="log"
          >
            <div
              class="list-group-item p-2"
              v-for="(item, itemIndex) in columns[3].items"
              :key="itemIndex"
            >
              <div class="bg-white h-[110px] p-2 rounded-lg">
                <div>{{ item }}</div>
                <br />
                <div class="flex items-center">
                  <img
                    class="w-[30px] h-[30px] ml-[10px]"
                    src="@/assets/board/man.png"
                    alt="logo"
                  />
                  <img
                    class="w-[20px] h-[20px] ml-[10px]"
                    src="@/assets/board/event.png"
                    alt="logo"
                  />
                  <div class="ml-[10px] text-xs">07/06/2023</div>
                </div>
              </div>
            </div>
            <button
              class="w-10 h-10 rounded-full text-2xl bg-white hover:bg-blue-700 m-auto flex items-center justify-center text-[#3b82f6]"
              @click="addItem"
            >
              +
            </button>
          </draggable>
        </div>
        <div>
          <div
            class="w-[300px] h-[70px] text-white text-xl align-center bg-[#65a30d] flex flex-wrap items-center gap-[4px]"
          >
            <img
              class="w-[20px] h-[20px] ml-[10px] mr-[10px]"
              src="@/assets/board/add.png"
              alt="logo"
            />
            <div class="mr-[86px]">Thêm công việc</div>
          </div>
        </div>
        <div>
          <div
            class="w-[300px] h-[70px] text-white text-xl align-center bg-[#65a30d] flex flex-wrap items-center gap-[4px]"
          >
            <img
              class="w-[20px] h-[20px] ml-[10px] mr-[10px]"
              src="@/assets/board/add.png"
              alt="logo"
            />
            <div class="mr-[86px]">Thêm công việc</div>
          </div>
        </div>
      </div>
    </n-scrollbar>
  </div>
</template>

<script>
import { defineComponent, onMounted, ref } from "vue";
import { VueDraggableNext } from "vue-draggable-next";
import HeaderLayout from "@/views/layouts/HeaderLayout.vue";

export default defineComponent({
  components: {
    HeaderLayout,
    draggable: VueDraggableNext,
  },
  setup() {
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

    const draggableOptions = {
      group: "itemsGroup",
    };

    const columnRefs = {
      column1: ref(null),
      column2: ref(null),
      column3: ref(null),
      column4: ref(null),
    };

    onMounted(() => {
      const options = {
        group: "itemsGroup",
      };

      for (const refKey in columnRefs) {
        const columnRef = columnRefs[refKey].value;
        if (columnRef) {
          options.el = columnRef;
          options.draggable = ".item";

          const draggableInstance = new Draggable(options);
          draggableInstance.on("sortable:stop", () => {
            const columnIndex = parseInt(refKey.replace("column", "")) - 1;
            columns.value[columnIndex].items = Array.from(
              columnRef.children
            ).map((child) => child.innerText.trim());
          });
        }
      }
    });

    const addItem = () => {
      columns.value[0].items.push("New Item");
    };

    const log = (a, b, x) => {
      console.log(a, b, x);
    };

    return {
      columns,
      draggableOptions,
      columnRefs,
      addItem,
      log,
    };
  },
});
</script>
<style scoped>
.background-image {
  background: url(@/assets/background/dashboard-bg-1.jpg) no-repeat;
  background-size: cover;
  height: 100%;
}
</style>
