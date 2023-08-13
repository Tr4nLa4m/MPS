<script>
import { defineComponent, computed, ref , inject} from "vue";
export default {
  setup(props) {

    const commonFn = inject("CommonFn");
    const data = [
      {
        avatar: new URL("@/assets/image/avt.jpg", import.meta.url),
        name: "Trần Ngọc Lâm",
        email: "tranlamiter@gmail.com",
      },
    ];

    const searchEmp = ref("");

    const range = ref();

    const getRange = computed(() => {
        if(!range.value){
            return "";
        }
        console.log(1);

        return commonFn.calculateTimePeriod(range.value[1] - range.value[0]);

    })

    return {
      data,
      searchEmp,
      getRange,
      range
    };
  },
};
</script>

<template>
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
        v-model="searchEmp"
      />

      <n-input type="text" placeholder="Basic Input" />
    </div>

    <n-date-picker
      v-model:value="range"
      start-placeholder="Ngày bắt đầu"
      end-placeholder="Ngày kết thúc"
      type="datetimerange"
      clearable
    />

    <div class="">{{ getRange }}</div>


    <!-- <div class="search-item-list">
      <div v-for="item in data" class="flex-row search-item flex-align-center">
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
    </div> -->
  </div>
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
