<script>
import { defineComponent } from 'vue'
export default defineComponent({
  name: "EmployeeCardV3",
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
    class="flex-row flex-align-center"
    :class="[clickable ? 'pointer' : '']"
  >
    <div class="card-item-avt">
      <img :src="item.Avatar || ''" />
    </div>

    <div class="card-item-title">
      {{ item.FullName || "" }}
    </div>
  </div>
</template>

<style scoped>
.card-item-avt {
  width: 32px;
  height: 32px;
  margin-right: 8px;
}

.card-item-avt img {
  border-radius: 50%;
}
</style>
