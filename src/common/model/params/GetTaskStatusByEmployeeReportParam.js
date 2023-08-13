import { GUID_EMPTY } from "@/common/consts/MConstant";

class GetTaskStatusByEmployeeReportParam {
    constructor() {
        this.ProjectID = GUID_EMPTY;
        this.StartDate = null;
        this.EndDate = null;
    }
}   

export default GetTaskStatusByEmployeeReportParam