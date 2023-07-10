import { createStore, createLogger } from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import SecureLS from 'secure-ls';
import user from './modules/user';
import project from './modules/project';
import config from './modules/config';
import task from './modules/task';
import department from './modules/department';
import employee from './modules/employee';

const ls = new SecureLS({isCompression : false});
const debug = true // dev

const persistedstate = createPersistedState({
  key: "TN-LAM",
  paths: ['user'],
  getItem: (key) => ls.get(key),
  setItem: (key, value) => ls.set(key, value),
  removeItem: (key) => ls.remove(key)
})

export default createStore({
  modules: {
    user,
    project,
    config,
    task,
    department,
    employee
  },
  strict: debug,
  plugins: debug ? [createLogger(), persistedstate] : [persistedstate]
})