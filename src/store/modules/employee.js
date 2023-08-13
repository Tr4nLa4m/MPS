import Employee from "@/services/Employee";

// initial state
// shape: [{ id, quantity }]
const state = {
  employees: {
  },
  /** 
  {
    UserID: "00000000-0000-0000-0000-000000000000"
    Avatar: "https://lh3.googleusercontent.com/a/AAcHTte7c6WXWPi4DFYDRRXFjOxHixHA--UZAsu5NFbE_g=s360-c-no"
    EmployeeID: "53da58f8-ef0d-11ed-ae2b-0242ac130002"
    Username: "B-1179,
    FullName,
    PositionName
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
  async getByDepartment({commit}, payload){
    let res = await Employee.getByDepartment(payload?.data?.DepartmentID);
    if (res?.Success) {
      if(payload?.onSuccess){
        payload.onSuccess();
      }

      commit('SET_EMPLOYEES', res.Data);
    }
    else{
      if(payload?.onFailure){
        payload.onFailure();
      }
    }
    return res.Data;
  },

  async filterEmployee({commit}, payload){
    let res = await Employee.filter(payload?.data?.KeySearch);
    if (res?.Success) {
      if(payload?.onSuccess){
        payload.onSuccess();
      }

    }
    else{
      if(payload?.onFailure){
        payload.onFailure();
      }
    }

    return res.Data;
  },

  async getEmployeeByID({commit}, payload){
    let res = await Employee.getById(payload?.data?.EmployeeID);
    if (res?.Success) {
      if(payload?.onSuccess){
        payload.onSuccess();
      }
    }
    else{
      if(payload?.onFailure){
        payload.onFailure();
      }
    }

    return res.Data;
  }
}

// mutations
const mutations = {
  SET_EMPLOYEES(state, data){
    state.employees = data;
  }

  
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}