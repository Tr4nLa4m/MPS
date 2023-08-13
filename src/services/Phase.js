import { BaseRepository } from "./base/Base";
import context from "@/common/consts/MConstant";
import MConfig from "@/common/config/config";

class PhaseRepository extends BaseRepository {
  constructor() {
    super(context.Services.Phase);
  }

  async getPagingByProject(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.GET_BY_PROJECT].join("/"),
      data: data,
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async insertPhase(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.INSERT_V2].join("/"),
      data: data,
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getTaskToPhase(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.GET_TASK_TO_PHASE].join("/"),
      data: data,
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getIssueToPhase(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.GET_ISSUE_TO_PHASE].join("/"),
      data: data,
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getTaskPhase(phaseID, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.GET_TASKS, phaseID].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async getIssuePhase(phaseID, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.GET_ISSUES, phaseID].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async insertTaskPhase(payload, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.INSERT_TASK_PHASE].join("/"),
      data: payload
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async insertIssuePhase(payload, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.INSERT_ISSUE_PHASE].join("/"),
      data: payload
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async updatePhaseInfo(payload, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.UPDATE_INFO].join("/"),
      data: payload
    };
    return this.putAsync(config, onSuccess, onFailure);
  }

  async deletePhase(phaseID, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.DELETE_V2, phaseID].join("/"),
    };
    return this.deleteAsync(config, onSuccess, onFailure);
  }

  async getPhaseInfo(phaseID, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.GET_PHASE_INFO, phaseID].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async deleteTaskPhase(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.DELETE_TASK_PHASE].join("/"),
      data
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async deleteIssuePhase(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.PHASE.DELETE_ISSUE_PHASE].join("/"),
      data
    };
    return this.postAsync(config, onSuccess, onFailure);
  }
}

export default new PhaseRepository();
