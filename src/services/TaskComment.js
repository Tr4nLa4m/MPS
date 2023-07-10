import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class TaskCommentRepository extends BaseRepository {
  constructor() {
    super(context.Services.TaskComment);
  }

  async getByTask(taskID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.TASKCOMMENT.GET_BY_TASK,
        taskID,
      ].join("/"),
      notLoading: true
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async updateComment(comment,onSuccess, onFailure ){
    let config = {
        url: [
          this._controller,
          MConfig.APIEndPoint.TASKCOMMENT.UPDATE,
        ].join("/"),
        data: comment,
      };
      return this.putAsync(config, onSuccess, onFailure);
  }

  async deleteComment(commentID ,onSuccess, onFailure ){
    let config = {
        url: [
          this._controller,
          MConfig.APIEndPoint.TASKCOMMENT.DELETE,
          commentID
        ].join("/"),
      };
      return this.deleteAsync(config, onSuccess, onFailure);
  }

  
}

export default new TaskCommentRepository();
