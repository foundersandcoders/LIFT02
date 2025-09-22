export interface HelpScreenshot {
	src: string;
	alt: string;
	caption?: string;
}

export interface HelpSection {
	heading?: string;
	text: string;
	screenshot?: HelpScreenshot;
	callouts?: string[];
}

export interface HelpContent {
	title: string;
	sections: HelpSection[];
}

export type HelpContextKey = 
	| 'dashboard-no-profile'
	| 'dashboard-profile'
	| 'actions'
	| 'resources'
	| 'categories'
	| 'responses'
	| 'email';

export type HelpContentMap = Record<HelpContextKey, HelpContent>;