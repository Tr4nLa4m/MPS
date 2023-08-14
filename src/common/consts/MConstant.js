
import EventBus from "./EventBus";

export default {
    SubSystemCode : {
        M_Dashboard : "M_Dashboard",
        M_Project : "M_Project",
        M_Project_Board : "M_Project_Board",
        M_Project_Report : "M_Project_Report",
        M_Project_List: "M_Project_List",
        M_Project_Gantt : "M_Project_Gantt",
        M_Project_File : "M_Project_File",
        M_Project_Issue : "M_Project_Issue",
        M_Project_Phase : "M_Project_Phase",
    },

    ProjectTab: {
        Board : {
            name: 'Bảng',
            path: '/board',
            key: 1
        },
        List : {
            name: 'Danh sách',
            path: '/list',
            key: 2
        },
        Gantt : {
            name: 'Gantt',
            path: '/gantt',
            key: 3
        },
        Phase : {
            name: 'Giai đoạn',
            path: '/phase',
            key: 8
        },
        Calendar : {
            name: 'Báo cáo',
            path: '/report',
            key: 4
        },
        File : {
            name: 'Tài liệu',
            path: '/file',
            key: 5
        },
        Issue : {
            name: 'Vấn đề',
            path: '/issue',
            key: 6
        },
        Post : {
            name: 'Tri thức',
            path: '/post',
            key: 7
        },
    },

    Services: {
        Auth : "Authenticate",
        Employee: "Employee",
        User: "User",
        Task: "Task",
        Project: "Project",
        TaskGroup: "TaskGroup",
        Department: "Department",
        PermissionGroup: 'PermissionGroup',
        TaskComment: 'TaskComment',
        TaskActivity: 'TaskActivity',
        IssueType: 'IssueType',
        Issue: 'Issue',
        IssueComment: 'IssueComment',
        IssueActivity: 'IssueActivity',
        File: 'File',
        PostComment: 'PostComment',  
        Post: 'Post',
        Phase: 'Phase'
    },

    FormMode: {
        Add: 1,
        Edit: 2,
        Watch: 3
    },

    FilterDate: {
        SevenDayRecent: 1,
        ThirtyDayRecent: 2,
        ThisWeek: 3,
        LastWeek: 4,
        ThisMonth : 5,
        LastMonth: 6,
        ThisQuater: 7,
        LastQuater: 8,
        ThisYear: 9,
        LastYear: 10
    },

    PermissionGroups: {
        Project: 'Dự án',
        Task:'Công việc',
        Report: 'Báo cáo',
        Gantt: 'Gantt',
        Phase: 'Giai đoạn',
        Issue: 'Vấn đề',
        Post: 'Bài viết'
    },

    ProjectPermissions: {
        Project: {
            Project_Read_Info: 'Project_Read_Info',
            Project_Edit_Info: 'Project_Edit_Info',
            Project_Add_Employee: 'Project_Add_Employee',
            Project_Read_Task: 'Project_Read_Task',
            Project_Read_Post: 'Project_Read_Post',
            Project_Read_Issue: 'Project_Read_Issue',
            Project_Read_Phase: 'Project_Read_Phase',
            Project_Delete: 'Project_Delete'

        },
        Task: {
            Task_Add: 'Task_Add',
            Task_Edit: 'Task_Edit',
            Task_Delete: 'Task_Delete'
        },
        Issue: {
            Issue_Add: 'Issue_Add',
            Issue_Edit_All: 'Issue_Edit_All',
            Issue_Open_Close: 'Issue_Open_Close',
            Issue_Resolve: 'Issue_Resolve',
            Issue_Config: 'Issue_Config'
        },
        Post: {
            Post_Add: 'Post_Add',
            Post_Edit_All: 'Post_Edit_All',
            Post_Delete: 'Post_Delete',
            Post_Share: 'Post_Share',
            Post_Config: 'Post_Config'
        },

        Report: {
            Report_Read: 'Report_Read'
        },

        Phase: {
            Phase_Add: 'Phase_Add',
            Phase_Edit: 'Phase_Edit',
            Phase_Delete: 'Phase_Delete'
        }
    },

    TaskFields: {
        Progress: 'Progress',
        Checklists: 'Checklists',
        Description: 'Description',
        Performer: 'Performer',
        Subtasks: 'Subtasks',
        StartDate: 'StartDate',
        EndData: 'EndDate',
        TaskGroup: 'TaskGroup',
        

    },

    IssueField: {
        Issue: 'Issue',
        IssueName: 'IssueName',
        Checklists: 'Checklists',
        ReceptionDate: 'ReceptionDate',
        Assignee: 'Assignee',
        IssueComment: 'IssueComment',
        IssueFile: 'IssueFile',
        DesiredDate: 'DesiredDate',
        Priority: 'Priority',
        PreliminarySolution: 'PreliminarySolution'
    },

    IssueStatus: {
        All: 0,
        Pending: 1,
        InProgress: 2,
        Processed: 3,
        Resolved: 4,
        Imqualified: 5
    },

    TaskStatus: {
        NotDone: 2,
        Done: 3
    },

    FieldTaskType: {
        Add : 1,
        Update: 2,
        Delete: 3,
        Done: 4
    },

    FileType: {
        General: 0,
        Task: 1,
        Issue: 2
    },

    EventBus: EventBus
}

export const CONFIG_STORE = 'ConfigStore';
export const GUID_EMPTY = '00000000-0000-0000-0000-000000000000';
export const DEPARTMENT_KEY_PREFIX = "DEPARTMENT_";
export const PERMISSION_KEY_PREFIX = "PERMISSION_";
export const ISSUE_CONTACT_INFO_INIT = "Tên đơn vị: \nMã khách hàng: \nNgười liên hệ: \nUltraView/Teamviewer: ";
export const DEFAULT_PAGE_SIZE = 5;
