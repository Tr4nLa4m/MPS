<template>
  <aside
    class="m-sidebar"
    :style="{ minWidth: sidebarWidth + 'px', width: '10px' }"
  >
    <div v-show="!isCollapseSidebar">
      <slot name="default"></slot>
    </div>

    <div class="split-bar" id="m-split-bar">
      <div
        class="hidden-sidebar flex-center pointer"
        :class="[isCollapseSidebar ? 'show-sidebar' : '']"
        @click="btnCollapseSidebar_click"
      >
        <div
          class="mi-16"
          :class="[
            isCollapseSidebar
              ? 'mi-carret-right-white'
              : 'mi-carret-left-white',
          ]"
        ></div>
      </div>
    </div>
  </aside>
</template>

<script setup>
import { ModuleConfig } from "@/store/moduleConstant";
import { ref, computed, nextTick } from "vue";
import { useStore } from "vuex";

const store = useStore();
const emits = defineEmits(["collapse"]);

const props = defineProps({
  enableSidebarClick: false,
  minWidth: {
    type: Number, 
    default: 260
  }
});



const collapseMinWidth = 10;
const initMinWidth = props.minWidth;
const isCollapseSidebar = ref(false);
const sidebarWidth = ref(initMinWidth);

const btnCollapseSidebar_click = () => {
  if (!isCollapseSidebar.value) {
    sidebarWidth.value = collapseMinWidth;
  } else {
    sidebarWidth.value = initMinWidth;
  }

  isCollapseSidebar.value = !isCollapseSidebar.value;

  nextTick(() => {
    // Perform any other operations that depend on the updated DOM
    // For example, you can update other components or trigger events.
    if (props.enableSidebarClick) {
      emits("collapse", sidebarWidth.value);
    }
  });
};
</script>
<style>
@import url("@/assets/style/layouts/sidebar-layout.css");

.split-bar {
  position: absolute;
  height: calc(100%);
  top: 0;
  width: 10px;
  right: -9px;
  z-index: 500;
  cursor: col-resize;
  display: block !important;
}

.split-bar:hover {
  position: absolute;
  top: 0;
  border-left: 2px solid #4970e3;
  display: flex;
  align-items: center;
  justify-content: center;
}

.hidden-sidebar {
  position: absolute;
  background-color: #2196f3;
  left: calc(100% - 20px);
  top: calc(50% - 10px);
  height: 20px;
  width: 20px;
  border-radius: 50%;
  visibility: hidden;
}

.split-bar:hover .hidden-sidebar {
  visibility: visible;
}

.show-sidebar {
  display: flex !important;
  height: 20px;
  width: 20px;
  top: calc(50% - 10px);
  border: 1px solid #4970e3;
  border-radius: 50%;
  position: absolute;
  visibility: unset;
}
</style>
