import { GUID_EMPTY } from "@/common/consts/MConstant";
import { BasePagingParam } from "./BasePagingParam";

class GetIssuePagingByProjectParam extends BasePagingParam{
    constructor() {
        super();
        this.ProjectID = null;
        this.EmployeeID = null;
        this.IssueStatus = null; // All
        this.IssueTypeID = GUID_EMPTY;
        this.SortBy = null;
        this.CreatorID = GUID_EMPTY;
        this.WatcherID = GUID_EMPTY;
    }
}   

export default GetIssuePagingByProjectParam