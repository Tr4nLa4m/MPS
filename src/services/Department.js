import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class DepartmentRepository extends BaseRepository {
  constructor() {
    super(context.Services.Department);
  }

  async getByEmployee(employeeID, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.DEPARTMENT.GET_BY_EMPLOYEE,
        employeeID,
      ].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }
}

export default new DepartmentRepository();
