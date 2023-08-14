import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddTaskGroupParam {
    constructor() {
        this.TaskGroupID = GUID_EMPTY;
        this.ProjectID = GUID_EMPTY;
        this.TaskGroupName = null;
        this.CreatedDate = null;
        this.CreatedBy = null;
    }
}

export default AddTaskGroupParam
