export default {
    APIEndPoint: {
        LOGIN: 'login',
        AUTH: 'auth',
        LOGOUT: 'logout',
        PROJECT: {
            GET_PROJECT_BY_EMPLOYEE: "by-employee",
            GET_TASK_GROUPS: 'task-groups',
            GET_EMPLOYEES: "employees",
            INSERT_V2: "V2",
            GET_NUMBER_TASK_STATUS_REPORT: 'report/number-task-status',
            GET_NUMBER_TASK_GROUP_REPORT: 'report/number-task-group',
            GET_NUMBER_TASK_STATUS_BY_ASSIGNEE_REPORT: 'report/number-task-status-by-assignee',
            REMOVE_EMPLOYEE: 'remove/employee',
            INSERT_EMPLOYEES: 'employees',
            GET_FILE_PAGING: 'files-paging',
            UPLOAD_FILE: 'file',
            DELETE_FILES: 'delete-files'
        },
        EMPLOYEE: {
            FILTER: 'filter',
            GET_BY_DEPARTMENT: 'department',
        },
        TASK: {
            INSERT_V2:'v2',
            GET_PAGING_BY_PROJECT: "project",
            GET_INFO: "info",
            UPDATE_FIELD: "update-field",
            DELETE_CHECKLIST: 'checklist/delete',
            INSERT_CHECKLIST: 'checklist',
            INSERT_SUBTASKS: 'subtask',
            DELETE_V2: 'delete',
            GET_TASK_BY_TASKGROUPS: 'task-by-taskgroups',
            UPDATE_TASKGROUP_TASK: 'task-update-task-group',
            INSERT_TASK_GROUP: 'taskgroup',
            UPDATE_TASK_GROUP: 'taskgroup',
            DELETE_TASK_GROUP: 'taskgroup',
        },
        DEPARTMENT: {
            GET_BY_EMPLOYEE: "employee"
        },

        PERMISSIONGROUP: {
            GET_BY_PROJECT: "project",
            GET_BY_DEPARTMENT: "department",
            SET_EMPLOYEE_PROJECT_ROLE: "project/set-role",
            GET_PROJECT_PERMISSION: "project-permission",
            INSERT_PROJECT_ROLE: "project/role",
            GET_PROJECT_ROLE_PERMISSIONS: 'project/role-permission',
            CHECK_PROJECT_ROLE_INUSE: 'project/check-role-use',
            DELETE_PROJECT_ROLE: 'project/delete-role',
            UPDATE_PROJECT_ROLE: 'project/role',
            GET_EMPLOYEE_PROJECT_PERMISSIONS: 'project/employee'
        },

        TASKCOMMENT: {
            GET_BY_TASK: "task",
            UPDATE: "comment",
            DELETE: "comment"
        },
        TASKACTIVITY: {
            GET_BY_TASK: "task"
        },

        ISSUE: {
            INSERT_V2: 'v2',
            UPDATE_V2: 'v2',
            GET_PAGING_BY_PROJECT: 'project',
            GET_ISSUE: 'issue',
            WATCH: 'watch',
            FILE: 'file',
            RESOLVE: 'resolve',
            GET_SOLUTIONS: 'solution',
            REOPEN: 'reopen',
            CLOSE: 'close',
            ASSIGN: 'assign',
            RECERIVE: 'receive',
            DELETE_V2: 'v2',
            UPDATE_STATUS: 'status',
            GET_ACTIVITIES: 'activites'
        },

        ISSUECOMMENT: {
            GET_BY_ISSUE: "issue",
            UPDATE: "comment",
            DELETE: "comment"
        },

        ISSUETYPE: {
            GET_BY_PROJECT: 'project'
        },

        FILE: {
            REMOVE: "filename"
        },

        POST: {
            INSERT_V2: 'v2',
            UPDATE_V2: 'v2',
            GET_TAG: 'tag',
            GET_POST: 'post',
            GET_CATEGORY: 'category',
            GET_PAGING_BY_PROJECT: 'project',
            WATCH: 'watch',
            DELETE_V2: 'v2',
            SHARE: 'share',
            CATEGORY: 'post-category'
        },
        POSTCOMMENT: {
            GET_BY_POST: "post",
            UPDATE: "comment",
            DELETE: "comment"
        },
        
        PHASE: {
            INSERT_V2: 'v2',
            GET_BY_PROJECT: 'project',
            GET_TASK_TO_PHASE: 'get-task-to-phase',
            GET_ISSUE_TO_PHASE: 'get-issue-to-phase',
            GET_TASKS: 'task-phase',
            GET_ISSUES: 'issue-phase',
            INSERT_TASK_PHASE: 'task-to-phase',
            INSERT_ISSUE_PHASE: 'issue-to-phase',
            DELETE_V2: 'v2',
            UPDATE_INFO: 'v2',
            GET_PHASE_INFO: 'phase',
            DELETE_TASK_PHASE: 'delete-task-phase',
            DELETE_ISSUE_PHASE: 'delete-issue-phase'
        }
    },

    Authentication: {
        BYPASS_LOGIN : true,
    },

    Path : {
        LOGIN : "/login",
        DASHBOARD : "/dashboard",
        PROJECT: "/project",
    }
}