export default{
    getObjectValueByProps(object, propname, value, findProp){
        try {
            let keys = Object.keys(object);
            let findKey = keys.find((key) => object[key][propname] == value);
            if(!findKey){
                console.warn("Error when find object value");
            }
            return object[findKey][findProp];
        } catch (error) {
            console.warn("Error when find object value");
        }
    },

    addCollapsedPropertyForTree(data){
        data.forEach(item => {
            if (item.children) {
              item.collapsed = true;
              this.addCollapsedPropertyForTree(item.children);
            }
        });

        return data;
    }
}