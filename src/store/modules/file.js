import File from "@/services/File";
import commonFn from "@/utils/helper/commonFn";

const state = {

};

// getters
const getters = {};

// actions
const actions = {

  async removeFile({ commit, state }, payload) {
    let res = await File.remove(payload?.data?.FileName);
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

  async download({ commit, state }, payload) {
    let res = await File.download(payload?.data?.FileName);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res;
  },
};

// mutations
const mutations = {

};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
