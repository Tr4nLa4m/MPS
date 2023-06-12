import { inject } from "vue";
import ConfigTab from "@/store/configs/configTab";
import { CONFIG_STORE } from "../common/consts/MConstant";

export const configStore = {
  ConfigTab,
};

export function useConfigStore() {
  const store = inject(CONFIG_STORE);
  if (!store) {
    throw new Error("No store provided");
  }
  return store;
}
