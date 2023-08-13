import { createApp } from "vue";
import App from "./App.vue";
import router from "./router/router";
import store from "./store/store";
import naive from "naive-ui";
import MConstant from "@/common/consts/MConstant";
import commonFn from "@/utils/helper/commonFn.js";
import models from "@/utils/helper/models";
import { createVfm } from 'vue-final-modal'
// Import CSS
import "./assets/style/main.css";
import "./assets/style/variable.css";
import "./assets/style/base.css";
import './style/index.css';
import 'vue-final-modal/style.css';
import 'devextreme/dist/css/dx.light.css';
import VueClickAway from "vue3-click-away";
// import "@/assets/style/customize.css";


const myApp = createApp(App);

// Globally Registered Components
import { useComponents } from '@/utils/globalComponents.js';
useComponents(myApp);

myApp.provide("MConstant", MConstant);
myApp.provide("CommonFn", commonFn);
myApp.provide("Model", models);


const vfm = createVfm()

myApp.use(router);
myApp.use(VueClickAway) 
myApp.use(vfm);

myApp.use(store);
myApp.use(naive);
myApp.mount("#app");
