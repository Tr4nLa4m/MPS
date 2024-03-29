<template>
  <div
    class="m-row-input d-flex"
    :class="[customClass, border ? 'm-input-border' : 'no-border']"
  >
    <div class="m-input-wrapper d-flex flex-align-center">
      <div class="input-icon pointer" v-if="iconLeft" @click="btnIcon_click">
        <div :class="[iconLeft]"></div>
      </div>
      <input
        :type="type"
        :value="modelValue"
        @input="handleUpdateModelValue($event)"
        :autocomplete="autocomplete"
        :name="name"
        :id="refName"
        :tag="tag"
        :required="require"
        :readonly="disable"
        @blur="handleBlurElement($event)"
        :placeholder="placeholder"
        :style="{ width: width + 'px' }"
        :class="['m-input m-w100', inputClass]"
        @keydown="handleKeyDown"
      />

      <div class="input-icon pointer" v-if="iconRight" @click="btnIcon_click">
        <div :class="[iconRight]"></div>
      </div>
    </div>
    <div class="m-input-error-label">{{ textMessage }}</div>
  </div>
</template>

<script>
export default {
  name: "MIconInput",
  props: {
    // Tên của input
    name: String,

    type: {
      type: String,
      default: "text",
    },

    // Label của input
    label: String,

    // Trường bắt buộc của input
    require: Boolean,

    // Tên của trường Ref
    refName: String,

    // Chiều rộng tối thiểu của select
    width: Number,

    // Placeholder của input
    placeholder: String,

    autocomplete: String,

    // Custom class
    customClass: String,

    inputClass: String,

    border: {
      default: true,
      type: Boolean,
    },

    disable: {
      type: Boolean,
      default: false,
    },

    // Giá trị của input
    modelValue: null,

    // Text Message khi có lỗi xảy ra
    textMessage: String,

    tag: {
      type: String,
      default: null,
    },

    enableBlur: {
      type: Boolean,
      default: false,
    },

    iconLeft: {
      type: Array || String,
      default: null,
    },

    iconRight: {
      type: Array || String,
      default: null,
    },

    submitOnKeydown: {
      type: Boolean,
      default: false,
    },
  },

  setup(props, context) {
    /**
     * Xử lý sau khi blur
     * @author : TNLAM (30-09-2022)
     * @param {Any} newValue giá trị mới
     * @return {}
     */
    const handleBlurElement = (event) => {
      // Format lại dữ liệu số - Hiện đang lỗi
      // let currentValue = Number(this.modelValue).toLocaleString("vi-VI");
      // this.$emit('update:modelValue', currentValue);

      // Thực hiện gọi hàm ở component cha
      if (props.enableBlur) {
        context.emit("onValidateInput", event);
      }
    };

    /**
     * Thực hiện cập nhật lại model value
     * @author : TNLAM (30-09-2022)
     * @param {Any} newValue giá trị mới
     * @return {}
     */
    const handleUpdateModelValue = ($event) => {
      // Set giá trị nhỏ nhất là 0
      const target = $event.target || $event.currentTarget;
      // const boundElement = target.closest(".m-input-border");
      // // Nếu input đang invalid thì bỏ nó
      // if (
      //   boundElement.hasAttribute("invalid") &&
      //   target.hasAttribute("required") &&
      //   target.value
      // ) {
      //   boundElement.removeAttribute("invalid");
      // }

      // if(target.type == "email" && target.value && validate.isEmailValid(target.value)){
      //   target.removeAttribute("invalid");
      // }

      context.emit("update:modelValue", target.value);
    };

    const handleKeyDown = (e) => {
      if (props.submitOnKeydown) {
        if (e.keyCode == 13) {
          const target = e.target || e.currentTarget;
          context.emit("onEnter", target.value);
        }
      }
    };

    const btnIcon_click = (e) => {
      if(props.iconLeft || props.iconRight){
        context.emit("onIconClick");
      }
    }

    return {
      handleBlurElement,
      handleUpdateModelValue,
      handleKeyDown,
      btnIcon_click,
    };
  },

  emits: ["update:modelValue", "onEnter", "onIconClick"],

  computed: {},
};
</script>

<style scoped>
@import url(../../assets/style/components/input.css);

.input-icon {
  padding: 4px 8px;
}
</style>
