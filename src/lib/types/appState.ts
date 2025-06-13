// export interface ActionCheck {
//   isError: boolean;
//   exist: boolean;
//   count: number;
// }

export interface AppState {
  profile: Profile;
  view: View;
  list: List;
  detail: Detail;
}

export interface Detail {
  table: null | TableName;
  item: DetailItem;
}
export interface DetailItem {
  id: null | RowId
}

export interface ItemCategory {
	raw: null | RowName;
	format: null | RowName;
}

export interface List {
  table: null | TableName;
  category: ItemCategory;
}

export interface Profile {
  id: null | RowId
}

export type RowId = string;

export type RowName = string;

export type TableName = "actions" | "profiles" | "questions" | "responses" | "sharing_events";

export interface View {
  name: ViewName
}

export type ViewName = "dash" | "list" | "detail";