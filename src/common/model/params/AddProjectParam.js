import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddProjectParam {
    constructor() {
        this.ProjectID = GUID_EMPTY;
        this.ProjectName = null;
        this.DepartmentID = null;
        this.StartDate = null;
        this.EndDate = null;
        this.Description = null;
        this.CreatedBy = null;
        this.Employees = [];
    }
}

export default AddProjectParam
