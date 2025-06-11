export interface App {
  view: View;
  list: List;
  detail: Detail;
}

export interface View {
  name: ViewName;
}

export type ViewName = "dash" | "list" | "detail";

export interface List {
  table: Table;
  category: ListCategory;
}

export interface ListCategory {
  raw: null | string;
  format: null | string;
}

export interface Detail {
  table: Table;
  item: DetailItem;
}

export interface DetailItem {
  rowId: null | string;
}

export interface ActionCheck {
  isError: boolean;
  exist: boolean;
  count: number;
}

export type Table = null | "actions" | "profiles" | "questions" | "responses" | "sharing_events";