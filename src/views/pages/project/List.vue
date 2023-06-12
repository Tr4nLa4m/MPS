<script>
import { h } from "vue";
import { NProgress } from "naive-ui";
import MButton from "@/components/button/MButton.vue";
const columns = [
  {
    title: () => h("div", { class: "mi-24 mi-modify-column" }),
    key: "#",
    width: 48,
    render(row, index) {
      return index + 1;
    },
  },
  {
    title: "Tên công việc",
    key: "name",
    width: 500,
    resizable: true,
  },
  {
    title: "Nhóm công việc",
    key: "age",
    width: 200,
  },
  {
    title: "Tình trạng công việc",
    key: "address",
    render(row, index) {
      return h("span", ["row ", row.name]);
    },
    width: 210,
  },
  {
    title: "Hạn hoàn thành",
    key: "deadline",
    render(row, index) {
      return h("div", { class: "d-flex " }, [
        h(NProgress, {
          type: "circle",
          percentage: 50,
          showIndicator: false,
          strokeWidth: 10,
        }),
        h("div", ["Hoàn thành 50%"]),
      ]);
    },
    width: 240,
  },
  {
    title: "Người thực hiện",
    key: "AssignEmp",
    width: 240,
  },

  {
    title: "Thẻ",
    key: "The",
    width: 200,
  },
];
export default {
  components: { MButton },
  setup(props) {},
  data() {
    return {
      data: Array.from({ length: 46 }).map((_, index) => ({
        key: index,
        name: `Edward King ${index}`,
        age: 32,
        address: `London, Park Lane no. ${index}`,
        description: "This is new description ",
      })),
      columns,
      pagination: {
        pageSize: 15,
      },
    };
  },
};
</script>

<template>
  <div class="grid grid-task">
    <div class="grid-task-filter d-flex">
      <div class=" m-mr24">
        <MButton
          :text="'Tất cả công việc'"
          :title="'Chọn loại công việc'"
          :tag="'TypeTask'"
          :classCustom="'m-button-m grid-filter-btn'"
          leftIcon="mi-16 mi-grid-filter"
          rightIcon="mi-16 mi-carret-down"
          :classText="'m-mr8 m-ml8'"
        />
      </div>

      <div class=" m-mr24">
        <MButton
          :text="'Trạng thái hoàn thành Tất cả'"
          :title="'Chọn loại trạng thái hoàn thành công việc'"
          :tag="'TypeStatusTask'"
          :classCustom="'m-button-m grid-filter-btn'"
          leftIcon="mi-16 mi-grid-status-done"
          rightIcon="mi-16 mi-carret-down"
          :classText="'m-mr8 m-ml8'"
        />
      </div>

      <div class=" m-mr24">
        <MButton
          :text="'Sắp xếp theo Thứ tự công việc con'"
          :title="'Chọn loại trạng thái hoàn thành công việc'"
          :tag="'TypeStatusTask'"
          :classCustom="'m-button-m grid-filter-btn'"
          leftIcon="mi-16 mi-grid-status-done"
          rightIcon="mi-16 mi-carret-down"
          :classText="'m-mr8 m-ml8'"
        />
      </div>
    </div>

    <n-data-table
      id="resizeMe"
      :columns="columns"
      :data="data"
      :pagination="pagination"
      :max-height="500"
      :single-line="false"
      :scroll-x="2000"
    />
  </div>
</template>

<style>
.grid-task {
  background: #fff;
  margin: 16px;
  position: absolute;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  overflow: hidden;
  padding-top: 6px;
  height: calc(100vh - 90px);
  max-width: calc(100vw - 32px);

}

.grid-task-filter {
  padding: 0 8px 8px;
}

.n-data-table .n-data-table-th {
  padding: 8px 12px !important;
}

.n-progress.n-progress--circle {
  width: 24px !important;
}

.grid-filter-btn {
  background-color: #fff !important;
  color: #1f1f1f !important;
  font-size: 13px !important;
  font-weight: 400 !important;
}
</style>
