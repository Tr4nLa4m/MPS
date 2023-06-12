import { useRouter, useRoute } from "vue-router";
import config from "../../../common/config/config";

export function useRoutePath(props ) {
    const router = useRouter();

    const goToDashboard = () => {
        router.push(config.Path.DASHBOARD);
    }

    const goToProject = () => {
        router.push(config.Path.PROJECT);
    }

    const goToProjectChild = (route) => {
        router.push(route);
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
        getCurrentProjectTab
    }
  }