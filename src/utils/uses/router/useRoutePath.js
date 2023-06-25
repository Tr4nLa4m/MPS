import { useRouter, useRoute } from "vue-router";
import config from "../../../common/config/config";
import { PAGE_NOT_FOUND_ROUTE } from "@/router/router";

export function useRoutePath(props ) {

    const router = useRouter();
    const route = useRoute();

    const goToDashboard = () => {

        router.push(config.Path.DASHBOARD);
    }

    const goToProject = (projectID) => {
        router.push([config.Path.PROJECT, projectID].join('/'));
    }

    const goToProjectChild = (tab) => {
        let ProjectID = route.params?.ProjectID;
        router.push(`${config.Path.PROJECT}/${ProjectID}${tab}`);
    }

    const goTo404 = () => {
        router.push(PAGE_NOT_FOUND_ROUTE);
    }

    const goTo = (path) => {
        router.push(path);
    }

    const getCurrentProjectTab = (tabs) => {
        let route = useRoute();
        return tabs.find((tab) => route.fullPath.includes(tab.path));
    }


    return{
        goTo,
        goToDashboard,
        goToProjectChild,
        goToProject,
        getCurrentProjectTab,
        goTo404
    }
  }