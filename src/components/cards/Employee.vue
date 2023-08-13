<script>
import { defineComponent } from 'vue'
export default defineComponent({
  name: "EmployeeCard",
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
    class="flex-row card-item flex-align-center"
    :class="[clickable ? 'pointer' : '']"
  >
    <div class="card-item-avt">
      <img :src="item.Avatar || ''" />
    </div>

    <div class="card-item-title text-medium line-small">
      {{ item.FullName || "" }}
    </div>
  </div>
</template>

<style>
.card-item-avt {
  width: 24px;
  height: 24px;
  margin-right: 8px;
}

.card-item-avt img {
  border-radius: 50%;
}
</style>
