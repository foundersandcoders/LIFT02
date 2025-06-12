export interface ActionCheck {
	isError: boolean;
	exist: boolean;
	count: number;
}

export type ListCategory = {
	raw: string;
	format: string;
};

export type View = 'dash' | 'list' | 'detail';
