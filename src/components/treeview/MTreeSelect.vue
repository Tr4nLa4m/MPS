<script>
import { defineProps, ref, defineEmits, defineComponent } from "vue";

export default defineComponent({
  name: "MTreeSelect",
  props: {
    data: {
      type: Array,
      default: [],
    },

    labelField: {
      type: String,
      default: "label",
    },

    keyField: {
      type: String,
      default: "key",
    },

    childrenField: {
      type: String,
      default: "children",
    },

    isExpandAll: {
      type: Boolean,
      default: false,
    },

    disabled: {
      type: Boolean,
      default: false,
    },

    enableChange: {
      type: Boolean,
      default: false,
    },

    customClass: {
      type: String, 
      default: ''
    },

    modelValue: null,
  },
  setup(props, { emit }) {
    const handleUpdateValue = (value, options) => {
      emit("update:modelValue", value);

      if (props.enableChange) {
        emit("onChange", value, options);
      }
    };

    

    return {
      handleUpdateValue,
    };
  },
  emits: ["update:modelValue", "onChange"],
});
</script>

<template>
  <n-tree-select
    :options="data"
    :label-field="labelField"
    :key-field="keyField"
    :value="modelValue"
    :children-field="childrenField"
    :default-expand-all="isExpandAll"
    @update:value="handleUpdateValue"
    :class="customClass"
    :disabled="disabled"
  />
</template>
