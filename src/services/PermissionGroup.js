import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class PermissionGroupRepository extends BaseRepository {
  constructor() {
    super(context.Services.PermissionGroup);
  }

  async getByProject(projectID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.GET_BY_PROJECT,
        projectID,
      ].join("/"),
      notLoading: true
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async getByDepartment(departmentID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.GET_BY_DEPARTMENT,
        departmentID,
      ].join("/"),
      notLoading: true
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async setEmployeeProjectRole(data, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.SET_EMPLOYEE_PROJECT_ROLE,
      ].join("/"),
      data,
    };
    return this.putAsync(config, onSuccess, onFailure);
  }

  async getProjectPermission(data, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.GET_PROJECT_PERMISSION,
      ].join("/"),
      data,
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async insertProjectRole(data, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.INSERT_PROJECT_ROLE,
      ].join("/"),
      data,
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getProjectRolePermissions(permissionGroupID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.GET_PROJECT_ROLE_PERMISSIONS,
        permissionGroupID
      ].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async updateProjectRole(data, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.UPDATE_PROJECT_ROLE,
      ].join("/"),
      data
    };
    return this.putAsync(config, onSuccess, onFailure);
  }

  async deleteProjectRole(data, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.DELETE_PROJECT_ROLE,
      ].join("/"),
      data
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async checkProjectRoleInUse(data, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.CHECK_PROJECT_ROLE_INUSE,
      ].join("/"),
      data
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getEmployeeProjectPermission(employeeID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.PERMISSIONGROUP.GET_EMPLOYEE_PROJECT_PERMISSIONS,
        employeeID
      ].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  
}

export default new PermissionGroupRepository();
