import MConstant, {
  DEPARTMENT_KEY_PREFIX,
  GUID_EMPTY,
  PERMISSION_KEY_PREFIX,
} from "@/common/consts/MConstant";
import { keyStore } from "@/store/store";
import { cloneDeep } from "lodash";
import { useMessage } from "naive-ui";

export default {
  getObjectValueByProps(object, propname, value, findProp) {
    try {
      let keys = Object.keys(object);
      let findKey = keys.find((key) => object[key][propname] == value);
      if (!findKey) {
        console.warn("Error when find object value");
      }
      return object[findKey][findProp];
    } catch (error) {
      console.warn("Error when find object value");
    }
  },

  addCollapsedPropertyForTree(data) {
    data.forEach((item) => {
      if (item.children) {
        item.collapsed = true;
        this.addCollapsedPropertyForTree(item.children);
      }
    });

    return data;
  },

  calculateTimePeriod(timestamp) {
    const millisecondsPerMinute = 60 * 1000; // Number of milliseconds in a minute
    const millisecondsPerHour = 60 * millisecondsPerMinute; // Number of milliseconds in an hour
    const millisecondsPerDay = 24 * millisecondsPerHour; // Number of milliseconds in a day

    const timeDifference = timestamp;

    const days = Math.floor(timeDifference / millisecondsPerDay);
    const hours = Math.floor(
      (timeDifference % millisecondsPerDay) / millisecondsPerHour
    );
    const minutes = Math.floor(
      (timeDifference % millisecondsPerHour) / millisecondsPerMinute
    );

    const result = [];
    if (days > 0) {
      result.push(`${days} ngày`);
    }
    if (hours > 0) {
      result.push(`${hours} giờ`);
    }
    if (minutes > 0) {
      result.push(`${minutes} phút`);
    }

    return result.join(" ");
  },

  formatDate(date, onlyDate = false) {
    if (typeof date != "Date") {
      date = new Date(date);
    }

    var day = date.getDate();
    var month = date.getMonth() + 1; // Months are zero-based
    var year = date.getFullYear();
    var hours = date.getHours();
    var minutes = date.getMinutes();

    // Add leading zeros if necessary
    if (day < 10) {
      day = "0" + day;
    }
    if (month < 10) {
      month = "0" + month;
    }

    if (onlyDate) {
      return day + "/" + month + "/" + year;
    }
    if (hours < 10) {
      hours = "0" + hours;
    }
    if (minutes < 10) {
      minutes = "0" + minutes;
    }

    return day + "/" + month + "/" + year + "  " + hours + ":" + minutes;
  },

  deleteElementsInArray(arrSource, arrDelete, props) {
    let arrDelMap = arrDelete.map((x) => x[props]);
    return arrSource.filter((element) => !arrDelMap.includes(element[props]));
  },

  addElementsInArrayIfNotExist(arrSource, arrAdd, props) {
    arrAdd.forEach((item) => {
      let exitsItem = arrSource.find((x) => x[props] == item[props]);
      if (!exitsItem) {
        arrSource.push(item);
      }
    });
    return arrSource;
  },

  getDepartmentProject(projects) {
    const outputArray = [];
    projects.forEach((obj) => {
      const { DepartmentID, DepartmentName, ...project } = obj;
      const existingObj = outputArray.find(
        (item) => item.DepartmentID === DepartmentID
      );

      if (existingObj) {
        existingObj.Projects.push(project);
      } else {
        let projects = [];
        if (project.ProjectID != null && project.ProjectID != GUID_EMPTY) {
          projects.push(project);
        }
        outputArray.push({
          DepartmentID,
          DepartmentName,
          ProjectID: DEPARTMENT_KEY_PREFIX + DepartmentID,
          ProjectName: DepartmentName,
          disabled: true,
          Projects: projects,
        });
      }
    });

    return outputArray;
  },

  getRoleProject(permissions) {
    const outputArray = [];
    permissions.forEach((obj) => {
      const { Component, ...permission } = obj;
      debugger;
      const existingObj = outputArray.find(
        (item) => item.Component === Component
      );

      if (existingObj) {
        existingObj.Permissions.push(obj);
      } else {
        let Permissions = [];
        if (
          permission.PermissionID != null &&
          permission.PermissionID != GUID_EMPTY
        ) {
          Permissions.push(obj);
        }
        outputArray.push({
          PermissionID: PERMISSION_KEY_PREFIX + Component,
          PermissionName: MConstant.PermissionGroups[Component] || "",
          Component,
          Permissions,
        });
      }
    });

    return outputArray;
  },

  mask() {
    const loadingEl = document.getElementById("mloader");
    if (loadingEl) {
      loadingEl.style.display = "flex";
    }
  },

  unmask() {
    const loadingEl = document.getElementById("mloader");
    if (loadingEl) {
      loadingEl.style.display = "none";
    }
  },

  initDropdownOptions(renderFn) {
    return [
      {
        key: "header",
        type: "render",
        render: renderFn,
      },
    ];
  },

  createInfo(content) {
    let message = useMessage();
    message.info(content, {
      closable: true,
      duration: 5000,
    });
  },

  calculateTimeAgo(date) {
    if (typeof date != "Date") {
      date = new Date(date);
    }
    const timeSince = new Date() - date;

    if (timeSince < 60000) {
      return "Vừa xong";
    } else if (timeSince < 3600000) {
      const minutes = Math.floor(timeSince / 60000);
      return `${minutes} phút trước`;
    } else if (timeSince < 86400000) {
      const hours = Math.floor(timeSince / 3600000);
      return `${hours} giờ trước`;
    } else if (timeSince < 2592000000) {
      const days = Math.floor(timeSince / 86400000);
      return `${days} ngày trước`;
    } else if (timeSince < 31536000000) {
      const months = Math.floor(timeSince / 2592000000);
      return `${months} tháng trước`;
    } else {
      const years = Math.floor(timeSince / 31536000000);
      return `${years} năm trước`;
    }
  },

  getShowActivityDetailBtn(activity) {
    let res = false;
    switch (activity.Column) {
      case "Task":
        res = false;
        break;

      case "TaskComment":
        res = true;
        break;

      case "Progress":
        res = true;
        break;

      default:
        break;
    }

    return res;
  },

  removeItemLocalStorage(key) {
    localStorage.removeItem(key);
  },

  getItemLocalStorage(prop) {
    let item = localStorage.getItem(keyStore);
    if (!item) {
      return null;
    }
    let context = JSON.parse(item);
    return context.context[prop];
  },

  getRawTextFromHTML(htmlString) {
    var tempDiv = document.createElement("div");
    tempDiv.innerHTML = htmlString;
    return tempDiv.textContent || tempDiv.innerText || "";
  },

  truncateString(inputString, length) {
    if (inputString.length > length) {
      return inputString.substring(0, length);
    } else {
      return inputString;
    }
  },

  getFilterDateOptions() {
    let filterDateObj = MConstant.FilterDate;
  },

  getTimestamp(date) {
    if (!date) {
      return null;
    }
    if (typeof date != "Date") {
      date = new Date(date);
    }

    return date.getTime();
  },

  hasPermissionInProject(userPermissions, projectID, permission) {
    let permissions = cloneDeep(userPermissions);
    let projectPermissions = userPermissions.filter(
      (permission) => permission.ProjectID == projectID
    );
    let projectPermissionCodes = projectPermissions.map(
      (x) => x.PermissionCode
    );

    return projectPermissionCodes.includes(permission);
  },

  getFieldValueByType(fieldValue) {
    let value;
    switch (typeof fieldValue) {
      case "number":
        value = "" + fieldValue;
        break;
      case "object":
        if(fieldValue instanceof Date){
          value = fieldValue.toISOString();
        }
        break;
      default:
        value = fieldValue;
        break;
    }

    return value;
  },

  getFieldValueText(fieldValue) {
    let value;
    switch (typeof fieldValue) {
      case "number":
        value = "" + fieldValue;
        break;
      case "object":
        if(fieldValue instanceof Date){
          value = fieldValue.toISOString();
        }
        break;
      default:
        value = fieldValue;
        break;
    }

    return value;
  },

  getTaskActivityValueText(activity, isOldText){
    let arr = [MConstant.TaskFields.Checklists, MConstant.TaskFields.Subtasks, MConstant.TaskFields.Performer, MConstant.TaskFields.TaskGroup];
    let field;
    debugger
    if(arr.includes(activity.Column)){
      field = isOldText ? 'OldTextValue' : 'NewTextValue';
    }
    else{
      field = isOldText ? 'OldValue' : 'NewValue';
    }

    if(!activity[field]){
      return '';
    }
    return '<b>' + activity[field] + '</b>'
  },

  checkIsImageLink(type){
    let listImage = ['image', 'png', 'jpeg', 'jpg', 'gif'];
    let res = false;
    listImage.forEach((imageType) => {
      if(type.includes(imageType)){
        res = true;
        return;
      }
    })
    return res;
  },

  getIconFileType(type){
    return 'mi-file-icon';
  },

  convertToMB(byte){
    var megabytes  = byte / 1024;
    return megabytes.toFixed(1) + 'KB';
  }
};
