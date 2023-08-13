import { GUID_EMPTY, ISSUE_CONTACT_INFO_INIT } from "@/common/consts/MConstant";

class AddIssueParam {
    constructor() {
        this.ProjectID = GUID_EMPTY;
        this.Project = {
            ProjectID: GUID_EMPTY
        }
        this.IssueName = null;
        this.IssueTypeID = null;
        this.Description = null;
        this.CustomerInfo = {
            PhoneNumber: null,
            Email: null,
            ContactInfo: ISSUE_CONTACT_INFO_INIT
        };
        this.ReceptionDate = null;
        this.DesiredDate = null;
        this.CreatorID = null;
        this.AssigneeID = null;
        this.Assignee = {};
        this.IssueStatus = 1; // Pending
        this.CreatedDate = null;
        this.ModifiedDate = null;
        this.PreliminarySolution = null;
        this.RelateEmployees = [];
        this.ProjectVersionID = null;
        this.Priority = null;
    }
}

export default AddIssueParam
