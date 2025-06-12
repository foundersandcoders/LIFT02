export interface App {
  profile: Profile;
  view: View;
  list: List;
  detail: Detail;
}

export interface Profile {
  id: RowId
}
export interface View {
  name: ViewName
}
export interface List {
  table: TableName;
  category: ListCategory;
}
export interface Detail {
  table: TableName;
  item: DetailItem;
}

export interface ListCategory {
  raw: RowName;
  format: RowName;
}
export interface DetailItem {
  rowId: RowId
}

export type RowId = null | string;
export type RowName = null | string;
export type TableName = null | "actions" | "profiles" | "questions" | "responses" | "sharing_events";
export type ViewName = "dash" | "list" | "detail";

export interface ActionCheck {
  isError: boolean;
  exist: boolean;
  count: number;
}