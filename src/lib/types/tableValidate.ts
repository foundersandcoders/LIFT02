import { z } from 'zod';

export const User = z.object({
	userId: z.string().optional(),
	email: z.string().email()
});
