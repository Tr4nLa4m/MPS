import { GUID_EMPTY, ISSUE_CONTACT_INFO_INIT } from "@/common/consts/MConstant";

class AddDepartmentParam {
    constructor() {
        this.DepartmentName = null;
        this.Description = null;
        this.CreatedDate = null;
        this.CreatedBy = null;
        this.Employees = [];
    }
}

export default AddDepartmentParam
