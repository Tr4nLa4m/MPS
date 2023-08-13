import { GUID_EMPTY } from "@/common/consts/MConstant";
import { BasePagingParam } from "./BasePagingParam";

class GetPostPagingByProjectParam extends BasePagingParam{
    constructor() {
        super();
        this.ProjectID = null;
        this.EmployeeID = null;
        this.SortBy = null;
        this.AuthorID = GUID_EMPTY;
        this.PostCategoryID = GUID_EMPTY;
        this.WatcherID = GUID_EMPTY;
        this.KeySearch = null;
        this.PostTagID = GUID_EMPTY;
    }
}   

export default GetPostPagingByProjectParam