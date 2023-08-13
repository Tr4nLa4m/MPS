import { BaseRepository } from "./base/Base";
import context from "@/common/consts/MConstant";
import MConfig from "@/common/config/config";

class FileRepository extends BaseRepository {
  constructor() {
    super(context.Services.File);
  }

  async remove(fileName, onSuccess, onFailure) {
    let config = {
      url: [this._controller, fileName].join('/'),
      notLoading: true 
    }
    return this.deleteAsync(config, onSuccess, onFailure);
  }

  async download(fileName, onSuccess, onFailure) {
    let config = {
      url: [this._controller, `filename?filename=${fileName}`].join('/'),
      notLoading: true,
      isRaw: true
    }
    return this.getAsync(config, onSuccess, onFailure);
  }
}

export default new FileRepository();
