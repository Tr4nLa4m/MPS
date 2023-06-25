import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";

class EmployeeRepository extends BaseRepository {
  constructor() {
    super(context.Services.Employee);
  }

  
}

export default new EmployeeRepository();
