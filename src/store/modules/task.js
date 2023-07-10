import Project from "@/services/Project";
import TaskGroup from "@/services/TaskGroup";
import TaskComment from "@/services/TaskComment";
import TaskActivity from "@/services/TaskActivity";
import Task from "@/services/Task";
import commonFn from "@/utils/helper/commonFn";
import { useMessage } from "naive-ui";

// initial state
// shape: [{ id, quantity }]
const state = {
  taskGroups: [],
  /** 
  {
      "TaskGroupID": "08a80adc-133d-11ee-80cb-0242ac130002",
      "TaskGroupName": "Đã thực hiện",
      "CreatedDate": null,
      "CreatedBy": null
    },
    
  }
  */

  project: {},

  comments: [
    // {
    //   "EmployeeCode": "B-1179",
    //   "FullName": "Trần Ngọc Lâm",
    //   "EmployeeID": "53da58f8-ef0d-11ed-ae2b-0242ac130002",
    //   "Avatar": "https://lh3.googleusercontent.com/a/AAcHTte7c6WXWPi4DFYDRRXFjOxHixHA--UZAsu5NFbE_g=s360-c-no",
    //   "Email": "tnlam.software@gmail.com",
    //   "PositionName": "Quản trị viên",
    //   "CommentID": "85573e14-1cf2-11ee-9bbf-0242ac130002",
    //   "TaskID": "304fea50-ac60-4410-9280-41c90bfea393",
    //   "Content": "Bây giờ là mấy giờ rồi",
    //   "CreatedDate": "2023-07-08T01:17:23",
    //   "CreatedBy": "B-1179",
    //   "ModifiedDate": "2023-07-08T01:17:23"
    // }
  ],

  activities: [
    // {
    //   "EmployeeCode": "B-1179",
    //   "FullName": "Trần Ngọc Lâm",
    //   "EmployeeID": "53da58f8-ef0d-11ed-ae2b-0242ac130002",
    //   "Avatar": "https://lh3.googleusercontent.com/a/AAcHTte7c6WXWPi4DFYDRRXFjOxHixHA--UZAsu5NFbE_g=s360-c-no",
    //   "Email": "tnlam.software@gmail.com",
    //   "PositionName": "Quản trị viên",
    //   "ActionText": "Đã sửa bình luận",
    //   "ActivityID": "6eca4f0f-1d69-11ee-9bbf-0242ac130002",
    //   "TaskID": "304fea50-ac60-4410-9280-41c90bfea393",
    //   "Column": "TaskComment",
    //   "OldValue": "Comment Test",
    //   "NewValue": "Comment Test 1",
    //   "Type": 2,
    //   "CreatedDate": "2023-07-08T15:28:36",
    //   "CreatedBy": "B-1179"
    // }
  ]
};

// getters
const getters = {
  //   departmentProjects: (state, getters, rootState) => {
  //     return commonFn.getDepartmentProject(state.projects);
  //   },
};

// actions
const actions = {
  async getTaskGroups({ commit, state }, payload) {
    let res = await TaskGroup.getAll();
    if (res?.Success) {
      commit("SET_TASKGROUPS", res.Data);
      if(payload?.onSuccess){
        payload.onSuccess();
      }
    }
    else{
      const message = useMessage();
      message.error(res.UserMsg)
    }

    return res.Data;
  },

  async createTask({commit}, payload){
    let res = await Task.createV2(payload.Data);
    if (res?.Success) {
      commit("SET_TASKGROUPS", res.Data);
      if(payload?.onSuccess){
        payload.onSuccess();
      }
    }
    else{
      console.log(res);
      if(payload?.onFailure){
        payload.onFailure();
      }
    }

    return res?.Data;
  },

  async getTaskByProject({commit}, payload){
    let res = await Task.getPagingByProject(payload?.data);
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
  },

  async getByID({commit}, payload){
    let res = await Task.getFullInfo(payload?.data?.TaskID);
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
  },

  async getCommentByTask({commit}, payload){
    let res = await TaskComment.getByTask(payload?.data?.TaskID);
    if (res?.Success) {
      if(payload?.onSuccess){
        payload.onSuccess(res.Data);
      }

      commit('SET_COMMENTS', res.Data);
    }
    else{
      if(payload?.onFailure){
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertComment({commit}, payload){
    let res = await TaskComment.create(payload?.data);
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
  },

  async updateComment({commit}, payload){
    let res = await TaskComment.updateComment(payload?.data);
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
  },

  async deleteComment({commit}, payload){
    let res = await TaskComment.deleteComment(payload?.data?.CommentID);
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
  },

  async getActivitiesByTask({commit}, payload){
    let res = await TaskActivity.getByTask(payload?.data?.TaskID);
    if (res?.Success) {
      if(payload?.onSuccess){
        payload.onSuccess(res);
      }

      commit('SET_ACTIVITIES', res.Data)
    }
    else{
      if(payload?.onFailure){
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async updateTaskField({commit}, payload){
    let res = await Task.updateTaskField(payload?.data);
    if (res?.Success) {
      if(payload?.onSuccess){
        payload.onSuccess(res);
      }
    }
    else{
      if(payload?.onFailure){
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async deleteTask({commit}, payload){
    let res = await Task.delete(payload?.data?.TaskID);
    if (res?.Success) {
      if(payload?.onSuccess){
        payload.onSuccess(res);
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
  SET_TASKGROUPS(state, data) {
    state.taskGroups = data;
  },

  SET_PROJECT(state, data) {
    state.project = data;
  },

  SET_COMMENTS(state, data){
    state.comments = data;
  },

  SET_ACTIVITIES(state, data){
    state.activities = data;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
