import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddIssueToPhaseParam {
    constructor() {
        this.PhaseID = GUID_EMPTY;
        this.Issues = [];
    }
}

export default AddIssueToPhaseParam
