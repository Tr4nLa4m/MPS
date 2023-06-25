import { BaseRepository } from "./base/Base";
import context from "../common/consts/MConstant";

class UserRepository extends BaseRepository {
  constructor() {
    super(context.Services.User);
  }

  
}

export default new UserRepository();
