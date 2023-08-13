import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddEmployeeParam {
    constructor() {
        this.ProjectID = GUID_EMPTY;
        this.Employees = [];
    }
}

export default AddEmployeeParam
