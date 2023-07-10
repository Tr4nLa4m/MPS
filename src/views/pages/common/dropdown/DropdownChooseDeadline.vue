<script>
import { defineComponent, computed, ref , inject} from "vue";
export default defineComponent({
  setup(props, {emit}) {

    const commonFn = inject("CommonFn");
    const range = ref(null);

    const getRange = computed(() => {
        if(!range.value){
            return "";
        }

        return commonFn.calculateTimePeriod(range.value[1] - range.value[0]);

    });

    const handleUpdateDateRange = (value, format) => {
        let data = {
            StartDate: new Date(value[0]),
            EndDate: new Date(value[1]),
            Range: value[1] - value[0]
        }

        emit('chooseDate', data);
        
    }

    return {
      getRange,
      handleUpdateDateRange,
      range
    };
  },
});
</script>

<template>
  <div class="date-range-picker-wrapper">
    <div class="m-pb16">
      <div class="title-medium">Chọn hạn hoàn thành</div>
    </div>

    <n-date-picker
      v-model:value="range"
      start-placeholder="Ngày bắt đầu"
      end-placeholder="Ngày kết thúc"
      type="datetimerange"
      @update:value="handleUpdateDateRange"
      clearable
    />

    <div class="m-mt16">
        <div class="m-ml8">Khoảng thời gian: <span class="text-bold">{{ getRange }}</span></div>
    </div>
    


    
  </div>
</template>

<style>
.date-range-picker-wrapper {
  width: 400px;
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
