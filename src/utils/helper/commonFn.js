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
        outputArray.push({
          DepartmentID,
          DepartmentName,
          Projects: [project],
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
};
