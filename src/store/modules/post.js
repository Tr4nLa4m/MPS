import Post from "@/services/Post";
import PostComment from "@/services/PostComment";
import commonFn from "@/utils/helper/commonFn";

// initial state
// shape: [{ id, quantity }]
const state = {
  tags: [],
  /** 
  {
      "PostTagID": "a4f900bd-2ef1-11ee-a545-0242ac130002",
      "ProjectID": "dcb94c92-1048-11ee-98af-0242ac130002",
      "PostTagName": "Nhãn C",
      "CreatedDate": "2023-07-30T22:56:28",
      "CreatedBy": "B-1179"
    }
  */
  categories: [],
  /** 
  {
      "PostCategoryID": "447ffe62-2eef-11ee-a545-0242ac130002",
      "ProjectID": "dcb94c92-1048-11ee-98af-0242ac130002",
      "CategoryName": "Triển khai",
      "CreatedDate": "2023-07-30T22:39:27",
      "CreatedBy": "B-1179"
    }
  */

  post: {},

  posts: [],

  comments: [],
};

// getters
const getters = {};

// actions
const actions = {
  async getPostsByProject({ commit, state }, payload) {
    let res = await Post.getPagingByProject(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
      commit("SET_POSTS", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertPost({ commit, state }, payload) {
    let res = await Post.insertPost(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getTagsByProject({ commit, state }, payload) {
    let res = await Post.getTags(payload?.data?.ProjectID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_TAGS", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getCategoriesByProject({ commit, state }, payload) {
    let res = await Post.getCategories(payload?.data?.ProjectID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_CATEGORIES", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getPost({ commit, state }, payload) {
    let res = await Post.getPost(payload?.data?.PostID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }

      commit("SET_POST", res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getPostComments({ commit, state }, payload) {
    let res = await PostComment.getByPost(payload?.data?.PostID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
      commit('SET_COMMENTS', res.Data);
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertComment({ commit, state }, payload) {
    let res = await PostComment.create(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async updatePost({ commit, state }, payload) {
    let res = await Post.update(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }
    return res.Data;
  },

  async updatePostV2({ commit, state }, payload) {
    let res = await Post.updatePost(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }
    return res.Data;
  },

  async updateComment({ commit, state }, payload) {
    let res = await PostComment.updateComment(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async deleteComment({ commit, state }, payload) {
    let res = await PostComment.deleteComment(payload?.data?.CommentID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async watchPost({ commit, state }, payload) {
    let res = await Post.watchPost(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async deletePost({ commit, state }, payload) {
    let res = await Post.deletePost(payload?.data?.PostID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async sharePost({ commit, state }, payload) {
    let res = await Post.sharePost(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async insertCategory({ commit, state }, payload) {
    let res = await Post.insertCategory(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async updateCategory({ commit, state }, payload) {
    let res = await Post.updateCategory(payload?.data);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async deleteCategory({ commit, state }, payload) {
    let res = await Post.deleteCategory(payload?.data?.PostCategoryID);
    if (res?.Success) {
      if (payload?.onSuccess) {
        payload.onSuccess();
      }
    } else {
      if (payload?.onFailure) {
        payload.onFailure();
      }
    }

    return res.Data;
  },
};

// mutations
const mutations = {
  SET_POSTS(state, data) {
    state.posts = data;
  },

  SET_POST(state, data){
    state.post = data;
  },

  SET_TAGS(state, data) {
    state.tags = data;
  },

  SET_CATEGORIES(state, data) {
    state.categories = data;
  },

  SET_COMMENTS(state, data){
    state.comments = data;
  }
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
