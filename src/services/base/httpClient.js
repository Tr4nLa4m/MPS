import axios from "axios";
import { useRouter } from "vue-router";
import commonFn from "@/utils/helper/commonFn";

class httpClient {
  //#region Propertiesa
  _repository;
  _router;
  _controller;
  //#endregion

  //#region Constructor
  constructor(url) {
    this._router = useRouter();
    this._repository = axios.create({ 
      baseURL: url ,

    });
  }
  //#endregion

  setAuthorizationToken(token) {
    this._repository.defaults.headers.common['Authorization'] = `Bearer ${token}`;
  }

  //#region Methods

  //getter

  async getAsync(config, onSuccess, onFailure) {
    let {url, notLoading} = config;
    if(!notLoading){
      commonFn.mask();
    }

    try {
      const response = await this._repository.get(url);
      if (onSuccess && response.status === 200) {
        onSuccess(response);
      }
      commonFn.unmask();
      return response.data;
    } catch (error) {
      this.handleOnError(error, onFailure);
    }
  }

  async postAsync(config, onSuccess, onFailure) {
    let {url, data, notLoading} = config;
    if(!notLoading){
      commonFn.mask();
    }

    try {
      const response = await this._repository.post(url, data);
      if (onSuccess && response.status === 200) {
        onSuccess(response);
      }
      commonFn.unmask();
      return response.data;
    } catch (error) {
      this.handleOnError(error, onFailure);
    }
  }

  async putAsync(config, onSuccess, onFailure) {
    let {url, data, notLoading} = config;
    if(!notLoading){
      commonFn.mask();
    }

    try {
      const response = await this._repository.put(url, data);
      if (onSuccess && response.status === 200) {
        onSuccess(response);
      }
      commonFn.unmask();
      return response.data;
    } catch (error) {
      this.handleOnError(error, onFailure);
    }
  }

  async deleteAsync(config, onSuccess, onFailure) {
    let {url, notLoading} = config;
    if(!notLoading){
      commonFn.mask();
    }

    try {
      const response = await this._repository.delete(url);
      if (onSuccess && response.status === 200) {
        onSuccess(response);
      }
      commonFn.unmask();
      return response.data;
    } catch (error) {
      this.handleOnError(error, onFailure);
    }
  }

  handleOnError(error, onFailure) {
    if (onFailure && typeof onFailure == "function") {
      onFailure(error.response);
    }

    if (error.response && error.response.status === 401) {
      this._router.push("/login");
      console.log("Unauthorized access!"); // Log the 401 error
    }

    commonFn.unmask();
    console.error(error)
  }

  //#endregion
}

export { httpClient };
