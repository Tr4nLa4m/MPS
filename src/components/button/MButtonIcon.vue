<template>
  <MButton
    :class="[classCustom, 'btn-icon']"
    :title="title"
    :tag="tag"
    :leftIcon="icon"
    :type="type"
    :border="border"
    :disable="disable"
  />
</template>

<script>
import { defineComponent } from "vue";
export default defineComponent({
  name: "MButtonIcon",
  props: {
    // Loại button gồm 3 loại primary/secondary/third/four để hiện thị style tương ứng
    type: {
      type: String,
      validator: (value) => {
        return ["primary", "secondary", "tertiary"].includes(value);
      },
      default: "primary",
    },

    // Icon trái
    icon: {
      default: null,
      type: String,
    },

    // Class custom cho button
    classCustom: String,

    // Border của button
    border: {
      type: Boolean,
      default: false,
    },

    // Trạng thái disable của button
    disable: {
      type: Boolean,
      default: false,
    },

    tag: {
      type: String,
      default: null,
    },

    title: {
      type: String,
      default: null,
    },
  },

});
</script>

<style scoped>
@import url(../../assets/style/components/button.css);

</style>
