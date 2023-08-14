import { BaseRepository } from "./base/Base";
import context from "@/common/consts/MConstant";
import MConfig from "@/common/config/config";

class IssueRepository extends BaseRepository {
  constructor() {
    super(context.Services.Issue);
  }

  async insertIssue(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.INSERT_V2].join('/'),
      data: data
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async updateIssue(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.UPDATE_V2].join('/'),
      data: data
    }
    return this.putAsync(config, onSuccess, onFailure);
  }
  
  async getPagingByProject(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.GET_PAGING_BY_PROJECT].join('/'),
      data: payload
    }
    return this.postAsync(config, onSuccess, onFailure);
  } 

  async getIssue(issueID, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.GET_ISSUE, issueID].join('/'),
    }
    return this.getAsync(config, onSuccess, onFailure);
  } 

  async watchIssue(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.WATCH].join('/'),
      data: payload
    }
    return this.putAsync(config, onSuccess, onFailure);
  } 

  async removeFile(payload, onSuccess, onFailure){
    let endPoint = `${MConfig.APIEndPoint.ISSUE.FILE}?issueID=${payload.IssueID}&fileID=${payload.ID}`
    let config = {
      url: [this._controller, endPoint].join('/'),
    }
    return this.deleteAsync(config, onSuccess, onFailure);
  }

  async attachFile(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.FILE].join('/'),
      data: payload
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getSolutions(projectID, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.GET_SOLUTIONS, projectID].join('/'),
    }
    return this.getAsync(config, onSuccess, onFailure);
  }

  async resolveIssue(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.RESOLVE].join('/'),
      data: payload
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async reOpenIssue(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.REOPEN].join('/'),
      data: payload
    }
    return this.putAsync(config, onSuccess, onFailure);
  }

  async closeIssue(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.CLOSE].join('/'),
      data: payload
    }
    return this.putAsync(config, onSuccess, onFailure);
  }

  async assignIssue(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.ASSIGN].join('/'),
      data: payload
    }
    return this.putAsync(config, onSuccess, onFailure);
  }

  async receiveIssue(payload, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.RECERIVE].join('/'),
      data: payload
    }
    return this.putAsync(config, onSuccess, onFailure);
  }

  async deleteIssue(issueID, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.DELETE_V2, issueID].join('/'),
    }
    return this.deleteAsync(config, onSuccess, onFailure);
  }

  async updateStatus(data, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.UPDATE_STATUS].join('/'),
      data
    }
    return this.putAsync(config, onSuccess, onFailure);
  }

  async getActivities(issueID, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.ISSUE.GET_ACTIVITIES, issueID].join('/'),
    }
    return this.getAsync(config, onSuccess, onFailure);
  }

}

    export default new IssueRepository();
