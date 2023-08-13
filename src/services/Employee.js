import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class EmployeeRepository extends BaseRepository {
  constructor() {
    super(context.Services.Employee);
  }

  async filter(keySearch, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.EMPLOYEE.FILTER,
        keySearch,
      ].join("/"),
      notLoading: true
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async getByDepartment(DepartmentID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.EMPLOYEE.GET_BY_DEPARTMENT,
        DepartmentID,
      ].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }
  
}

export default new EmployeeRepository();
