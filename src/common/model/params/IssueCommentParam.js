import { GUID_EMPTY } from "@/common/consts/MConstant";

class IssueCommentParam {
    constructor() {
        this.CommentID = GUID_EMPTY;
        this.IssueID = GUID_EMPTY;
        this.Content = null;
        this.CreatedDate = null;
        this.CreatedBy = null;
        this.ModifiedDate = null;
    }
}

export default IssueCommentParam
