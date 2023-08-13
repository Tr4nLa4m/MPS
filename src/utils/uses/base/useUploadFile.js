import { ref } from "vue";
import { useMessages } from "./useMessages";
import { useStore } from "vuex";
import { ModuleFile } from "@/store/moduleConstant";

export function useUploadFile(props = {}, methods = {}) {
  const fileList = ref([]);
  const initFileList = ref([]);
  const UPLOAD_DOMAIN = `${import.meta.env.VITE_DOMAIN_BE}/api/v1/File`;

  const callBackOnFinish = methods.onFinish || null;
  const callBackOnRemove = methods.onRemove || null;

  const { warning, error } = useMessages();
  const store = useStore();

  const beforeUploadFile = (file) => {
    // Check if file size exceeds the limit (in bytes)
    const maxSize = 4 * 1024 * 1024; // 10 MB
    if (file.size > maxSize) {
      warning("File size exceeds the limit");
      return false; // Prevent the file from being uploaded
    }

    // File size is within the limit
    return true; // Proceed with the file upload
  };

  const finishUploadFile = ({ file, event }) => {
    let response = JSON.parse(event.currentTarget?.response);
    let blobFile = response.Data?.Blob;
    file.url = blobFile.Uri;
    file.OriginalName = blobFile.Name;

    const newFile = {
        ID: file.id,
        FileName: file.name,
        Type: file.type,
        Size: file?.file.size,
        OriginalName: blobFile.Name,
        Url: blobFile.Uri,
      };

    if (callBackOnFinish) {
        if(response.Success){
            callBackOnFinish(newFile, response);
        }
    }
    fileList.value.push(newFile);
  };

  const errorUploadFile = ({ file, event }) => {
    error(`Có lỗi khi tải file ${file.name}`);
  };

  const removeFile = async ({ file, listFile }) => {
    
    let index = fileList.value.findIndex((item) => item.ID == file.id);
    let deleteFile;
    if (index < 0) {
      return;
    }
    deleteFile = fileList.value[index];
    fileList.value.splice(index, 1);

    if (callBackOnRemove) {
      callBackOnRemove(deleteFile);
    }

    try {
      let param = {
        data: {
          FileName: deleteFile.OriginalName,
        },
      };

      await store.dispatch(ModuleFile + "/removeFile", param);
    } catch (error) {}

    return true;
  };

  return {
    UPLOAD_DOMAIN,
    fileList,
    initFileList,
    beforeUploadFile,
    finishUploadFile,
    errorUploadFile,
    removeFile,
  };
}
