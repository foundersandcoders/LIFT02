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
	dev: DevState;
}

export interface Detail {
	table: null | TableName;
	item: DetailItem;
}
export interface DetailItem {
	id: null | RowId;
}

export interface ItemCategory {
	raw: null | RowName;
	format: null | RowName;
}

export interface List {
	table: null | TableName;
	category: ItemCategory;
}

export interface DevState {
	testProfileId: string | null;
	testProfileName: string | null;
}

export interface Profile {
	id: null | RowId;
	name: null | string;
}

export interface QuestionDetails {
	responseInput: string | null;
	actionsInput: string | null;
	actionType: string;
	responseId: RowId | null;
}

export type RowId = string;

export type RowName = string;

export type TableName = 'actions' | 'profiles' | 'questions' | 'responses' | 'sharing_events';

export interface View {
	name: ViewName;
}

export type ViewName = 'dash' | 'list' | 'detail' | 'email';
