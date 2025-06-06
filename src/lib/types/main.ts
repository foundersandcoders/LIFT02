import type { User, Employer, Pronouns } from "./sub";

export type Input = Profile | Question | Response | Action | Share;

export interface Profile {
  id?: string;
  name: string;
  user: User;
  pronouns?: Pronouns;
  jobTitle?: string;
  employer: Employer
}

export interface Question {
  id?: string,
  category: string,
  question_text: string,
  order: number
}

export interface Response {
  id?: string,
  user_id: string,
  question_id: string,
  response_text: string,
  status?: "answered" | "skipped",
  visibility: "public" | "private",
  version: number,
  is_latest: boolean,
  // TODO: Use Temporal() to handle dates
  created_at?: string,
  updated_at?: string,
}

export interface Action {
  id?: string,
  user_id: string,
  response_id?: string,
  type: string,
  description?: string,
  version: number,
  is_latest: boolean,
  status: "draft" | "active" | "archived",
  // TODO: Use Temporal() to handle dates
  created_at?: string,
  updated_at?: string
}

export interface Share {
  name: string
}