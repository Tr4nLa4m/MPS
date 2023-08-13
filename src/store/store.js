import { createLogger, Store } from 'vuex';
import { createStore } from 'vuex-extensions'
import createPersistedState from 'vuex-persistedstate';
import SecureLS from 'secure-ls';
import user from './modules/user';
import project from './modules/project';
import config from './modules/config';
import task from './modules/task';
import department from './modules/department';
import employee from './modules/employee';
import issue from './modules/issue';
import context from './modules/context';
import file from './modules/file';
import post from './modules/post';
import phase from './modules/phase';

const ls = new SecureLS({isCompression : false});
const debug = true // dev

export const keyStore = 'vuex-mps';

const persistedstate = createPersistedState({
  key: keyStore,
  paths: ['context'],
  getItem: (key) => ls.get(key),
  setItem: (key, value) => ls.set(key, value),
  removeItem: (key) => ls.remove(key)
})

export default createStore(Store, {
  modules: {
    user,
    project,
    config,
    task,
    department,
    employee,
    issue,
    file,
    post,
    phase,
    context
  },
  strict: debug,
  plugins: debug ? [createLogger(), persistedstate] : [persistedstate]
})