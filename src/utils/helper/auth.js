import commonFn from "./commonFn";

export default {

    isAuthenticated : () => {
        let token = commonFn.getItemLocalStorage('token');
        let tokenExpired = commonFn.getItemLocalStorage('tokenExpired');
        if(!token){
            return false;
        }

        if(new Date(tokenExpired) < new Date()){
            return false;
        }

        return true;

    }
}