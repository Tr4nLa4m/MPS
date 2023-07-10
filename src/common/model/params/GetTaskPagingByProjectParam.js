import { BasePagingParam } from "./BasePagingParam";

class GetTaskPagingByProjectParam extends BasePagingParam{
    constructor() {
        super();
        this.ProjectID = null;
        this.EmployeeID = null;
        this.QuickFilter = null;
        this.TaskStatus = null;
        this.SortTaskBy = null;
        this.TaskGroupID = '00000000-0000-0000-0000-000000000000';
    }
}   

export default GetTaskPagingByProjectParam