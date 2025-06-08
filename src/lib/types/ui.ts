export interface ActionCheck {
  isError: boolean;
  exist: boolean;
  count: number;
}

export type View = "dash" | "list" | "detail";