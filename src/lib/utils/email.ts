export interface EmailData {
	subject: string;
	introduction: string;
	categories: EmailCategory[];
	closing: string;
	signature: string;
	customNotes?: string | null;
	manager?: {
		name?: string;
		email?: string;
	};
	metadata: EmailMetadata;
}

export interface EmailCategory {
	categoryName: string;
	items: EmailItem[];
}

export interface EmailItem {
	questionText: string;
	responseText: string;
	actions?: EmailAction[];
}

export interface EmailAction {
	description: string;
	type: string;
	status: string;
}

export interface EmailMetadata {
	userId: string;
	userName: string | null;
	generatedAt: string;
	totalResponses: number;
	totalCategories: number;
}
