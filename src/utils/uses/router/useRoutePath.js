import { useRouter, useRoute } from "vue-router";
import config from "../../../common/config/config";
import { PAGE_NOT_FOUND_ROUTE } from "@/router/router";
import { useStore } from "vuex";
import commonFn from "@/utils/helper/commonFn";
import { keyStore } from "@/store/store";

export function useRoutePath(props) {
  const router = useRouter();
  const route = useRoute();
  const store = useStore();

  const goToDashboard = () => {
    router.push(config.Path.DASHBOARD);
  };

  const goToProject = (projectID) => {
    router.push([config.Path.PROJECT, projectID].join("/"));
  };

  const goToProjectChild = (tab) => {
    let ProjectID = route.params?.ProjectID;
    router.push(`${config.Path.PROJECT}/${ProjectID}${tab}`);
  };

  const goTo404 = () => {
    router.push(PAGE_NOT_FOUND_ROUTE);
  };

  const goToLogout = () => {
    store.reset();
    commonFn.removeItemLocalStorage(keyStore);
    router.push({ name: "login" });
  };

  const goTo = (path) => {
    router.push(path);
  };

  const getCurrentProjectTab = (tabs) => {
    let route = useRoute();
    return tabs.find((tab) => route.fullPath.includes(tab.path));
  };

  const goToDetailIssue = (issueID, projectID) => {
    if (!projectID) {
      router.push({ name: "issue-detail", params: { IssueID: issueID } });
    }
  };

  const goToDetailPost = (postID, projectID) => {
    router.push({ name: "post-detail", params: { PostID: postID } });
  };

  const goToIssueTab = (projectID) => {
    if (projectID) {
      router.push({ name: "allIssues", params: { ProjectID: projectID } });
    }
  };

  const goToPostTab = (tabName, projectID) => {
    router.push({ name: tabName, params: { ProjectID: projectID } });
  }

  return {
    goTo,
    goToLogout,
    goToDashboard,
    goToProjectChild,
    goToProject,
    getCurrentProjectTab,
    goTo404,
    goToDetailIssue,
    goToIssueTab,
    goToDetailPost,
    goToPostTab
    
  };
}
