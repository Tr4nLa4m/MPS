import MConstant, { GUID_EMPTY } from "@/common/consts/MConstant";

class UpdateTaskFieldParam {
  constructor(
    TaskID = GUID_EMPTY,
    FieldName = "",
    FieldValue = "",
    OldValue = "",
    TypeValue = "",
    CreatedBy = "",
    ActionType = MConstant.FieldTaskType.Update,
    OldTextValue = '',
    NewTextValue = '',
    ComponentID = null
  ) {
    this.TaskID = TaskID;
    this.FieldName = FieldName;
    this.FieldValue = FieldValue;
    this.OldValue = OldValue;
    this.TypeValue = TypeValue;
    this.CreatedBy = CreatedBy;
    this.ActionType = ActionType;
    this.OldTextValue = OldTextValue;
    this.NewTextValue = NewTextValue;
    this.ComponentID = null
  }
}

export default UpdateTaskFieldParam;
