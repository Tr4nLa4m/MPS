
export default {
    SubSystemCode : {
        M_Dashboard : "M_Dashboard",
        M_Project : "M_Project",
        M_Project_Board : "M_Project_Board",
        M_Project_Calendar : "M_Project_Calendar",
        M_Project_List: "M_Project_List",
        M_Project_Gantt : "M_Project_Gantt",
        M_Project_File : "M_Project_File",
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
        Calendar : {
            name: 'Lịch',
            path: '/calendar',
            key: 4
        },
        File : {
            name: 'Tài liệu & Liên kết',
            path: '/file',
            key: 5
        },
    },

    Services: {
        Auth : "Authenticate",
        Employee: "Employee",
        User: "User",
        Task: "Task",
        Project: "Project",
    }
}

export const CONFIG_STORE = 'ConfigStore';
