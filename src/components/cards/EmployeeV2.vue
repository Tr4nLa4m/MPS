<script>
import { defineComponent } from "vue";
export default defineComponent({
  name: "EmployeeCardV2",
  props: {
    item: {
      type: Object,
      default: {},
    },
    clickable: false,
  },
});
</script>

<template>
  <div
    class="flex-row card-item flex-align-center m-pl16"
    :class="[clickable ? 'pointer' : '']"
  >
    <div class="card-item-avt">
      <img :src="item.Avatar || ''" />
    </div>

    <div class="card-item-title text-medium line-small m-pb8 m-w100">
      <div class="text-bold-l line-small">{{ item.FullName || '' }}</div>
      <div class="text-fade line-small">{{  item.PositionName || '' }}</div>
      <div class="text-small text-fade line-small">{{  item.Email || '' }}</div>
    </div>
  </div>
</template>

<style scoped>
.card-item-avt {
  width: 32px;
  height: 32px;
  margin-right: 16px;
}

.card-item-avt img {
  border-radius: 50%;
}

.card-item:hover{
  background-color: var(--background-hover-color-1);
}
</style>
