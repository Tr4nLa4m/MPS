import Department from "@/services/Department";
import commonFn from "@/utils/helper/commonFn";

// initial state
// shape: [{ id, quantity }]
const state = {
  departments: [],
  /** 
  {
      "DepartmentID": "48404a61-1048-11ee-98af-0242ac130002",
      "DepartmentName": "Cá nhân",
      "CreatedDate": "2023-06-21T00:00:00",
      "CreatedBy": "B-1179"
    }


  */

};

// getters
const getters = {

};

// actions
const actions = {
  async getDepartmentByEmployee({ commit, state }, payload) {
    let res = await Department.getByEmployee(payload.data?.EmployeeID);
    if (res?.Success) {
      commit("SET_DEPARTMENTS", res.Data);
    }

    return res.Data;
  },

};

// mutations
const mutations = {
  SET_DEPARTMENTS(state, data) {
    state.departments = data;
  },


};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
