import { GUID_EMPTY } from "@/common/consts/MConstant";
import { BasePagingParam } from "./BasePagingParam";

class GetPhasePagingByProjectParam extends BasePagingParam{
    constructor() {
        super();
        this.ProjectID = null;
        this.EmployeeID = null;
        this.SortBy = null;
        this.AuthorID = GUID_EMPTY;
    }
}   

export default GetPhasePagingByProjectParam