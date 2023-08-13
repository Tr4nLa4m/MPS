<script setup>
import { defineComponent, computed } from 'vue';
import commonFn from "@/utils/helper/commonFn.js";

const props = defineProps({
    item: {
        type: Object,
        default: ''
    },
    clickable: {
        type: Boolean,
        default: false
    }
});

const isImageLink = computed(() => {
    return commonFn.checkIsImageLink(props.item.Type);
});

const getThumbIcon = computed(() => commonFn.getIconFileType(props.item.Type))

</script>

<template>
  <div
    class="flex-row card-item flex-align-center"
    :class="[clickable ? 'pointer' : '']"
  >
    <div v-if="isImageLink" class="mi-32 m-mr8 flex-center">
      <img :src="item.Avatar || ''" />
    </div>

    <div v-else :class="['mi-32 flex-center m-mr8' , getThumbIcon]">
    </div>

    <div class="card-item-title text-medium line-small">
      {{ item.Name || "" }}
    </div>
  </div>
</template>

<style>


</style>
