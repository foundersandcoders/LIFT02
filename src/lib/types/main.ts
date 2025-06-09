import type { User, Employer, Pronouns } from './sub';

export type Input = Profile | Question | Response | Action | Share;

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
}

export interface Response {
	id?: string;
	user_id: string;
	question_id: string;
	response_text: string;
	status?: 'answered' | 'skipped';
	visibility: 'public' | 'private';
	version: number;
	is_latest: boolean;
	created_at?: string; // TODO: Temporal()
	updated_at?: string; // TODO: Temporal()
	shares?: Share[]; // sharing_event_responses
}

export interface Action {
	id?: string;
	user_id: string;
	response_id?: string;
	type: string;
	description?: string;
	version: number;
	is_latest: boolean;
	status: 'draft' | 'active' | 'archived';
	created_at?: string; // TODO: Temporal()
	updated_at?: string; // TODO: Temporal(),
	shares?: Share[]; // sharing_event_actions
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
	responses?: Response[]; // sharing_event_responses
	actions?: Action[]; // sharing_event_actions
	shared_at?: string; // TODO: Temporal()
}
