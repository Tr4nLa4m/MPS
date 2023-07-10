import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";
import MConfig from "@/common/config/config";

class PermissionGroupRepository extends BaseRepository {
  constructor() {
    super(context.Services.PermissionGroup);
  }

//   async filter(keySearch, onSuccess, onFailure){
//     let config = {
//       url: [
//         this._controller,
//         MConfig.APIEndPoint.EMPLOYEE.FILTER,
//         keySearch,
//       ].join("/"),
//       notLoading: true
//     };
//     return this.getAsync(config, onSuccess, onFailure);
//   }

  
}

export default new PermissionGroupRepository();
