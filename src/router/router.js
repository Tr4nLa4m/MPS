import { createRouter, createWebHistory } from "vue-router";
import MConstant from "@/common/consts/MConstant";
import baseRouter from "./baseRouter";
import auth from "../utils/helper/auth";

const LAYOUT_NAME = "MainLayout";
export const PAGE_NOT_FOUND_ROUTE = {
  path: "/page-not-found",
};

const routes = [
  {
    path: "/",
    name: LAYOUT_NAME,
    component: () => import("../views/layouts/MainLayout.vue"),
    meta: {
      // anonymous: true
    },
    children: [
      {
        path: "dashboard",
        name: "dashboard",
        meta: {
          subSystemCode: MConstant.SubSystemCode.M_Dashboard,
          anonymous: true
        },
        component: () => import("../views/pages/dashboard/Index.vue"),
      },
      {
        path: "project/:ProjectID",
        name: "project",
        props: (route) => ({ ProjectID: route.params.ProjectID}),
        meta: {
          subSystemCode: MConstant.SubSystemCode.M_Project,
          anonymous: true
        },
        component: () => import("../views/pages/project/Index.vue"),
        children: [
          {
            path: '', // Empty path for the child route
            name: 'no-tab',
            redirect: { name: 'board' } // Redirect to a fallback route if no child routes are defined
          },
          {
            path: "board",
            name: "board",
            meta: {
              subSystemCode: MConstant.SubSystemCode.M_Project_Board,
              anonymous: true
            },
            component: () => import("../views/pages/project/Board.vue"),
          },
          {
            path: "list",
            name: "list",
            meta: {
              subSystemCode: MConstant.SubSystemCode.M_Project_List,
              anonymous: true
            },
            component: () => import("../views/pages/project/List.vue"),
          },
          {
            path: "gantt",
            name: "gantt",
            meta: {
              subSystemCode: MConstant.SubSystemCode.M_Project_Gantt,
              anonymous: true
            },
            component: () => import("../views/pages/project/Gantt.vue"),
          },
          {
            path: "phase",
            name: "phase",
            meta: {
              subSystemCode: MConstant.SubSystemCode.M_Project_Phase,
              anonymous: true
            },
            component: () => import("@/views/pages/project/phase/Index.vue"),
          },
          {
            path: "report",
            name: "report",
            meta: {
              subSystemCode: MConstant.SubSystemCode.M_Project_Report,
              anonymous: true
            },
            component: () => import("@/views/pages/project/report/Index.vue"),
            children: [
              {
                path: '',
                name: 'projectOverviewReport', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Report,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/report/ProjectOverviewReport.vue"),
              },
              {
                path: 'task-employee',
                name: 'projectTaskByEmployeeReport',
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Report,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/report/ProjectTaskByEmployeeReport.vue"),
              }
            ]
          },

          {
            path: "file",
            name: "file",
            meta: {
              subSystemCode: MConstant.SubSystemCode.M_Project_File,
              anonymous: true
            },
            component: () => import("@/views/pages/project/File.vue"),
            
          },

          {
            path: "issue",
            name: "issue",
            meta: {
              subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
              anonymous: true
            },
            component: () => import("@/views/pages/project/issue/Index.vue"),
            children: [
              {
                path: '',
                name: 'allIssues', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/issue/ListIssue.vue"),
              },
              {
                path: 'my-issue',
                name: 'myIssue',
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/issue/MyIssue.vue"),
              },
              {
                path: 'watch-issue',
                name: 'watchIssue',
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/issue/WatchIssue.vue"),
              },
              {
                path: 'detail/:IssueID',
                name: 'issue-detail', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/issue/Detail.vue"),
              },
              {
                path: 'recently',
                name: 'issue-recently', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/issue/RecentlyIssue.vue"),
              },
              {
                path: 'relates',
                name: 'issue-relates', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/issue/RelateIssue.vue"),
              },

              {
                path: 'config',
                name: 'issue-config', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/issue/ConfigIssue.vue"),
              },
            ]
          },

          {
            path: "post",
            name: "post",
            meta: {
              subSystemCode: MConstant.SubSystemCode.M_Project_File,
              anonymous: true
            },
            component: () => import("@/views/pages/project/post/Index.vue"),
            children: [
              {
                path: '',
                name: 'allPosts', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/post/ListPost.vue"),
              },
              {
                path: 'filter',
                name: 'filter', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/post/Filter.vue"),
                props: (route) => ({ category: route.query.category, tag: route.query.tag })
              },
              {
                path: 'my-post',
                name: 'myPosts',
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/post/MyPost.vue"),
              },
              {
                path: 'bookmarks',
                name: 'bookmarks',
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/post/Bookmarks.vue"),
              },
              {
                path: 'config',
                name: 'config',
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/post/ConfigPost.vue"),
              },
              {
                path: 'detail/:PostID',
                name: 'post-detail', 
                meta: {
                  subSystemCode: MConstant.SubSystemCode.M_Project_Issue,
                  anonymous: true
                },
                component: () => import("@/views/pages/project/post/Detail.vue"),
              },
            ]
          },
        ]
      },
    ],
  },
  ...baseRouter,
  {
    // Redirect to 404 page, if no match found
    path: "/:pathMatch(.*)*",
    component: () =>
      import(/* webpackChunkName:'pages' */ "../views/pages/404.vue"),
    meta: {
      anonymous: true,
    },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

router.beforeEach((to, from, next) => {
  // khi chuyển router sẽ show maskloading cho người dùng biết xử lý
  // do tình huông tải file js chậm
  // trong after sẽ ẩn mask loading đi
  // Tạm thời dùng loading global, sau này có thể làm kiểu thanh line chạy ngay dưới address bar sau
  // commonFn.mask()

  // hide all popup
  // TODO => Ẩn tất cả popup ở đây
  // popupUtil.hideAll()
  // trang không authen
  if (to.meta.anonymous) {
    next();
    return;
  }

  // kiểm tra authen -> fail redirect login
  if (!auth.isAuthenticated()) {
      next({
        name: "login",
        query: {
          callback_url: encodeURI(to.fullPath)
        }
      })
    return;
  }

  // Điều hướng sang route mặc định
  if (to.name === LAYOUT_NAME) {
    next("dashboard");
    return;
    // next(getDefaultRoute(to) || PAGE_NOT_FOUND_ROUTE);
  }

  // Validate Permission, Không có quyền thì chuyển sang màn hình 403
  if (!checkPermission(to, from, next)) {
    next(PAGE_NOT_FOUND_ROUTE);
    return;
  }

  // default
  next();
});

/**
 * Lấy permission của người dùng
 * @returns
 */
const getPermission = () => store.getters[ModuleContext + "/Permission"];

/**
 * Có quyền sử dụng
 * @param {*} userPermission
 * @param {*} requiredPermission
 * @returns
 */
const hasUsePermission = (userPermission, requiredPermission) => {
  //   return userPermission[requiredPermission]?.includes(MSConstant.Permission.Use)
  return true;
};

/**
 * Validate permission
 * @param {*} to
 * @param {*} from
 * @param {*} next
 * @returns
 */
const checkPermission = (to, from, next) => {
  return true;
  // TODO
  const requiredPermission = to.meta.subSystemCode;
  const userPermission = getPermission();

  // Không khai báo subSystemCode hoặc không có userPermissionKey (full quyền) thì cho pass luôn
  if (!requiredPermission || !userPermission) {
    return true;
  }

  return hasUsePermission(userPermission, requiredPermission);
};

/**
 * Lấy ra route mặc định
 * @param {*} to
 * @returns
 * route mặc định không phải là ignoreRedirect
 */
const getDefaultRoute = (to) => {
  const userPermission = getPermission();
  const defaultRoute = routes
    .find((route) => route.name === to.name)
    ?.children?.find(
      (child) =>
        !child.meta?.ignoreRedirect &&
        (!userPermission ||
          !child.meta.subSystemCode ||
          hasUsePermission(userPermission, child.meta.subSystemCode))
    );

  return defaultRoute;
};

export default router;

