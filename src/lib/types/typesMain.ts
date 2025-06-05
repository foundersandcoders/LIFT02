import type {
  User,
  Employer,
  Pronouns
} from "./typesSub";

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
  name: string
}

export interface Response {
  name: string
}

export interface Action {
  name: string
}

export interface Share {
  name: string
}