import { getUserResponses } from '$lib/services/database/responses';
import { getUserActions } from '$lib/services/database/actions';
import { getQuestionById } from '$lib/services/database/questions';

export async function generateEmailPreview(userId: string): Promise<string> {
	// Get all public, latest responses for user
	const responsesResult = await getUserResponses(userId, {
		visibility: 'public',
		isLatest: true
	});

	if (responsesResult.error || !responsesResult.data) {
		return 'Error loading responses';
	}

	// TODO: Build email content from responses and related actions
	return 'Subject: My Workplace Passport\n\nLoading...';
}
