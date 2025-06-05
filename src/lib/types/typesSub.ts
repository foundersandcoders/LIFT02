import { z } from "zod";
import * as check from "../utils/validators";

export type User = z.infer<typeof check.User>;

export interface Employer {
  name?: string,
  id?: string,
  manager: Manager
}

export interface Manager {
  id?: string,
  name?: string,
  pronouns?: Pronouns,
  email?: string,
};

export type Pronouns = [
  subject: string,
  object: string,
  possessive: string
];