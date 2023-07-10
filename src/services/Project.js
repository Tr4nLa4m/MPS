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
}

export default new ProjectRepository();
