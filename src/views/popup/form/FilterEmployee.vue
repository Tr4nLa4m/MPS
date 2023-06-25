<script>
import { defineComponent, h, ref, computed, reactive, nextTick } from "vue";

export default defineComponent({
  name: "FilterEmployeeForm",
  setup(props, { emit }) {
    const data = [
      {
        avatar: new URL("@/assets/image/avt.jpg", import.meta.url),
        name: "Trần Ngọc Lâm",
        email: "tranlamiter@gmail.com",
      },
      {
        avatar: new URL("@/assets/image/avt.jpg", import.meta.url),
        name: "Trần Văn Sơn",
        email: "tranlamiter@gmail.com",
      },
    ];

    const searchText = ref("");

    const getFilterEmployee = computed(() => {
      if (!searchText.value) {
        return data;
      }

      let n_text = searchText.value.toLowerCase();

      return data.filter(
        (item) =>
          item.name.toLowerCase().includes(n_text) ||
          item.email.toLowerCase().includes(n_text)
      );
    });


    return {
      data,
      searchText,
      getFilterEmployee,
    };
  },
});
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

        <div class="search-item-list">
          <div
            v-for="item in getFilterEmployee"
            class="flex-row search-item flex-align-center"
          >
            <div class="search-item-avt">
              <img :src="item.avatar" />
            </div>

            <div class="flex-column">
              <div class="search-item-title text-medium line-small">
                {{ item.name }}
              </div>

              <div class="search-item-subtitle text-small line-small">
                {{ item.email }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </VModal>
</template>

<style>
.search-list-wrapper {
  width: 305px;
}

.search-item-list {
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
