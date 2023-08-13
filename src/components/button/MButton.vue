<template>
  <button
    class="m-button"
    :title="title"
    :class="[
      buttonTypeClass,
      text ? '' : 'only-icon',
      border ? 'm-btn-border' : '',
      classCustom,
      leftIcon || rightIcon ? 'd-flex flex-align-center' : '',
      disabled ? 'btn-disabled' : '',
    ]"
    :tag="tag"
    :style="style"
  >
    <div
      :class="['mi-24 icon-left', leftIcon, disabled ? 'disabled-icon' : '']"
      v-if="leftIcon"
    >
      &nbsp;
    </div>
    <div
      class="text"
      :class="[{ 'm-ml8': leftIcon, 'm-mr8': rightIcon }, classText]"
      v-if="text"
    >
      {{ text }}
    </div>
    <div
      :class="['mi-24 icon-right', rightIcon, disabled ? 'disabled-icon' : '']"
      v-if="rightIcon"
    />
  </button>
</template>

<script>
import { defineComponent } from "vue";
import { getCurrentInstance } from "vue";

export default defineComponent({
  name: "MButton",
  props: {
    // Nội dung của button
    text: {
      type: String,
      default: null,
    },

    // Loại button gồm 3 loại primary/secondary/third/four để hiện thị style tương ứng
    type: {
      type: String,
      validator: (value) => {
        return ["primary", "secondary", "tertiary"].includes(value);
      },
      default: "primary",
    },

    // Icon trái
    leftIcon: {
      default: null,
      type: String,
    },
    // Icon phải
    rightIcon: {
      default: null,
      type: String,
    },

    // Class custom cho button
    classCustom: String,

    classText: String,

    // Border của button
    border: {
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

    style: {
      type: Object,
      default: null,
    },

    disabled: false,
  },
  computed: {
    buttonTypeClass() {
      return `m-btn-${this.type}`;
    },
  },
  setup(props) {
    const { proxy } = getCurrentInstance();

    const click = () => {
      proxy.$el.click();
    };

    return {
      click,
    };
  },
});

export const ButtonType = {
  Primary: "m-btn-primary",
  Secondary: "m-btn-secondary",
};
</script>

<style scoped>
@import url(../../assets/style/components/button.css);
</style>
