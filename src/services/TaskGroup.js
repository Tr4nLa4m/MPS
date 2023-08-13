import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";

class TaskGroupRepository extends BaseRepository {
  constructor() {
    super(context.Services.TaskGroup);
  }

  
}

export default new TaskGroupRepository();
