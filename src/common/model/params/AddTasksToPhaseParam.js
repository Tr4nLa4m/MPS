import { GUID_EMPTY } from "@/common/consts/MConstant";

class AddTaskToPhaseParam {
    constructor() {
        this.PhaseID = GUID_EMPTY;
        this.Tasks = [];
    }
}

export default AddTaskToPhaseParam
