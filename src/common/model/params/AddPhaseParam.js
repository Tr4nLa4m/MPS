import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddPhaseParam {
    constructor() {
        this.ProjectID = GUID_EMPTY;
        this.PhaseID = GUID_EMPTY;
        this.PhaseName = null;
        this.Description = null;
        this.StartDate = null;
        this.EndDate = null;
        this.Tasks = [];
        this.Issues = [];
        this.CreatorID = GUID_EMPTY;
    }
}

export default AddPhaseParam
