import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";


class TaskRepository extends BaseRepository {
  constructor() {
    super(context.Services.Task);
  }

  async createV2(dataObject, onSuccess, onFailure){
    let config = {
        url: [this._controller, MConfig.APIEndPoint.TASK.INSERT_V2].join('/'),
        data: dataObject
      }
      return this.postAsync(config, onSuccess, onFailure);
  }

  async getPagingByProject(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.GET_PAGING_BY_PROJECT].join('/'),
      data: payload
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getFullInfo(taskID, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.GET_INFO, taskID].join('/'),
    }
    return this.getAsync(config, onSuccess, onFailure);
  }

  async updateTaskField(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.UPDATE_FIELD].join('/'),
      data: payload,
      notLoading: true
    }
    return this.putAsync(config, onSuccess, onFailure);
  }

  async deleteChecklist(data, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.DELETE_CHECKLIST].join('/'),
      data
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async insertChecklist(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.INSERT_CHECKLIST].join('/'),
      data: payload
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async insertSubtask(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.INSERT_SUBTASKS].join('/'),
      data: payload
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async deleteTaskV2(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.DELETE_V2].join('/'),
      data: payload
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getTaskByTaskGroups(projectID, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.GET_TASK_BY_TASKGROUPS, projectID].join('/'),
    }
    return this.getAsync(config, onSuccess, onFailure);
  }
  
  async updateTaskGroupTask(data, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.UPDATE_TASKGROUP_TASK].join('/'),
      data,
      notLoading: true
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async insertTaskGroup(data, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.INSERT_TASK_GROUP].join('/'),
      data,
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async updateTaskGroup(data, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.UPDATE_TASK_GROUP].join('/'),
      data,
    }
    return this.putAsync(config, onSuccess, onFailure);
  }

  async deleteTaskGroup(taskgroupID, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.TASK.DELETE_TASK_GROUP, taskgroupID].join('/'),
    }
    return this.deleteAsync(config, onSuccess, onFailure);
  }
}

export default new TaskRepository();
