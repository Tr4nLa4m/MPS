import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class ProjectRepository extends BaseRepository {
  constructor() {
    super(context.Services.Project);
  }

  async getByEmployee(employeeID, onSuccess, onFailure){
    let config = {
        url: [this._controller, MConfig.APIEndPoint.GET_PROJECT_BY_EMPLOYEE, employeeID].join('/'),
      }
      return this.getAsync(config, onSuccess, onFailure);
  }
  
}

export default new ProjectRepository();
