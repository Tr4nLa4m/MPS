import { useMessage } from "naive-ui";

export function useMessages() {
  const message = useMessage();

  const warning = (content) => {
    message.info(content, {
      closable: true,
      duration: 5000,
    });
  };

  const error = (content) => {
    message.error(content, {
      closable: true,
      duration: 5000,
    });
  };

  const success = (content) => {
    message.success(content, {
        closable: true,
        duration: 5000,
      })
  };

  return {
    warning,
    success,
    error
  }
}
