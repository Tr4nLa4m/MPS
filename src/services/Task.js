import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class TaskRepository extends BaseRepository {
  constructor() {
    super(context.Services.Auth);
  }

  async login(loginData, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.LOGIN].join('/'),
      data: loginData
    }
    return this.postAsync(config, onSuccess, onFailure);
  }
}

export default new TaskRepository();
