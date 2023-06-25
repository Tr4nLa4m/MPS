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

  getDepartmentProject(projects){
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



  mask(){
    const loadingEl = document.getElementById('mloader');
    if(loadingEl){
      loadingEl.style.display = 'flex';
    }
  },

  unmask(){
    const loadingEl = document.getElementById('mloader');
    console.log(1);
    if(loadingEl){
      loadingEl.style.display = 'none';
    }
  },

  initDropdownOptions(renderFn){
    return [
      {
        key: "header",
        type: "render",
        render: renderFn,
      },
    ]
  }
};
