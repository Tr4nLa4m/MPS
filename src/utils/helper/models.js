import { GUID_EMPTY } from "@/common/consts/MConstant";
import AddDepartmentParam from "@/common/model/params/AddDepartmentParam";
import AddEmployeeParam from "@/common/model/params/AddEmployeeParam";
import AddIssueParam from "@/common/model/params/AddIssueParam";
import AddIssueToPhaseParam from "@/common/model/params/AddIssueToPhaseParam";
import AddPhaseParam from "@/common/model/params/AddPhaseParam";
import AddPostCategoryParam from "@/common/model/params/AddPostCategoryParam";
import AddPostParam from "@/common/model/params/AddPostParam";
import AddProjectParam from "@/common/model/params/AddProjectParam";
import AddResolveIssueParam from "@/common/model/params/AddResolveParam";
import AddRoleProjectParam from "@/common/model/params/AddRoleProjectParam";
import AddTaskGroupParam from "@/common/model/params/AddTaskGroupParam";
import AddTaskToPhaseParam from "@/common/model/params/AddTasksToPhaseParam";
import GetFilePagingByProjectParam from "@/common/model/params/GetFilePagingByProjectParam";
import GetIssuePagingByProjectParam from "@/common/model/params/GetIssuePagingByProjectParam";
import GetPhasePagingByProjectParam from "@/common/model/params/GetPhasePagingByProject";
import GetPostPagingByProjectParam from "@/common/model/params/GetPostPagingByProjectParam";
import GetTaskPagingByProjectParam from "@/common/model/params/GetTaskPagingByProjectParam";
import GetTaskStatusByEmployeeReportParam from "@/common/model/params/GetTaskStatusByEmployeeReportParam";
import IssueCommentParam from "@/common/model/params/IssueCommentParam";
import PostCommentParam from "@/common/model/params/PostCommentParam";
import TaskCommentParam from "@/common/model/params/TaskCommentParam";
import TaskParam from "@/common/model/params/TaskParam";
import UpdateTaskFieldParam from "@/common/model/params/UpdateTaskFieldParam";

export default {
  createChecklist(data = {}) {
    return {
      ProjectID: data.ProjectID ? data.ProjectID : null,
      ChecklistName: data.ChecklistName ? data.ChecklistName : null,
      Index: data.Index ? data.Index : null,
      CreatedDate: data.CreatedDate ? data.CreatedDate : null,
      CreatedBy: data.CreatedBy ? data.CreatedBy : null,
      IsNew: true
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
      Project: data.Project ? data.Project : null,
      CreatedBy: data.CreatedBy ? data.CreatedBy : null,
      CreatedDate: data.CreatedDate ? data.CreatedDate : null,
      Subtasks: [],
      Checklists: [],
      Files: [],
      TaskGroupID: GUID_EMPTY,
      ParentID: data.ParentID ? data.ParentID: GUID_EMPTY,
      IsNew: true
    };
  },

  createTaskParam(){
    return new TaskParam();
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

  createAddIssueParam(){
    return new AddIssueParam();
  },

  createAddDepartmentParam(){
    return new AddDepartmentParam();
  },

  createAddPostParam(){
    return new AddPostParam();
  },

  createAddEmployeeParam(){
    return new AddEmployeeParam();
  },

  createGetPagingIssueByProjectParam(data = {}) {
    return new GetIssuePagingByProjectParam();
  },

  createIssueCommentParam(data = {}) {
    return new IssueCommentParam();
  },

  createResolveIssueParam(data = {}) {
    return new AddResolveIssueParam();
  },

  createGetPagingPostByProjectParam(data = {}) {
    return new GetPostPagingByProjectParam();
  },

  createPostCommentParam(data = {}) {
    return new PostCommentParam();
  },

  createTaskStatusByEmployeeReportParam() {
    return new GetTaskStatusByEmployeeReportParam();
  },

  createAddPhaseParam() {
    return new AddPhaseParam();
  },

  createPhasePagingByProjectParam() {
    return new GetPhasePagingByProjectParam();
  },

  createAddTaskToPhaseParam() {
    return new AddTaskToPhaseParam();
  },

  createAddIssueToPhaseParam() {
    return new AddIssueToPhaseParam();
  },

  createAddProjectRoleParam() {
    return new AddRoleProjectParam();
  },

  createGetPagingFileProjectParam(data = {}) {
    return new GetFilePagingByProjectParam();
  },

  createAddPostCategoryParam() {
    return new AddPostCategoryParam();
  },

  createAddTaskGroupParam() {
    return new AddTaskGroupParam();
  },
};
