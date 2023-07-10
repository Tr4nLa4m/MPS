<script setup>
import { ModuleProject } from "@/store/moduleConstant";
import { defineProps, h, onMounted, ref, computed, reactive, nextTick } from "vue";
import { useStore } from "vuex";

const props = defineProps({
  project: {
    type: Object,
    default: {}
  }
});

const emits = defineEmits(['closeModal', 'chooseEmployee']);

const store = useStore();
const searchText = ref("");


const employees = computed(() => store.state[ModuleProject]?.employees);

const getFilterEmployee = computed(() => {
  if (!searchText.value) {
    return employees.value;
  }

  let n_text = searchText.value.toLowerCase();

  return employees.value.filter(
    (item) =>
      item.FullName.toLowerCase().includes(n_text) ||
      item.Email.toLowerCase().includes(n_text)
  );
});

onMounted(async () => {
  let param = {
    ProjectID: props.project?.ProjectID
  }
  // lấy danh sách nhân viên theo project
  await store.dispatch(ModuleProject + "/getEmployees", param)
})




const btnChooseEmployee_click = (employee) => {
  emits('chooseEmployee', employee);
  emits('closeModal');
}
</script>

<template>
  <VModal customClass="filter-employee">
    <template #default>
      <div class="search-list-wrapper">
        <div class="m-pb16">
          <div class="title-medium">Chọn người thực hiện</div>
        </div>

        <div class="w-100 m-pl16 m-pr16 m-pb16">
          <MIconInput
            :placeholder="'Tìm kiếm'"
            :iconLeft="'mi-18 mi-search-before'"
            :customClass="'m-m0'"
            :inputClass="'no-border'"
            v-model="searchText"
          />
        </div>

        <n-scrollbar trigger="hover" style="max-height: 270px">
          <div class="search-item-list">
            <div
              v-for="item in getFilterEmployee"
              class="flex-row search-item flex-align-center pointer"
              @click="btnChooseEmployee_click(item)"
            >
              <div class="search-item-avt">
                <img :src="item.Avatar || ''" />
              </div>

              <div class="flex-column">
                <div class="search-item-title text-medium line-small">
                  {{ item.FullName || ''}}
                </div>

                <div class="search-item-subtitle text-small line-small">
                  {{ item.Email || '' }}
                </div>
              </div>
            </div>
          </div>
        </n-scrollbar>
      </div>
    </template>
  </VModal>
</template>

<style>
.search-list-wrapper {
  width: 305px;
}

.search-item-list {
  min-height: 162px;
}

.search-item-list .search-item {
  padding: 8px 24px;
}

.search-item-list .search-item:hover {
  background-color: var(--background-hover-color-1);
}

.search-item-list .search-item .search-item-avt {
  width: 32px;
  height: 32px;
  margin-right: 8px;
}

.search-item-list .search-item .search-item-avt img {
  border-radius: 50%;
}
</style>
