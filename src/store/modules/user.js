import auth from "@/services/Auth";
import Employee from "@/services/Employee";
import { useRouter } from "vue-router";

// initial state
// shape: [{ id, quantity }]
const state = {
  user: {
  },
  /** 
  {
    UserID: "00000000-0000-0000-0000-000000000000"
    Avatar: "https://lh3.googleusercontent.com/a/AAcHTte7c6WXWPi4DFYDRRXFjOxHixHA--UZAsu5NFbE_g=s360-c-no"
    EmployeeID: "53da58f8-ef0d-11ed-ae2b-0242ac130002"
    Username: "B-1179
  }
  */

  employee: {

  },

  /**
   * {
    "EmployeeID": "53da58f8-ef0d-11ed-ae2b-0242ac130002",
    "EmployeeCode": "B-1179",
    "FullName": "Trần Ngọc Lâm",
    "StructureID": "17f09da8-fd33-11ed-a39f-0242ac130002",
    "PositionName": "Quản trị viên",
    "Email": "tnlam.software@gmail.com",
    "Level": null
  }
   */
  bypassLogin: false
}

// getters
const getters = {
  // cartProducts: (state, getters, rootState) => {
  //   return state.items.map(({ id, quantity }) => {
  //     const product = rootState.products.all.find(product => product.id === id)
  //     return {
  //       id: product.id,
  //       title: product.title,
  //       price: product.price,
  //       quantity
  //     }
  //   })
  // },

  // cartTotalPrice: (state, getters) => {
  //   return getters.cartProducts.reduce((total, product) => {
  //     return total + product.price * product.quantity
  //   }, 0)
  // }
}

// actions
const actions = {
  async login ({ commit, state }, payload) {
    const onSuccess = (response) => {
      const authHeader = response.headers.get("Authorization");

      let token = null;
      if (authHeader && authHeader.startsWith("Bearer ")) {
        // Extract the token by removing the 'Bearer ' prefix
        token = authHeader.substring(7); // 7 is the length of 'Bearer '
        auth.setAuthorizationToken(token);
      }

      
    }

    let res = await auth.login(payload, onSuccess);
    commit('SET_USER', res.Data);

    let res1 = await Employee.getById(res.Data?.EmployeeID);
    if(res1.Success){
      commit('SET_EMPLOYEE', res1.Data);
    }
    return {...res.Data, ...res1.Data};
  },

  async getEmployee ({ commit, state }, payload){
    let res = await Employee.getById(payload?.EmployeeID);
    commit('SET_EMPLOYEE', res.Data);
    return res.Data;
  }

  // addProductToCart ({ state, commit }, product) {
  //   commit('setCheckoutStatus', null)
  //   if (product.inventory > 0) {
  //     const cartItem = state.items.find(item => item.id === product.id)
  //     if (!cartItem) {
  //       commit('pushProductToCart', { id: product.id })
  //     } else {
  //       commit('incrementItemQuantity', cartItem)
  //     }
  //     // remove 1 item from stock
  //     commit('products/decrementProductInventory', { id: product.id }, { root: true })
  //   }
  // }
}

// mutations
const mutations = {
  SET_USER(state, user){
    state.user = user;
  },

  SET_EMPLOYEE(state, data){
    state.employee = data;
  }, 

  
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}