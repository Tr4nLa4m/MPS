import { GUID_EMPTY } from "@/common/consts/MConstant";

class TaskParam {
  constructor() {
    this.Project = {
      ProjectID: GUID_EMPTY,
    };
    this.TaskGroup = {
      TaskGroupID: GUID_EMPTY,
    };
    this.ProjectID = GUID_EMPTY;
    this.TaskName = null;
    this.Performer = {};
    this.StartDate = null;
    this.EndDate = null;
    this.Range = null;
    this.Description = null;
    this.Checklists = [];
    this.Subtasks = [];
    this.CreatorID = GUID_EMPTY;
    this.TaskGroupID = GUID_EMPTY;
    this.PerformerID = GUID_EMPTY;
    this.PerformerAvatar = null;
    this.Progress = 0;
  }
}

export default TaskParam;
