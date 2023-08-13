
import { useRouter } from "vue-router";
import MConstant from "@/common/consts/MConstant";

const ProjectTabs = Object.values(MConstant.ProjectTab).map((value) => {
  return {
    name: value.name,
    path: value.path,
    key: value.key,
  }});

// initial state

const state = {
  projectTab: ProjectTabs[0],
  /** 
  {
    name: 'Bảng',
    path: '/board',
    key: 1,
    active: true
  }
  */
  projectTabs: ProjectTabs,

  issueSidebarWidth: 260,

  reportSidebarWidth: 320
}

// getters
const getters = {
  getCurrentProjectTab: (state, getters, rootState) => {
    return state.projectTab;
  },

  getProjectTabByName: (state, getters) => (name) => {
    let tab = state.ProjectTabs.find(tab => {
      tab.name.toLowerCase() == name.toLowerCase()
    })

    return tab;
  }
}

// actions
const actions = {
  setActiveProjectTab({ commit, state }, payload){
    let tabPath = payload.TabPath;
    let activeTab = state.projectTabs.find((tab) => tab.path.includes(tabPath));
    if(activeTab){
      commit('SET_PROJECT_TAB', activeTab);
    }

    return activeTab;
  },

  setIssueSidebarWidth({ commit, state }, payload){
    let sideBarWidth = payload.sideBarWidth;
    if(sideBarWidth){
      commit("SET_ISSUE_SIDEBAR_WIDTH", sideBarWidth);
    }
  },

  setReportSidebarWidth({ commit, state }, payload){
    let sideBarWidth = payload.sideBarWidth;
    if(sideBarWidth){
      commit("SET_REPORT_SIDEBAR_WIDTH", sideBarWidth);
    }
  }
}

// mutations
const mutations = {
  SET_PROJECT_TAB(state, data){
    state.projectTab = data;
  },

  SET_ISSUE_SIDEBAR_WIDTH(state, data){
    state.issueSidebarWidth = data;
  },

  SET_REPORT_SIDEBAR_WIDTH(state, data){
    state.reportSidebarWidth = data;
  }


  
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}