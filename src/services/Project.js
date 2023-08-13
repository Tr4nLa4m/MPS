import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class ProjectRepository extends BaseRepository {
  constructor() {
    super(context.Services.Project);
  }

  async getByEmployee(employeeID, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.GET_PROJECT_BY_EMPLOYEE,
        employeeID,
      ].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async getEmployees(projectID, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.GET_EMPLOYEES,
        projectID,
      ].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async insertProject(data, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.INSERT_V2,
      ].join("/"),
      data
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getNumberTaskStatusReport(param, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.GET_NUMBER_TASK_STATUS_REPORT,
      ].join("/"),
      data: param
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getNumberTaskGroupReport(param, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.GET_NUMBER_TASK_GROUP_REPORT,
      ].join("/"),
      data: param
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getNumberTaskStatusByAssigneeReport(param, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.GET_NUMBER_TASK_STATUS_BY_ASSIGNEE_REPORT,
      ].join("/"),
      data: param
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async removeEmployee(param, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.REMOVE_EMPLOYEE,
      ].join("/"),
      data: param
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async insertEmployees(param, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.INSERT_EMPLOYEES,
      ].join("/"),
      data: param
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getFilePaging(param, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.GET_FILE_PAGING,
      ].join("/"),
      data: param
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async uploadFileProject(param, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.UPLOAD_FILE,
      ].join("/"),
      data: param
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async deleteFiles(param, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PROJECT.DELETE_FILES,
      ].join("/"),
      data: param
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  
}

export default new ProjectRepository();
