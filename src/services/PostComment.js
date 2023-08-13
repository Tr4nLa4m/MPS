import { BaseRepository } from "./base/Base";
import context from "@/common/consts/MConstant";
import MConfig from "@/common/config/config";

class PostCommentRepository extends BaseRepository {
  constructor() {
    super(context.Services.PostComment);
  }

  async getByPost(postID, onSuccess, onFailure){
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.POSTCOMMENT.GET_BY_POST,
        postID,
      ].join("/"),
      notLoading: true
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async updateComment(comment,onSuccess, onFailure ){
    let config = {
        url: [
          this._controller,
          MConfig.APIEndPoint.POSTCOMMENT.UPDATE,
        ].join("/"),
        data: comment,
      };
      return this.putAsync(config, onSuccess, onFailure);
  }

  async deleteComment(commentID ,onSuccess, onFailure ){
    let config = {
        url: [
          this._controller,
          MConfig.APIEndPoint.POSTCOMMENT.DELETE,
          commentID
        ].join("/"),
      };
      return this.deleteAsync(config, onSuccess, onFailure);
  }

}

    export default new PostCommentRepository();
