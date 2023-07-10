import Project from "@/services/Project";
import Employee from "@/services/Employee";
import commonFn from "@/utils/helper/commonFn";

// initial state
// shape: [{ id, quantity }]
const state = {
  projects: [],
  /** 
  {
    "DepartmentName": "Cá nhân",
    "ProjectID": "9a78db36-1048-11ee-98af-0242ac130002",
    "ProjectName": "Công việc cá nhân",
    "DepartmentID": "48404a61-1048-11ee-98af-0242ac130002",
    "StartDate": "2023-02-21T00:00:00",
    "EndDate": null,
    "Description": "Dự án công việc cá nhân của nhân viên",
    "CreatedDate": "2023-06-21T00:00:00",
    "CreatedBy": "B-1179"
  }

  {
    "DepartmentName": "Cá nhân",
    "DepartmentID": "48404a61-1048-11ee-98af-0242ac130002",
    Projects: [
        "ProjectID": "9a78db36-1048-11ee-98af-0242ac130002",
        "ProjectName": "Công việc cá nhân",
        "StartDate": "2023-02-21T00:00:00",
        "EndDate": null,
        "Description": "Dự án công việc cá nhân của nhân viên",
        "CreatedDate": "2023-06-21T00:00:00",
        "CreatedBy": "B-1179"
    ]
    
  }
  */

  project: {},

  // danh sách nhân viên trong dự án
  employees: [
    /** 
  {
    UserID: "00000000-0000-0000-0000-000000000000"
    Avatar: "https://lh3.googleusercontent.com/a/AAcHTte7c6WXWPi4DFYDRRXFjOxHixHA--UZAsu5NFbE_g=s360-c-no"
    EmployeeID: "53da58f8-ef0d-11ed-ae2b-0242ac130002"
    Username: "B-1179,
    Email
  }
  */
  ]
};

// getters
const getters = {
  departmentProjects: (state, getters, rootState) => {
    return commonFn.getDepartmentProject(state.projects);
  },
  // cartTotalPrice: (state, getters) => {
  //   return getters.cartProducts.reduce((total, product) => {
  //     return total + product.price * product.quantity
  //   }, 0)
  // }
};

// actions
const actions = {
  async getProjectByEmployee({ commit, state }, payload) {
    let res = await Project.getByEmployee(payload?.EmployeeID);
    if (res?.Success) {
      commit("SET_PROJECTS", res.Data);
    }

    return res.Data;
  },

  async getProjectById({ commit, state }, payload){
    let res = await Project.getById(payload?.ProjectID);

    if (res?.Success) {
      commit("SET_PROJECT", res.Data);
      return res.Data;

    }
    return null;

  },

  async getEmployees({ commit, state }, payload){
    let res = await Project.getEmployees(payload?.ProjectID);

    if(res?.Success){
      commit("SET_EMPLOYEES", res.Data);
      return res.Data;
    }

    return null;
  },

  async insertProject({ commit, state }, payload){
    let res = await Project.insertProject(payload?.data);

    if (res?.Success) {
      if(payload?.onSuccess){
        payload.onSuccess();
      }
    }
    else{
      if(payload?.onFailure){
        payload.onFailure();
      }
    }

    return res.Data;
  }


};

// mutations
const mutations = {
  SET_PROJECTS(state, data) {
    state.projects = data;
  },

  SET_PROJECT(state, data) {
    state.project = data;
  },

  SET_EMPLOYEES(state, data){
    state.employees = data;
  },
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
