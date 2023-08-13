import MConstant from "@/common/consts/MConstant";
import { BasePagingParam } from "./BasePagingParam";

class GetFilePagingByProjectParam extends BasePagingParam{
    constructor() {
        super();
        this.ProjectID = null;
        this.EmployeeID = null;
        this.FileType = MConstant.FileType.General; 
        this.KeySearch = null;
    }
}   

export default GetFilePagingByProjectParam