import { ref, reactive, readonly } from "vue";
import MConstant from "@/common/consts/MConstant";


const allProjectTabs = Object.values(MConstant.ProjectTab).map((value) => {
    return {
      name: value.name,
      path: value.path,
      key: value.key,
      active: true
    };
  });

const state = reactive({
    currentTab: {
        name: "Danh sách",
        key: 2,
        path: "/project/list",
        active: true
    },

    tabs: allProjectTabs
});

const setCurrentTab = (newTab) => {
    projectTab.currentTab = newTab;
}


export default{
    state: readonly(state),
    setCurrentTab
}