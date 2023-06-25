import { createStore, createLogger } from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import SecureLS from 'secure-ls';
import user from './modules/user';
import project from './modules/project';
import config from './modules/config';

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
    config
  },
  strict: debug,
  plugins: debug ? [createLogger(), persistedstate] : [persistedstate]
})