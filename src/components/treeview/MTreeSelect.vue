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

    enableChange: {
      type: Boolean,
      default: false,
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
    @update:value="handleUpdateValue"
  />
</template>
