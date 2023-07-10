import { ref } from "vue";
import { useMessages } from "./useMessages";



export function useUploadFile(props = {}, methods = {}){

    const fileList = ref([]);

    const callBackOnFinish = methods.onFinish || null;
    const callBackOnRemove = methods.onRemove || null;

    const { warning, error } = useMessages();

    const beforeUploadFile = (file) => {
        // Check if file size exceeds the limit (in bytes)
      const maxSize = 4 * 1024 * 1024; // 10 MB
      if (file.size > maxSize) {
        warning('File size exceeds the limit');
        return false; // Prevent the file from being uploaded
      }

      // File size is within the limit
      return true; // Proceed with the file upload
    }

    const finishUploadFile = ({file, event}) => {
        let response = JSON.parse(event.currentTarget?.response);
        let blobFile = response.Data?.Blob;
        file.url = blobFile.Uri;
        file.OriginalName = blobFile.Name;

        if(callBackOnFinish){
            callBackOnFinish(file, response);
        }
        fileList.value.push({
            ID: file.id,
            FileName: file.name,
            Type: file.type,
            Size: file?.file.size,
            OriginalName : blobFile.Name,
            Url: blobFile.Uri
        })
      }

    const errorUploadFile = ({file, event}) => {
        debugger
        error(`Có lỗi khi tải file ${file.name}`)
    }

    const removeFile = ({file, listFile}) => {
        if(callBackOnRemove) {
            callBackOnRemove(file);
        }
        debugger

        let index = fileList.value.findIndex((item) => item.ID == file.id);
        if(index >=0){
            fileList.value.splice(index, 1);
        }

        return true;
    }



    return {
        fileList,
        beforeUploadFile,
        finishUploadFile,
        errorUploadFile,
        removeFile
    }
}