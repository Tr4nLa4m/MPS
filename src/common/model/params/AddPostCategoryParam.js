import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddPostCategoryParam {
    constructor() {
        this.PostCategoryID = GUID_EMPTY;
        this.ProjectID = GUID_EMPTY;
        this.CategoryName = null;
        this.CreatedDate = null;
        this.CreatedBy = null;
    }
}

export default AddPostCategoryParam
