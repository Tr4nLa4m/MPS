<template>
  <div
    class="m-row-input d-flex"
    :class="[customClass, 
    border ? 'm-input-border' : 'no-border',
    notvalid ? 'invalid' : ''
    ]"
    ref="tfInputWrapper"
  >
    <div class="m-input-wrapper">
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
        :class="['m-input', inputClass ]"
      />
    </div>

    <div class="m-input-error-label">{{ textMessage }}</div>
  </div>
</template>

<script>
import { ref } from 'vue'
export default {
  name: "MInput",
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

    border: {
      type: Boolean,
      default: true,
    },

    autocomplete: String,

    // Custom class
    customClass: String,

    inputClass: String,

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

    enableChange: {
      type: Boolean,
      default: false,
    }
  },

  setup(props, context) {
    const tfInputWrapper = ref(null);
    const notvalid = ref(false);
    /**
     * Xử lý sau khi blur
     * @author : TNLAM (30-09-2022)
     * @param {Any} newValue giá trị mới
     * @return {}
     */
    const handleBlurElement = ($event) => {
      // Format lại dữ liệu số - Hiện đang lỗi
      // let currentValue = Number(this.modelValue).toLocaleString("vi-VI");
      // this.$emit('update:modelValue', currentValue);
      const target = $event.target || $event.currentTarget;
      if(props.require){
        if(!target.value){
          invalid();
        }
      }

      // Thực hiện gọi hàm ở component cha
      if (props.enableBlur) {
        context.emit("onBlur", $event);
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
      const boundElement = target.closest(".m-row-input");
      // Nếu input đang invalid thì bỏ nó
      if (
        notvalid.value &&
        props.require &&
        target.value
      ) {
        notvalid.value = false;
      }

      // if(target.type == "email" && target.value && validate.isEmailValid(target.value)){
      //   target.removeAttribute("invalid");
      // }

      context.emit("update:modelValue", target.value);
      if(props.enableChange){
        context.emit("onTextChange", target.value);
      }
    };

    const invalid = () => {
      notvalid.value = true;
    };

    return {
      notvalid,
      handleBlurElement,
      handleUpdateModelValue,
      invalid,
    };
  },

  emits: ["update:modelValue", "onTextChange", "onBlur"],

  computed: {},
};
</script>

<style scoped>
@import url(../../assets/style/components/input.css);
</style>
