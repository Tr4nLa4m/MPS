<script>
import { defineComponent, computed, inject } from "vue";

export default defineComponent({
  name: "DatePickerCard",
  props: {
    value: {
      type: Date,
      default: null,
    },

    enableDateOver: {
      type: Boolean,
      default: false,
    },
  },
  setup(props, { emit }) {
    const common = inject("CommonFn");

    const dateOver = computed(() => {
        if(!props.enableDateOver){
          return false;
        }

        if(!props.value){
            return false;
        }
        return new Date() > props.value;
    })

    return {
      common,
      dateOver
    };
  },
});
</script>

<template>
  <div class="flex-row flex-align-center text-medium">
    <div class="flex-center" v-if="!value">
      <div class="mi-calendar-circle-dash mi-24"></div>
    </div>

    <div class="flex-center" v-if="value">
      <div class="mi-24 " :class="[dateOver ? 'mi-calendar-over-deadline' : 'mi-calendar-circle']"></div>

      <div class="m-ml8">
        <span class="text-medium" :class="dateOver ? 'date-over-text' : ''">{{ common.formatDate(value, true) }}</span>
      </div>
    </div>
  </div>
</template>

<style>
.date-over{
    background-color: #e8384f;
}

.date-over-text{
    color: #e8384f !important;
}
</style>
