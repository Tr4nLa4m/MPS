import { GUID_EMPTY } from "@/common/consts/MConstant";
import auth from "@/services/Auth";
import Employee from "@/services/Employee";
import PermissionGroup from "@/services/PermissionGroup";
import jwtDecode from "jwt-decode";

// initial state
// shape: [{ id, quantity }]
const state = {
  user: {},
  /** 
  {
    UserID: "00000000-0000-0000-0000-000000000000"
    Avatar: "https://lh3.googleusercontent.com/a/AAcHTte7c6WXWPi4DFYDRRXFjOxHixHA--UZAsu5NFbE_g=s360-c-no"
    EmployeeID: "53da58f8-ef0d-11ed-ae2b-0242ac130002"
    Username: "B-1179
  }
  */

  employee: {},

  /**
   * {
    "EmployeeID": "53da58f8-ef0d-11ed-ae2b-0242ac130002",
    "EmployeeCode": "B-1179",
    "FullName": "Trần Ngọc Lâm",
    "StructureID": "17f09da8-fd33-11ed-a39f-0242ac130002",
    "PositionName": "Quản trị viên",
    "Email": "tnlam.software@gmail.com",
    "Level": null
  }
   */
  projectPermissionGroups: [
    // {
    //   "PermissionGroupID": "aabd7d56-1822-11ee-9a50-0242ac130002",
    //   "PermissionGroupName": "Toàn quyền",
    //   "ProjectID": null,
    //   "Description": "Toàn quyền với Dự án/Nhóm",
    //   "CreatedDate": "2023-06-30T00:00:00",
    //   "CreatedBy": null
    // }
  ],

  departmentPermissionGroups: [

  ],


  permissions: [],

  token: "",

  tokenExpired: null,
};

// getters
const getters = {
  getUserInfo: (state, getters, rootState) => {
    return {
      ...state.user,
      ...state.employee,
    };
  },

  getUserProjectPermission: (state, getters) => (projectID) => {
    if(!projectID){
      return state.permissions;
    }
    return state.permissions.filter(permission => permission.ProjectID == projectID);
  }
};

// actions
const actions = {
  async login({ commit, state }, payload) {

    let res = await auth.login(payload);
    if(res?.Data?.Token){
      let token = res.Data.Token;
      commit("SET_TOKEN", token);
    }

    const employeeID = res?.Data?.User?.EmployeeID;
    let res1 = await Employee.getById(employeeID);
    if (res1.Success) {
      commit("SET_EMPLOYEE", res1.Data);
    }
    return res1.Data;
  },

  async getEmployee({ commit, state }, payload) {
    let res = await Employee.getById(payload?.EmployeeID);
    commit("SET_EMPLOYEE", res.Data);
    return res.Data;
  },

  async getInitProjectPermissionGroups({ commit, state }, payload) {
    let defaultProject = GUID_EMPTY;
    let res = await PermissionGroup.getByProject(defaultProject);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_PROJECT_PERMISSION_GROUPS", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getInitDepartmentPermissionGroups({ commit, state }, payload) {
    let defaultDepartment = GUID_EMPTY;
    let res = await PermissionGroup.getByDepartment(defaultDepartment);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_DEPARTMENT_PERMISSION_GROUPS", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getProjectPermissionGroups({ commit, state }, payload) {
    let res = await PermissionGroup.getByProject(payload.data?.ProjectID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_PROJECT_PERMISSION_GROUPS", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getDepartmentPermissionGroups({ commit, state }, payload) {
    let res = await PermissionGroup.getByDepartment(payload.data?.DepartmentID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_DEPARTMENT_PERMISSION_GROUPS", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getEmployeeProjectPermission({ commit, state }, payload) {
    let res = await PermissionGroup.getEmployeeProjectPermission(payload.data?.EmployeeID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
      commit("SET_PERMISSIONS", res.Data);
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
  SET_USER(state, user) {
    state.user = user;
  },

  SET_EMPLOYEE(state, data) {
    state.employee = data;
  },

  SET_TOKEN(state, data){
    let payload = jwtDecode(data);
    state.token = data;
    state.tokenExpired = new Date(payload.exp * 1000);
  },

  SET_PROJECT_PERMISSION_GROUPS(state, data) {
    state.projectPermissionGroups = data;
  },

  SET_DEPARTMENT_PERMISSION_GROUPS(state, data) {
    state.departmentPermissionGroups = data;
  },

  SET_PERMISSIONS(state, data) {
    state.permissions = data;
  },
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
