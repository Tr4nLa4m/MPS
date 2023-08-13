import { GUID_EMPTY } from "@/common/consts/MConstant";

class TaskCommentParam {
    constructor() {
        this.CommentID = GUID_EMPTY;
        this.TaskID = GUID_EMPTY;
        this.Content = null;
        this.CreatedDate = null;
        this.CreatedBy = null;
        this.ModifiedDate = null;
    }
}

export default TaskCommentParam
