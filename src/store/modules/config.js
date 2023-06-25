
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
  }
}

// mutations
const mutations = {
  SET_PROJECT_TAB(state, data){
    state.projectTab = data;
  },


  
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}