import { BaseRepository } from "./base/Base";
import context from "@/common/consts/MConstant";
import MConfig from "@/common/config/config";

class IssueTypeRepository extends BaseRepository {
  constructor() {
    super(context.Services.IssueType);
  }

  async getAllByProject(projectID, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUETYPE.GET_BY_PROJECT, projectID].join('/'),
    }
    return this.getAsync(config, onSuccess, onFailure);
  }
}

export default new IssueTypeRepository();
