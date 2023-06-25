import auth from "@/services/Auth";
import { useRouter } from "vue-router";

// initial state
// shape: [{ id, quantity }]
const state = {
  employee: {
  },
  /** 
  {
    UserID: "00000000-0000-0000-0000-000000000000"
    Avatar: "https://lh3.googleusercontent.com/a/AAcHTte7c6WXWPi4DFYDRRXFjOxHixHA--UZAsu5NFbE_g=s360-c-no"
    EmployeeID: "53da58f8-ef0d-11ed-ae2b-0242ac130002"
    Username: "B-1179
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
    return res.Data;
  },

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
  }

  
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}