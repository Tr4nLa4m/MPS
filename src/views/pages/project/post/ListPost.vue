<script setup>
import { ModulePost, ModuleContext } from "@/store/moduleConstant";
import commonFn from "@/utils/helper/commonFn";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";
import { onMounted } from "vue";
import { h, reactive, computed, nextTick, inject, ref } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useStore } from "vuex";

const store = useStore();
const route = useRoute();
const router = useRouter();
const { goToDetailPost } = useRoutePath();
const models = inject("Model");
const masterParam = reactive(models.createGetPagingPostByProjectParam());
const employee = computed(() => store.state[ModuleContext]?.employee);
const totalRecord = ref(0);
const masterData = ref([]);
const projectID = ref(route.params.ProjectID);
const categories = computed(() => store.state[ModulePost].categories);
const tags = computed(() => store.state[ModulePost].tags)


const tableConfig = reactive({
  maxHeight: 460,
  minHeight: 450,
});

const menuContextConfig = reactive({
  xRef: 0,
  yRef: 0,
  showDropdownRef: false,
  options: [
    {
      label: "Edit",
      key: "edit",
    },
    {
      label: () => h("span", { style: { color: "red" } }, "Delete"),
      key: "delete",
    },
  ],
  handleSelect() {
    menuContextConfig.showDropdownRef = false;
  },
  onClickoutside() {
    menuContextConfig.showDropdownRef = false;
  },
  rowProps(row) {
    return {
      onContextmenu: (e) => {
        e.preventDefault();
        menuContextConfig.showDropdownRef = false;
        nextTick().then(() => {
          menuContextConfig.showDropdownRef = true;
          menuContextConfig.xRef = e.clientX;
          menuContextConfig.yRef = e.clientY;
        });
      },
    };
  },
});

const getCategories = async () => {
  let param = {
    data: {
      ProjectID: projectID.value,
    },
  };
  let res = await store.dispatch(ModulePost + "/getCategoriesByProject", param);
};

const getTags = async () => {
  let param = {
    data: {
      ProjectID: projectID.value,
    },
  };
  let res = await store.dispatch(ModulePost + "/getTagsByProject", param);
};

onMounted(async () => {
  getTableHeight();

  initMasterParam();

  await getCategories();

  await getTags();

  await getData();
});

const initMasterParam = () => {
  masterParam.SortBy = 1; // Created Date DESC
  masterParam.ProjectID = projectID.value;
  masterParam.PageIndex = 1;
  masterParam.PageSize = 10;
  masterParam.EmployeeID = employee.value.EmployeeID;
  masterParam.KeySearch = '';
};

const getData = async () => {
  let param = {
    data: masterParam,
    onFailure: () => {},
  };
  let res = await store.dispatch(ModulePost + "/getPostsByProject", param);
  masterData.value = res.data;
  totalRecord.value = res.totalRecord;
};

const getTableHeight = () => {
  tableConfig.minHeight = window.innerHeight - 56 - 32 - 40 - 16 - 92;
  tableConfig.maxHeight = tableConfig.minHeight + 10;
};

const onPage_change = async (page) => {
  if (masterParam.PageIndex != page) {
    masterParam.PageIndex = page;
    await getData();
  }
};


const handleSearch = async () => {
  await getData();
};

const btnPost_click = (post) => {
  let postID = post.PostID;
  goToDetailPost(postID, projectID);
};

const btnFilterCategory_click = (category) => {
  router.push({name: 'filter', query: {category: category.PostCategoryID}});
}

const btnFilterTag_click = (tag) => {
  router.push({name: 'filter', query: {tag: tag.PostTagID}});
}

</script>

<template>
  <div class="list-post m-pl16 m-mr16 m-pb16">
    <n-scrollbar :style="`max-height: 600px`">
      <div class="flex-row m-pb8">
        <div class="list-content">
          <div class="list-post-header">
            <div class="">
              <div class="text-large">Tất cả bài viết</div>
            </div>
          </div>

          <div class="list-post-content">
            <div
              v-for="item in masterData"
              class="post-item m-pb8 m-pt8 line-bottom"
            >
              <div class="flex-row">
                <div class="post-author-avt m-mt8 m-mr8">
                  <div class="mi-32">
                    <img class="round" :src="item.AuthorAvatar" />
                  </div>
                </div>

                <div class="post-body">
                  <div class="post-title" @click="btnPost_click(item)">
                    {{ item.Title }}
                  </div>
                  <div class="flex-row">
                    <div class="post-sub-title link">{{ item.AuthorName }}</div>
                    <div class="post-sub-title">
                      {{ item.PostCategoryName }}
                    </div>
                    <div class="post-sub-title">
                      {{ commonFn.formatDate(item.CreatedDate) }}
                    </div>
                    <div class="post-sub-title">{{  item.NumComment }} bình luận</div>
                  </div>
                  <div class="content">
                    <div class="post-content-preview m-mt4">
                      {{
                        commonFn.truncateString(
                          commonFn.getRawTextFromHTML(item.Content),
                          288
                        )
                      }}
                    </div>
                    <div
                      class="pointer post-content-preview more"
                      @click="btnPost_click(item)"
                    >
                      Xem thêm ...
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="listpost-pagination m-pt16 flex-row-end">
            <n-pagination
                v-model:page="masterData.PageIndex"
                v-model:item-count="totalRecord"
                :page-size="masterParam.PageSize"
                :on-update:page="onPage_change"
              />
          </div>
        </div>

        <div class="list-filter m-mt16 m-pl16 m-pr16">
          <div class="search-filter m-p16 line-bottom">
            <MIconInput
              :placeholder="'Tìm kiếm'"
              :iconLeft="'mi-18 mi-search-before'"
              :customClass="'m-m0'"
              :inputClass="'no-border'"
              v-model="masterParam.KeySearch"
              :submitOnKeydown="true"
          @onEnter="handleSearch"
          @onIconClick="handleSearch"
            />
          </div>

          <div class="category-filter m-mt16">
            <n-collapse class="m-pb16">
              <n-collapse-item title="Danh mục" name="1">
                <div
                  v-for="item in categories"
                  class="m-pl16 m-pt8 m-pb8 pointer"
                  @click="btnFilterCategory_click(item)"
                >
                  {{ item.CategoryName }} ({{ item.NumPost }})
                </div>
              </n-collapse-item>
            </n-collapse>

            <n-collapse>
              <n-collapse-item title="Nhãn" name="1">
                <div
                  v-for="item in tags"
                  class="m-pl16 m-pt8 m-pb8 pointer"
                  @click="btnFilterTag_click(item)"
                >
                  {{ item.PostTagName }}
                </div>
              </n-collapse-item>
            </n-collapse>
          </div>
        </div>
      </div>
    </n-scrollbar>
  </div>
</template>

<style>
.list-post {
  background-color: #fff;
  margin: 16px 8px;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  padding: 8px 0;
  height: calc(100vh - 90px);
}

.post-title {
  font-size: 18px;
  font-family: "GoogleSans-Bold", Roboto, Helvetica, Arial, sans-serif !important;
  color: #3a3a3a;
}

.post-title:hover {
  color: var(--primary-color);
  text-decoration: underline;
  cursor: pointer;
}

.post-sub-title {
  font-family: "GoogleSans-Medium", Roboto, Helvetica, Arial, sans-serif !important;
  font-size: 14px !important;
  color: #aab2bd;
  font-weight: 300;
  padding: 0 8px;
  border-left: 1px solid #aab2bd;
}

.post-sub-title.link:hover {
  color: var(--primary-color);
  cursor: pointer;
}

.post-content-preview {
  font-size: 13px;
  font-weight: lighter;
  color: #555555;
}

.post-content-preview.more {
  color: var(--primary-color);
  cursor: pointer;
}

.list-content {
  width: 75%;
}

.list-filter {
  width: 25%;
}
</style>
