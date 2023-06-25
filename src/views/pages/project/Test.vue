<template>
  <div class="flex-center">
    <n-dropdown
      trigger="click"
      :options="options"
      @select="handleSelect"
      :show-arrow="true"
    >
      <h1>Just some text</h1>
    </n-dropdown>
  </div>

  <div>
    <n-dropdown trigger="click" :options="options1" :show-arrow="true">
      <h1>Some text</h1>
    </n-dropdown>
  </div>

  <div class="flex-row test">
    <h1 id="mye">This is new page</h1>
    <Editor
      api-key="9038dr0d32vvyxk56tg57fbo4w5hgp16g574iyezusedlm3f"
      v-model="content"
      :init="tinymceInit"
      :value="content"
    ></Editor>
  </div>
</template>

<script>
import { defineComponent, h, ref } from "vue";
import { useMessage } from "naive-ui";
import SearchList from "@/components/SearchList.vue";
import DropdownUserInfo from "@/views/pages/common/dropdown/DropdownUserInfo.vue";
// Add any other plugins you want to use
import Editor from "@tinymce/tinymce-vue";
function renderCustomHeader() {
  return h(
    "div",
    {
      style: "display: flex; align-items: center; padding: 8px 12px;",
    },
    [h(SearchList, {})]
  );
}

function renderCustomHeader1() {
  return h(DropdownUserInfo, {
    user: {
      Avatar: new URL("@/assets/image/avt.jpg", import.meta.url),
      FullName: "Trần Ngọc Lâm",
      Email: "tranlamiter@gmail.com",
    },
  });
}

export default defineComponent({
  components: {
    Editor,
  },
  setup() {
    const message = useMessage();
    const content = ref("");
    const tinymceInit = {
      plugins: ["autolink", "link", "image", "lists"], // Add any other plugins you want to use
      toolbar: "undo redo | bold italic | bullist numlist", // Customize the toolbar buttons
      // Add any other initialization options you need
      statusbar: false,
      inline: true,
      width: 500,
      height: 300,
      selector: "#mye",
    };
    return {
      content,
      tinymceInit,
      options: [
        {
          key: "header",
          type: "render",
          render: renderCustomHeader,
        },
        {
          key: "header-divider",
          type: "divider",
        },
      ],
      options1: [
        {
          key: "header",
          type: "render",
          render: renderCustomHeader1,
        },
      ],
      handleSelect(key) {
        message.info(String(key));
      },
    };
  },
});
</script>

<style>
.test {
  background: #fff;
  padding-left: 100px;
}

.mce-content-body {
  max-width: 400px !important;
  min-height: 50px !important;
  background-color: #d9d9d9 !important;
}
</style>
