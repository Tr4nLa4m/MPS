import { BaseRepository } from "./base/Base";
import context from "@/common/consts/MConstant";
import MConfig from "@/common/config/config";

class IssueCommentRepository extends BaseRepository {
  constructor() {
    super(context.Services.IssueComment);
  }

  async getByIssue(issueID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.ISSUECOMMENT.GET_BY_ISSUE,
        issueID,
      ].join("/"),
      notLoading: true
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async updateComment(comment,onSuccess, onFailure ){
    let config = {
        url: [
          this._controller,
          MConfig.APIEndPoint.ISSUECOMMENT.UPDATE,
        ].join("/"),
        data: comment,
      };
      return this.putAsync(config, onSuccess, onFailure);
  }

  async deleteComment(commentID ,onSuccess, onFailure ){
    let config = {
        url: [
          this._controller,
          MConfig.APIEndPoint.ISSUECOMMENT.DELETE,
          commentID
        ].join("/"),
      };
      return this.deleteAsync(config, onSuccess, onFailure);
  }

}

    export default new IssueCommentRepository();
