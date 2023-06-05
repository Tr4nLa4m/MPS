<template>
  <div class="m-tree-view">
    <ul v-show="!collapsed">
      <li v-for="item in data" :key="item.id">
        <MTab
          class="caret"
          v-if="item.children"
          :text="item.text"
          :leftIcon="getLeftIcon(item)"
          @click="toggleCollapse(item)"
        >
        </MTab>
        <MTab v-else :text="item.text" :icon="item.icon" />
        <MTreeView
          v-if="item.children"
          :items="item.children"
          :collapsed="item.collapsed"
        ></MTreeView>
      </li>
    </ul>
  </div>
</template>

<script>
import { defineComponent, reactive, ref , watch } from "vue";
import MTab from "@/components/tab/TabItem.vue";
import commonFn from "@/utils/helper/commonFn.js";

export default defineComponent({
  name: "MTreeView",
  components: { MTab },
  props: {
    items: {
      type: Array,
      required: true,
    },
    collapsed: {
      type: Boolean,
      default: false,
    },

    searchProjectText: String,
  },
  setup(props) {
    const Icon = {
      collapsed: "mi-16 mi-carret-down-white",
      notcollased: "mi-16 mi-carret-right-white",
    };

    const currentState = ref({
      isCollapsed: props.collapsed,
      leftIcon: Icon.notcollased,
    });


    const data = ref(commonFn.addCollapsedPropertyForTree(props.items));

    const updateData = () => {
      data.value = commonFn.addCollapsedPropertyForTree(props.items);
    };

    watch(
      () => props.items,
      () => {
        updateData();
      }
    );

    // watch(
    //   () => props.searchProjectText,
    //   (current, old) => {
    //     if(!current && data.value && data.value.length > 0){
    //       debugger
    //       data.value.forEach(element => {
    //         if(element.children){
    //           element.children.forEach((children) => {
    //             children.collapsed = false;
    //           })
    //         }
    //       });
    //     }
    //   }
    // );

    const toggleCollapse = (item) => {
      currentState.value.leftIcon =
        currentState.value.leftIcon == Icon.collapsed
          ? Icon.notcollased
          : Icon.collapsed;
      let idx = data.value.findIndex((x) => x.id === item.id);
      if (idx >= 0) {
        data.value[idx].collapsed = !item.collapsed;
      }
    };

    const getLeftIcon = (item) => {
      return item.collapsed ? Icon.notcollased : Icon.collapsed;
    };

    return {
      data,
      currentState,
      toggleCollapse,
      getLeftIcon,
      updateData
    };
  },
});
</script>

<style scoped>
@import url(../../style/components/tree.css);
</style>
