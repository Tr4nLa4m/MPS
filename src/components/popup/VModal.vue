<script setup>
import { VueFinalModal } from "vue-final-modal";
import globalPopup from "@/utils/globalPopup.js";
import { ref , defineProps, defineEmits} from 'vue'

const emit = defineEmits("closeModal");
const props = defineProps({
  config: {
    type: Object,
    default: {}
  }
})
const config = ref(globalPopup.getInitialConfig(props.config));

</script>

<template>
  <VueFinalModal
    v-model="config.modelValue"
    class="dynamic-modal"
    :class="[config.customClass]"
    :content-class="config.contentClass"
    :display-directive="config.displayDirective"
    :hide-overlay="config.hideOverlay"
    :overlay-transition="config.overlayTransition"
    :content-transition="config.contentTransition"
    :click-to-close="config.clickToClose"
    :esc-to-close="config.escToClose"
    :background="config.background"
    :lock-scroll="config.lockScroll"
    :swipe-to-close="config.swipeToClose"
  >
    <slot name="default"/>
  </VueFinalModal>
</template>

<style>
.dynamic-modal {
  display: flex;
  justify-content: center;
  align-items: center;
  font-family: "GoogleSans-Regular", Roboto, Arial, Helvetica, sans-serif;
}
.dynamic-modal-content {
  display: flex;
  flex-direction: column;
  padding: 1rem;
  background: #fff;
  border-radius: 0.5rem;
}
.dynamic-modal-content > * + * {
  margin: 0.5rem 0;
}
.dynamic-modal-content h1 {
  font-size: 1.375rem;
}
.dynamic-modal-content button {
  margin: 0.25rem 0 0 auto;
  padding: 0 8px;
  border: 1px solid;
  border-radius: 0.5rem;
}

.dynamic-modal-content button {
    margin: 0;
    padding: 0;
    border: 1px solid;
    border-radius: 0.5rem;
}
</style>
