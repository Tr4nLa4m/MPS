<script>
import { onMounted } from "vue";
import { defineComponent, computed, ref, inject } from "vue";
export default defineComponent({
  props: {
    progress: {
      type: Number,
      default: 0,
    },
  },
  emits: ['chooseProgress'],
  setup(props, { emit }) {
    const value = ref(0);
    const marks = ref({
      0: "0 %",
      25: "25 %",
      50: "50 %",
      75: "75 %",
      100: "100 %",
    });

    onMounted(() => {
      value.value = props.progress;
    });

    const formatTooltip = (value) => {
      return `${value}%`;
    };

    const btnConfirm_click = () => {
        emit('chooseProgress', value.value)
    }

    return {
      value,
      marks,
      formatTooltip,
      btnConfirm_click
    };
  },
});
</script>

<template>
  <div class="progress-picker-wrapper">
    <div class="m-pb8">
      <div class="title-medium">Chọn tiến độ công việc</div>
    </div>

    <div class="m-p8">
      <n-slider
        v-model:value="value"
        :step="5"
        :marks="marks"
        :format-tooltip="formatTooltip"
      />
    </div>

    <div class="m-mt16 flex-row flex-align-center">
      <div class="m-pr16">Nhập tiến độ:</div>
      <div class="" style="max-width: 100px">
        <n-input-number
          v-model:value="value"
          :max="100"
          :min="0"
          width="30"
          size="small"
        />
      </div>
      <div class="m-pl8">%</div>
    </div>

    <div class="m-pt8 m-pr8 flex-row-end">
      <MButton text="Xác nhận" classCustom="m-button-l" @click="btnConfirm_click" />
    </div>
  </div>
</template>

<style>
.progress-picker-wrapper {
  width: 400px;
  padding: 8px;
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
