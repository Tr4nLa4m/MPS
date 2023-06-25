/*=========================================================================================
  File Name: globalComponents.js
  Description: Here you can register components globally
==========================================================================================*/
import MButton from '@/components/button/MButton.vue';
import MButtonIcon from '@/components/button/MButtonIcon.vue';
import MSplitButton from '@/components/button/MSplitButton.vue';
import MInput from '@/components/input/MInput.vue';
import MIconInput from '@/components/input/MIconInput.vue';

import VModal from "@/views/popup/VModal.vue";


export function useComponents(app) {
  app.component(MButton.name, MButton);
  app.component(MButtonIcon.name, MButtonIcon);
  app.component(MSplitButton.name, MSplitButton);
  app.component(MInput.name, MInput);
  app.component(MIconInput.name, MIconInput);

  app.component('VModal', VModal);

}
