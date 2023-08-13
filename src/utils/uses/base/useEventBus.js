// useEventBus.js
import { ref, onMounted, onUnmounted } from 'vue';
import eventBus from '@/utils/helper/eventBus';

export default function useEventBus(event, handler) {
  const isEventTriggered = ref(false);

  function handleEvent(...args) {
    isEventTriggered.value = true;
    handler(...args);
  }

  onMounted(() => {
    if(event && typeof(handler) == 'function'){
        eventBus.$on(event, handleEvent);
    }
    
  });

  onUnmounted(() => {
    if(event && typeof(handler) == 'function'){
        eventBus.$off(event, handleEvent);
    }
  });


  return {
    isEventTriggered
  };
}
