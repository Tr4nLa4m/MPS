import { createApp } from 'vue'
import App from './App.vue';
import router from './router/router';
import store from './store/store';
import naive from "naive-ui";
import MConstant from "@/common/consts/MConstant";
import commonFn from "@/utils/helper/commonFn.js";
import { configStore } from '@/store/configStore';


// Import CSS
import "./assets/style/main.css";
import "./assets/style/variable.css";
import "./assets/style/base.css";
import { CONFIG_STORE } from './common/consts/MConstant';
// import "@/assets/style/customize.css";


const myApp = createApp(App);

myApp.provide('MConstant', MConstant);
myApp.provide('CommonFn', commonFn);

myApp.provide(CONFIG_STORE, configStore);



myApp.use(router);
myApp.use(store);
myApp.use(naive);
myApp.mount("#app");

