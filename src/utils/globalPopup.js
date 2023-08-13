export default {
  getInitialConfig: (config) => {
    const initConfig = {
      teleportTo: "body",
      modelValue: false,
      displayDirective: "if",
      hideOverlay: false,
      overlayTransition: "vfm-fade",
      contentTransition: "vfm-fade",
      clickToClose: true,
      escToClose: true,
      background: "non-interactive",
      lockScroll: true,
      swipeToClose: "none",
      contentClass: "dynamic-modal-content",
      customClass: ''
    };

    if(config){
        Object.keys(initConfig).forEach(key => {
            if(config[key] != null){
                initConfig[key] = config[key];
            }
        });
    }

    return initConfig;
    
  },
};
