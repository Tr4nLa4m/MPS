import Phase from "@/services/Phase";
import commonFn from "@/utils/helper/commonFn";

// initial state
// shape: [{ id, quantity }]
const state = {
  phases: [],
  /** 
  {
      "PostTagID": "a4f900bd-2ef1-11ee-a545-0242ac130002",
      "ProjectID": "dcb94c92-1048-11ee-98af-0242ac130002",
      "PostTagName": "Nhãn C",
      "CreatedDate": "2023-07-30T22:56:28",
      "CreatedBy": "B-1179"
    }
  */

  phase: {},

  taskToPhase: [],

  issueToPhase: []

};

// getters
const getters = {};

// actions
const actions = {
  async getPhaseByProject({ commit, state }, payload) {
    let res = await Phase.getPagingByProject(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
      commit("SET_PHASES", res.Data.data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertPhase({ commit, state }, payload) {
    let res = await Phase.insertPhase(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getTaskToPhase({ commit, state }, payload) {
    let res = await Phase.getTaskToPhase(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_TASK_TO_PHASE", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getIssueToPhase({ commit, state }, payload) {
    let res = await Phase.getIssueToPhase(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_ISSUE_TO_PHASE", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getTasks({ commit, state }, payload) {
    let res = await Phase.getTaskPhase(payload?.data?.PhaseID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getIssues({ commit, state }, payload) {
    let res = await Phase.getIssuePhase(payload?.data?.PhaseID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getPhase({ commit, state }, payload) {
    let res = await Phase.getPhaseInfo(payload?.data?.PhaseID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_PHASE", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async updatePhase({ commit, state }, payload) {
    let res = await Phase.updatePhaseInfo(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }
    return res.Data;
  },

  async deletePhase({ commit, state }, payload) {
    let res = await Phase.deletePhase(payload?.data?.PhaseID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async deleteTaskPhase({ commit, state }, payload) {
    let res = await Phase.deleteTaskPhase(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async deleteIssuePhase({ commit, state }, payload) {
    let res = await Phase.deleteIssuePhase(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertTaskPhase({ commit, state }, payload) {
    let res = await Phase.insertTaskPhase(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertIssuePhase({ commit, state }, payload) {
    let res = await Phase.insertIssuePhase(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },
};

// mutations
const mutations = {
  SET_PHASES(state, data) {
    state.phases = data;
  },

  SET_PHASE(state, data){
    state.phase = data;
  },

  SET_TASK_TO_PHASE(state, data){
    state.taskToPhase = data;
  },

  SET_ISSUE_TO_PHASE(state, data){
    state.issueToPhase = data;
  },

};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
