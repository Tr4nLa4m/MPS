import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class TaskActivityRepository extends BaseRepository {
  constructor() {
    super(context.Services.TaskActivity);
  }

  async getByTask(taskID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.TASKACTIVITY.GET_BY_TASK,
        taskID,
      ].join("/"),
      notLoading: true
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  
}

export default new TaskActivityRepository();
