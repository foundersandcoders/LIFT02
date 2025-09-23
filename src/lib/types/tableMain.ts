import type { Employer, Pronouns, User } from './tableSub';

export type Input = Action | Profile | Question | Response | Share | Resource;

export interface Action {
	id?: string;
	user_id: string;
	response_id?: string;
	question_id?: string;
	type: string;
	description?: string;
	status: 'active' | 'archived';
	created_at?: string;
	updated_at?: string;
	shares?: Share[];
	question_preview?: string;
}

export interface Profile {
	id?: string;
	name: string;
	user: User;
	pronouns?: Pronouns;
	jobTitle?: string;
	employer: Employer;
}

export interface Question {
	id?: string;
	category: string;
	question_text: string;
	order: number;
	preview: string | null;
}

export interface Response {
	id?: string;
	user_id: string;
	question_id: string;
	response_text: string;
	status?: 'answered' | 'skipped';
	visibility: 'public' | 'private';
	created_at?: string;
	updated_at?: string;
	shares?: Share[];
}

export interface Share {
	id?: string;
	user_id: string;
	recipient_email?: string;
	/* note: Recipient Email
    This makes sense for now, as the manager email is just a prop on the Profile
    However, there's a line manager id prop earmarked for later use

    If a table is implemented for Line Managers, this prop should be replaced by a foreign key to it
	*/
	message?: string;
	responses?: Response[];
	actions?: Action[];
	shared_at?: string;
}

export interface Resource {
	id?: string;
	title: string;
	description?: string;
	url?: string;
}
