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
          :customClass="'no-border m-m0 m-pl24'"
          :inputClass="'no-border m-white m-h32 fs-14 m-pl4 m-pt8 m-pr8 m-pb8'"
          v-model="searchProjectText"
        />

        <div class="mi-24 mi-collapse pointer m-mr16"></div>

        <div class="mi-24 mi-setting pointer m-mr16"></div>
      </div>

      <div class="m-department-list">
        <MTreeView :items="filteredData" :searchProjectText="searchProjectText" />
      </div>
    </div>
  </aside>
</template>

<script>
import MSplitButton from "@/components/button/MSplitButton.vue";
import MTreeView from "@/components/treeview/MTreeView.vue";
import MIconInput from "@/components/input/MIconInput.vue";
import { ref, computed } from "vue";
export default {
  name: "SideBarLayout",
  components: { MSplitButton, MTreeView, MIconInput },
  setup(props, context) {
    const searchProjectText = ref("");
    const myData = [
      {
        id: 1,
        text: "Cá nhân",
        children: [
          { id: 2, text: "Công việc cá nhân" },
          { id: 3, text: "Coffee" },
        ],
      },
      {
        id: 4,
        text: "Phòng quản trị",
        children: [{ id: 5, text: "Dự án Max" }],
      },
    ];

    const filteredData = computed(() => {
      if (!searchProjectText.value) {
        return myData;
      }

      console.log(1);

      const filterText = searchProjectText.value.toLowerCase();

      const filterChildren = (items) => {
        const filteredItems = [];
        for (const item of items) {
          if (item.text.toLowerCase().includes(filterText)) {
            filteredItems.push(item);
            continue;
          }
          if (item.children) {
            const matchingChildren = filterChildren(item.children);
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


      return filterChildren(myData);
    });

    return {
      searchProjectText,
      filteredData,
    };
  },
};
</script>
<style>
@import url("@/assets/style/layouts/sidebar-layout.css");
</style>
