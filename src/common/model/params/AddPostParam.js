import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddPostParam {
    constructor() {
        this.ProjectID = GUID_EMPTY;
        this.AuthorID = GUID_EMPTY;
        this.PostCategoryID = null;
        this.Title = null;
        this.Content = null;
        this.Tags = [];
    }
}

export default AddPostParam
