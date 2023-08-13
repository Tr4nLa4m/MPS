import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddResolveIssueParam {
    constructor() {
        this.IssueID = GUID_EMPTY;
        this.SolutionID = GUID_EMPTY;
        this.Comment = null;
        this.FixVersionID = GUID_EMPTY;
    }
}

export default AddResolveIssueParam
