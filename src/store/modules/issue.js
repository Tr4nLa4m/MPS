import Project from "@/services/Project";
import IssueType from "@/services/IssueType";
import Issue from "@/services/Issue";
import IssueComment from "@/services/IssueComment";
import commonFn from "@/utils/helper/commonFn";

// initial state
// shape: [{ id, quantity }]
const state = {
  issueTypes: [],
  /** 
  {
      "IssueTypeID": "3a633891-23ad-11ee-9412-0242ac130002",
      "IssueTypeName": "Lỗi phần mềm",
      "Description": "Lỗi phần mềm cần khắc phục",
      "SortOrder": 1,
      "CreatedDate": "2023-07-16T14:49:01",
      "CreatedBy": "B-1179",
      "MyProperty": 0
    }
  */

  issue: {},

  issues: [],

  comments: [],

  activities: [],

  solutions: [],

  priorities: [
    {
      Priority: 1,
      PriorityName: 'Thấp'
    },
    {
      Priority: 2,
      PriorityName: 'Vừa'
    },
    {
      Priority: 3,
      PriorityName: 'Cao'
    }
  ]
};

// getters
const getters = {};

// actions
const actions = {
  async getIssueTypesByProject({ commit, state }, payload) {
    let res = await IssueType.getAllByProject(payload?.data?.ProjectID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
      commit("SET_ISSUETYPES", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertIssue({ commit, state }, payload){
    let res = await Issue.insertIssue(payload?.data);
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

  async getIssuesByProject({ commit, state }, payload) {
    let res = await Issue.getPagingByProject(payload?.data);
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

  async getIssue({ commit, state }, payload) {
    let res = await Issue.getIssue(payload?.data?.IssueID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit('SET_ISSUE', res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async watchIssue({ commit, state }, payload) {
    let res = await Issue.watchIssue(payload?.data);
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

  async getIssueComments({ commit, state }, payload) {
    let res = await IssueComment.getByIssue(payload?.data?.IssueID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
      commit('SET_COMMENTS', res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertComment({ commit, state }, payload) {
    let res = await IssueComment.create(payload?.data);
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

  async updateIssue({ commit, state }, payload) {
    let res = await Issue.updateIssue(payload?.data);
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

  async updateComment({ commit, state }, payload) {
    let res = await IssueComment.updateComment(payload?.data);
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

  async deleteComment({ commit, state }, payload) {
    let res = await IssueComment.deleteComment(payload?.data?.CommentID);
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

  async removeFile({ commit, state }, payload) {
    let res = await Issue.removeFile(payload?.data);
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


  async attachFile({ commit, state }, payload) {
    let res = await Issue.attachFile(payload?.data);
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

  async resolveIssue({ commit, state }, payload) {
    let res = await Issue.resolveIssue(payload?.data);
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

  async reOpenIssue({ commit, state }, payload) {
    let res = await Issue.reOpenIssue(payload?.data);
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

  async closeIssue({ commit, state }, payload) {
    let res = await Issue.closeIssue(payload?.data);
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

  async assignIssue({ commit, state }, payload) {
    let res = await Issue.assignIssue(payload?.data);
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

  async receiveIssue({ commit, state }, payload) {
    let res = await Issue.receiveIssue(payload?.data);
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

  async deleteIssue({ commit, state }, payload) {
    let res = await Issue.deleteIssue(payload?.data?.IssueID);
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

  async getSolutions({ commit, state }, payload) {
    let res = await Issue.getSolutions(payload?.data?.ProjectID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit('SET_SOLUTIONS', res.Data);

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
  SET_ISSUETYPES(state, data) {
    state.issueTypes = data;
  },

  SET_ISSUE(state, data){
    state.issue = data;
  },

  SET_COMMENTS(state, data){
    state.comments = data;
  },

  SET_SOLUTIONS(state, data){
    state.solutions = data;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
