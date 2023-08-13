import { GUID_EMPTY } from "@/common/consts/MConstant";

class PostCommentParam {
    constructor() {
        this.CommentID = GUID_EMPTY;
        this.PostID = GUID_EMPTY;
        this.Content = null;
        this.CreatedDate = null;
        this.CreatedBy = null;
        this.ModifiedDate = null;
    }
}

export default PostCommentParam
