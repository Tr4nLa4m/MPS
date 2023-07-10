import AddProjectParam from "@/common/model/params/AddProjectParam";
import GetTaskPagingByProjectParam from "@/common/model/params/GetTaskPagingByProjectParam";
import TaskCommentParam from "@/common/model/params/TaskCommentParam";
import UpdateTaskFieldParam from "@/common/model/params/UpdateTaskFieldParam";

export default {
  createChecklist(data = {}) {
    return {
      ProjectID: data.ProjectID ? data.ProjectID : null,
      ChecklistName: data.ChecklistName ? data.ChecklistName : null,
      Index: data.Index ? data.Index : null,
      CreatedDate: data.CreatedDate ? data.CreatedDate : null,
      CreatedBy: data.CreatedBy ? data.CreatedBy : null,
    };
  },

  createSubTask(data = {}) {
    return {
      TaskName: data.TaskName ? data.TaskName : null,
      Performer: data.Performer ? data.Performer : null,
      StartDate: data.StartDate ? data.StartDate : null,
      EndDate: data.EndDate ? data.EndDate : null,
      Range: data.Range ? data.Range : null,
      Description: data.Description ? data.Description : null,
      ProjectID: data.ProjectID ? data.ProjectID : null,
      CreatedBy: data.CreatedBy ? data.CreatedBy : null,
      CreatedDate: data.CreatedDate ? data.CreatedDate : null,
    };
  },

  createGetPagingTaskByEmployeeParam(data = {}) {
    return new GetTaskPagingByProjectParam();
  },

  createAddProjectParam(data = {}) {
    return new AddProjectParam();
  },

  createTaskCommentParam(data = {}) {
    return new TaskCommentParam();
  },

  createUpdateTaskFieldParam(data = {}) {
    return new UpdateTaskFieldParam(
      data.TaskID,
      data.FieldName,
      data.FieldValue,
      data.OldValue,
      data.TypeValue,
      data.CreatedBy,
      data.ActionType,
      data.OldTextValue,
      data.NewTextValue,
      data.ComponentID,
    );
  },
};
