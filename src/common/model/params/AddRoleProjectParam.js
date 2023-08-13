import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddRoleProjectParam {
    constructor() {
        this.PermissionGroupID = GUID_EMPTY;
        this.ProjectID = GUID_EMPTY;
        this.PermissionGroupName = null;
        this.Description = null;
        this.CreatedDate = null;
        this.CreatedBy = null;
        this.Permissions = [];
    }
}

export default AddRoleProjectParam
