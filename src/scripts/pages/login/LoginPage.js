import { onMounted, ref } from "vue";
import { useInitPage } from "../../base/BasePage";
import { useRoutePath } from "@/utils/uses/router/useRoutePath";
import { useStore, mapActions } from "vuex";
export default {
  setup(props, context) {
    

    let username = ref("");
    let password = ref("");

    const store = useStore();
    const { login } = mapActions('user', ['login']);
    const { goToDashboard } = useRoutePath();



    const handlerEventProvider = {
      async btnLogin_click(event) {
        // validate
        let data = {
          Username: username.value,
          Password: password.value,
          
        };


        // if(window._bypassLogin){
        //   debugger
        //   goToDashboard();
        // }

        let res = await store.dispatch('user/login', data);
        goToDashboard();

        
      },  
    };

    // lifecycle hooks
    onMounted(() => {
      console.log(`The initial of Login Page`);
    });

    useInitPage(handlerEventProvider);

    return {
      username,
      password
    };
  },
};
