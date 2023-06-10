import { createApp } from 'vue'
import App from './App.vue';
import router from './router/router';
import store from './store/store';
import naive from "naive-ui";
import MConstant from "@/common/consts/MConstant";
import commonFn from "@/utils/helper/commonFn.js";


// Import CSS
import "./style/main.css";
import "./style/variable.css";
import "./style/base.css";
// import "@/style/customize.css";


const myApp = createApp(App);

myApp.provide('MConstant', MConstant);
myApp.provide('CommonFn', commonFn);



myApp.use(router);
myApp.use(store);
myApp.use(naive);
myApp.mount("#app");

