<template>
  <div class="ml-3 mr-3">
    <div class="toolbox">
      <div class="flex items-center">
        <label
          for="countries"
          class="block mb-2 mr-2 mt-1 text-lg font-medium text-gray-900 dark:text-white"
          >Filter:
        </label>
        <select
          id="countries"
          v-model="selectedOption"
          @change="handleChange"
          class="w-[300px] bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
        >
          <option value="Days">Days</option>
          <option value="Month">Month</option>
          <option value="Year">Year</option>
        </select>
      </div>
    </div>
    <div class="gstc-wrapper" ref="gstcElement"></div>
  </div>
</template>
<script>
import GSTC from "gantt-schedule-timeline-calendar/dist/gstc.wasm.esm.min.js";
import { Plugin as TimelinePointer } from "gantt-schedule-timeline-calendar/dist/plugins/timeline-pointer.esm.min.js";
import { Plugin as Selection } from "gantt-schedule-timeline-calendar/dist/plugins/selection.esm.min.js";
import { Plugin as ItemResizing } from "gantt-schedule-timeline-calendar/dist/plugins/item-resizing.esm.min.js";
import { Plugin as ItemMovement } from "gantt-schedule-timeline-calendar/dist/plugins/item-movement.esm.min.js";
import { Plugin as Bookmarks } from "gantt-schedule-timeline-calendar/dist/plugins/time-bookmarks.esm.min.js";
import "gantt-schedule-timeline-calendar/dist/style.css";
import { ref, onMounted, onBeforeUnmount } from "vue";
import dayjs from "dayjs";
const GSTCID = GSTC.api.GSTCID;
const currentDate = dayjs();
const startDate = GSTC.api.date().startOf("month").subtract(2, "month");
const startTime = startDate.valueOf();
const endDate = GSTC.api.date().endOf("month").add(2, "month");
const addDays = 90;
function getRandomFaceImage() {
  return `@/assets/faces/face-${Math.ceil(Math.random() * 50)}.jpg`;
}
const colors = [
  "#E74C3C",
  "#DA3C78",
  "#7E349D",
  "#0077C0",
  "#07ABA0",
  "#0EAC51",
  "#F1892D",
];
function getRandomColor() {
  return colors[Math.floor(Math.random() * colors.length)];
}
function generateRows() {
  /**
   * @type { import("gantt-schedule-timeline-calendar").Rows }
   */
  const rows = {};
  for (let i = 0; i < 100; i++) {
    const withParent = i > 0 && i % 2 === 0;
    const id = GSTCID(String(i));
    let startDayjs = GSTC.api
      .date(startTime)
      .startOf("day")
      .add(Math.floor(Math.random() * addDays), "day");
    rows[id] = {
      id,
      label: `John Doe ${i}`,
      parentId: withParent ? GSTCID(String(i - 1)) : undefined,
      start: startDayjs.startOf("day").format("YYYY-MM-DD"),
      expanded: false,
      vacations: [],
      img: getRandomFaceImage(),
      progress: Math.floor(Math.random() * 100),
      visible: true,
    };
  }
  debugger;
  return rows;
}
function generateItems() {
  /**
   * @type { import("gantt-schedule-timeline-calendar").Items }
   */
  const items = {};
  for (let i = 0; i < 100; i++) {
    const id = GSTC.api.GSTCID(i.toString());
    const rowId = GSTC.api.GSTCID(Math.floor(Math.random() * 100).toString());
    let startDayjs = GSTC.api
      .date(startTime)
      .startOf("day")
      .add(Math.floor(Math.random() * addDays), "day");
    let end = startDayjs
      .clone()
      .add(Math.floor(Math.random() * 20) + 4, "day")
      .endOf("day")
      .valueOf();
    if (end > endDate.valueOf()) end = endDate.valueOf();
    items[id] = {
      id,
      label: `Item ${i}`,
      progress: Math.round(Math.random() * 100),
      start: startDayjs.startOf("day").valueOf(),
      style: { background: getRandomColor() },
      rowId,
      time: {
        start: startDayjs.valueOf(),
        end,
      },
      img: getRandomFaceImage(),
      classNames: ["additional-custom-class"],
      description: "Lorem ipsum dolor sit amet",
    };
  }
  return items;
}
export default {
  name: "GSTC",
  setup() {
    let gstc, state;
    const gstcElement = ref(null);
    const selectedOption = ref("Days");
    onMounted(() => {
      /**
       * @type { import("gantt-schedule-timeline-calendar").Config }
       */
      const config = {
        licenseKey:
          "====BEGIN LICENSE KEY====\nXOfH/lnVASM6et4Co473t9jPIvhmQ/l0X3Ewog30VudX6GVkOB0n3oDx42NtADJ8HjYrhfXKSNu5EMRb5KzCLvMt/pu7xugjbvpyI1glE7Ha6E5VZwRpb4AC8T1KBF67FKAgaI7YFeOtPFROSCKrW5la38jbE5fo+q2N6wAfEti8la2ie6/7U2V+SdJPqkm/mLY/JBHdvDHoUduwe4zgqBUYLTNUgX6aKdlhpZPuHfj2SMeB/tcTJfH48rN1mgGkNkAT9ovROwI7ReLrdlHrHmJ1UwZZnAfxAC3ftIjgTEHsd/f+JrjW6t+kL6Ef1tT1eQ2DPFLJlhluTD91AsZMUg==||U2FsdGVkX1/SWWqU9YmxtM0T6Nm5mClKwqTaoF9wgZd9rNw2xs4hnY8Ilv8DZtFyNt92xym3eB6WA605N5llLm0D68EQtU9ci1rTEDopZ1ODzcqtTVSoFEloNPFSfW6LTIC9+2LSVBeeHXoLEQiLYHWihHu10Xll3KsH9iBObDACDm1PT7IV4uWvNpNeuKJc\npY3C5SG+3sHRX1aeMnHlKLhaIsOdw2IexjvMqocVpfRpX4wnsabNA0VJ3k95zUPS3vTtSegeDhwbl6j+/FZcGk9i+gAy6LuetlKuARjPYn2LH5Be3Ah+ggSBPlxf3JW9rtWNdUoFByHTcFlhzlU9HnpnBUrgcVMhCQ7SAjN9h2NMGmCr10Rn4OE0WtelNqYVig7KmENaPvFT+k2I0cYZ4KWwxxsQNKbjEAxJxrzK4HkaczCvyQbzj4Ppxx/0q+Cns44OeyWcwYD/vSaJm4Kptwpr+L4y5BoSO/WeqhSUQQ85nvOhtE0pSH/ZXYo3pqjPdQRfNm6NFeBl2lwTmZUEuw==\n====END LICENSE KEY====",
        plugins: [
          TimelinePointer(),
          Selection(),
          ItemResizing(),
          ItemMovement(),
          Bookmarks(),
        ],
        list: {
          columns: {
            data: {
              [GSTC.api.GSTCID("id")]: {
                id: GSTC.api.GSTCID("id"),
                width: 60,
                data: ({ row }) => GSTC.api.sourceID(row.id),
                header: {
                  content: "ID",
                },
              },
              [GSTC.api.GSTCID("label")]: {
                id: GSTC.api.GSTCID("label"),
                width: 200,
                data: "label",
                isHTML: false,
                expander: true,
                header: {
                  content: "Label",
                },
              },
              [GSTC.api.GSTCID("start")]: {
                id: GSTC.api.GSTCID("start"),
                width: 100,
                data: "start",
                header: {
                  content: "Start",
                },
              },
              [GSTC.api.GSTCID("progress")]: {
                id: GSTC.api.GSTCID("progress"),
                width: 100,
                data: "progress",
                header: {
                  content: "Progress",
                },
              },
            },
          },
          rows: generateRows(),
        },
        chart: {
          items: generateItems(),
        },
      };
      state = GSTC.api.stateFromConfig(config);
      globalThis.state = state;
      gstc = GSTC({
        element: gstcElement.value,
        state,
      });
      globalThis.gstc = gstc;
    });
    onBeforeUnmount(() => {
      if (gstc) gstc.destroy();
    });
    const handleChange = () => {
      let zoom = 20;
      let from = state.get("config.chart.time.from");
      let to = state.get("config.chart.time.to");
      switch (selectedOption.value) {
        case "Days":
          zoom = 20;
          from = currentDate.subtract(2, "month").startOf("month").valueOf();
          to = currentDate.add(2, "month").startOf("month").valueOf();
          break;
        case "Month":
          zoom = 26;
          from = currentDate.subtract(2, "year").startOf("year").valueOf();
          to = currentDate.add(2, "year").startOf("year").valueOf();
          break;
        case "Year":
          zoom = 28;
          from = currentDate.subtract(5, "year").startOf("year").valueOf();
          to = currentDate.add(5, "year").startOf("year").valueOf();
          break;
        default:
          break;
      }
      state.update("config.chart.time", (time) => {
        time.zoom = zoom;
        time.from = from;
        time.to = to;
        return time;
      });
    };
    return {
      gstcElement,
      selectedOption,
      handleChange,
    };
  },
};
</script>
<style scoped>
.gstc-component {
  margin: 0;
  padding: 0;
}
.toolbox {
  padding: 10px;
}
</style>
