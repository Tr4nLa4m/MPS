import { BaseRepository } from "./base/Base";
import context from "@/common/consts/MConstant";
import MConfig from "@/common/config/config";

class PostRepository extends BaseRepository {
  constructor() {
    super(context.Services.Post);
  }

  async insertPost(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.INSERT_V2].join("/"),
      data: data,
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getPagingByProject(payload, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.POST.GET_PAGING_BY_PROJECT,
      ].join("/"),
      data: payload,
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async getTags(projectID, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.GET_TAG, projectID].join(
        "/"
      ),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async getCategories(projectID, onSuccess, onFailure) {
    let config = {
      url: [
        this._controller,
        MConfig.APIEndPoint.POST.GET_CATEGORY,
        projectID,
      ].join("/"),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async getPost(postID, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.GET_POST, postID].join(
        "/"
      ),
    };
    return this.getAsync(config, onSuccess, onFailure);
  }

  async updatePost(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.UPDATE_V2].join(
        "/"
      ),
      data
    };
    return this.putAsync(config, onSuccess, onFailure);
  }

  async watchPost(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.WATCH].join(
        "/"
      ),
      data
    };
    return this.putAsync(config, onSuccess, onFailure);
  }

  async deletePost(postID, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.DELETE_V2, postID].join('/'),
    }
    return this.deleteAsync(config, onSuccess, onFailure);
  }

  async sharePost(data, onSuccess, onFailure){
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.SHARE].join('/'),
      data
    }
    return this.postAsync(config, onSuccess, onFailure);
  }

  async insertCategory(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.CATEGORY].join(
        "/"
      ),
      data
    };
    return this.postAsync(config, onSuccess, onFailure);
  }

  async updateCategory(data, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.CATEGORY].join(
        "/"
      ),
      data
    };
    return this.putAsync(config, onSuccess, onFailure);
  }

  async deleteCategory(categoryID, onSuccess, onFailure) {
    let config = {
      url: [this._controller, MConfig.APIEndPoint.POST.CATEGORY, categoryID].join(
        "/"
      )
    };
    return this.deleteAsync(config, onSuccess, onFailure);
  }
}

export default new PostRepository();
