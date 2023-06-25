<template>
  <aside>
    <div class="m-sidebar">
      <div class="m-tab-list">
        <router-link to="/dashboard" class="m-tab-item m-pt8 m-pb8">
          <div class="m-tab-item-wrapper d-flex flex-align-center">
            <div class="mi-24 mi-home m-mr16"></div>
            <div class="">Tổng quan</div>
          </div>
        </router-link>

        <router-link to="/dashboard" class="m-tab-item m-pt8 m-pb8">
          <div class="m-tab-item-wrapper d-flex flex-align-center">
            <div class="mi-24 mi-my-task m-mr16"></div>
            <div class="">Việc của tôi</div>
          </div>
        </router-link>

        <router-link to="/dashboard" class="m-tab-item m-pt8 m-pb8">
          <div class="m-tab-item-wrapper d-flex flex-align-center">
            <div class="mi-24 mi-chart m-mr16"></div>
            <div class="">Báo cáo</div>
          </div>
        </router-link>
      </div>

      <div class="m-department-tool flex-jsp m-mt16 m-mb16">
        <MIconInput
          :placeholder="'Tìm kiếm'"
          :iconLeft="'mi-18 mi-search-before'"
          :customClass="'m-m0 m-ml16 search-projects'"
          :inputClass="'m-h32 fs-14 m-pl4 m-pt8 m-pr8 m-pb8 transparent m-white'"
          v-model="searchProjectText"
        />

        <div class="mi-24 mi-collapse pointer m-mr16" title="Thu gọn" @click="btnCollapse_click"></div>

        <div class="mi-24 mi-setting pointer m-mr16"></div>
      </div>

      <div class="m-department-list m-pl16">
        <n-tree
          block-line
          label-field="ProjectName"
          key-field="ProjectID"
          children-field="Projects"
          :data="filteredData"
          :default-expanded-keys="defaultExpandedKeys"
          :node-props="nodeProps"
          class="sidebar-projects"
        />
      </div>
    </div>
  </aside>
</template>

<script setup>
import MIconInput from "@/components/input/MIconInput.vue";
import { ref, computed, onMounted, defineProps } from "vue";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";

const props = defineProps({
  projects: [],
});

const departmentKeyPrefix = "DEPARTMENT_"

const searchProjectText = ref("");

const defaultExpandedKeys = ref([]);

const { goToProject } = useRoutePath();

const filteredData = computed(() => {
  let rawData = props.projects?.map((x) => {
    return {
      ...x,
      ProjectID: departmentKeyPrefix + x.DepartmentID,
      ProjectName: x.DepartmentName,
    };
  });
  if (!searchProjectText.value) {
    updateExpandedKey(rawData);
    return rawData;
  }

  console.log(rawData);

  const filterText = searchProjectText.value.toLowerCase();

  const filterChildren = (items) => {
    const filteredItems = [];
    for (const item of items) {
      if (item.ProjectName?.toLowerCase().includes(filterText)) {
        filteredItems.push(item);
        continue;
      }
      if (item.Projects && item.Projects.length > 0) {
        const matchingChildren = filterChildren(item.Projects);
        if (matchingChildren.length > 0) {
          filteredItems.push({
            ...item,
            children: matchingChildren,
          });
        }
      }
    }
    return filteredItems;
  };


  let data = filterChildren(rawData);
  updateExpandedKey(data);
  return data;

});



const btnCollapse_click = () => {
  updateExpandedKey([]);
}

const updateExpandedKey = (projectList) => {
  defaultExpandedKeys.value = projectList?.map(x => x.ProjectID);
}

const nodeProps = ({ option }) => {
  return {
    onClick() {
      if(!option.ProjectID?.includes(departmentKeyPrefix)){
        goToProject(option.ProjectID);
      }
    },
  };
};
</script>
<style>
@import url("@/assets/style/layouts/sidebar-layout.css");

.sidebar-projects {
  --n-node-text-color: #fff !important;
  --n-arrow-color: #fff !important;
  --n-node-color-active: rgba(53, 159, 245, 0.1);
  --n-node-color-hover: var(--surface-900) !important;
  --n-node-color-pressed: var(--surface-800) !important;
}

.search-projects{
  border-top: 0 !important;
  border-left: 0 !important;
  border-right: 0 !important;
  border-radius: 0px !important;
}

</style>
