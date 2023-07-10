export default {
    APIEndPoint: {
        LOGIN: 'login',
        AUTH: 'auth',
        LOGOUT: 'logout',
        PROJECT: {
            GET_PROJECT_BY_EMPLOYEE: "by-employee",
            GET_EMPLOYEES: "employees",
            INSERT_V2: "V2",

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
        },
        DEPARTMENT: {
            GET_BY_EMPLOYEE: "employee"
        },
        TASKCOMMENT: {
            GET_BY_TASK: "task",
            UPDATE: "comment",
            DELETE: "comment"
        },
        TASKACTIVITY: {
            GET_BY_TASK: "task"
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