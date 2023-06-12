
export default {
    SubSystemCode : {
        M_Dashboard : "M_Dashboard",
        M_Project : "M_Project",
        M_Project_Board : "M_Project_Board",
        M_Project_List: "M_Project_List",
        M_Project_Gantt : "M_Project_Gantt",
        M_Project_File : "M_Project_File",
    },

    ProjectTab: {
        Board : {
            name: 'Bảng',
            path: '/project/board',
            key: 1
        },
        List : {
            name: 'Danh sách',
            path: '/project/list',
            key: 2
        },
        Gantt : {
            name: 'Gantt',
            path: '/project/gantt',
            key: 3
        },
        Calendar : {
            name: 'Lịch',
            path: '/project/calendar',
            key: 4
        },
        File : {
            name: 'Tài liệu & Liên kết',
            path: '/project/file',
            key: 5
        },
    },

    Services: {
        Auth : "Authenticate"
    }
}

export const CONFIG_STORE = 'ConfigStore';
