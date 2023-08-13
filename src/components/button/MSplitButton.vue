<template>
  <div
    class="m-split-button flex-center"
    :title="title"
    :class="[
      buttonTypeClass,
      text ? '' : 'only-icon',
      border ? 'm-btn-border' : '',
      classCustom,
    ]"
  >
    <button
      :tag="tag"
      style="background-color: transparent"
      class="m-button m-pl8 m-pr8 flex-center"
      @click="onClick($event)"
    >
      <div
        :class="['icon-left', leftIcon, disabled ? 'disabled-icon' : '']"
        v-if="leftIcon"
      >
        &nbsp;
      </div>
      <div
        class="text m-mr4 m-ml4"
        :class="[{ 'pl-0': leftIcon, 'pr-0': rightIcon }]"
        v-if="text"
      >
        {{ text }}
      </div>
      <div
        :class="['icon-right', rightIcon, disabled ? 'disabled-icon' : '']"
        v-if="rightIcon"
      />
    </button>

    <div class="divider"></div>

    <n-dropdown
      :show="showDropdown"
      :options="options"
      :show-arrow="true"
      :on-clickoutside="onClickoutside"
      @select="handleSelect"
    >
      <MButtonIcon
        :icon="'mi-16 icon-after ' + splitIcon"
        :classText="splitTextClass"
        :classCustom="'btn-split ' + splitButtonClass"
        :text="splitText"
        @click="handleClickShowDropdown"
      />
    </n-dropdown>
  </div>
</template>

<script>
import { defineComponent, ref, nextTick } from "vue";
export default defineComponent({
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

    disabled: false,

    options: {
      type: Array,
      default: []
    },

    splitText: {
      type: String,
      default: null,
    },

    splitTextClass: {
      type: String,
      default: null,
    },

    splitButtonClass: {
      type: String,
      default: null,
    },

    splitIcon: {
      type: String,
      default: 'mi-carret-down-white',
    }
  },
  computed: {
    buttonTypeClass() {
      return `m-btn-${this.type}`;
    },
  },

  setup(props, { emit }) {
    const onClick = (event) => {
      emit("onClick", event);
    };

    const showDropdown = ref(false);


    const handleSelect = (key) => {
      showDropdown.value = false;
      emit("onOptionClick", key);
    };

    const handleClickShowDropdown = () => {
      showDropdown.value = !showDropdown.value;
    }

    const onClickoutside = () => {
      showDropdown.value = false;
    }

    return {
      onClick,
      handleSelect,
      showDropdown,
      handleClickShowDropdown,
      onClickoutside
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
