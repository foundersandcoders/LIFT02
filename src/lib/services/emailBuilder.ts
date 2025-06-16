import { getUserResponses } from '$lib/services/database/responses';
// import { getUserActions } from '$lib/services/database/actions';
import { getQuestionById } from '$lib/services/database/questions';
import type { Database } from '$lib/services/database/types';

type Question = Database['public']['Tables']['questions']['Row'];
type Response = Database['public']['Tables']['responses']['Row'];

export async function generateEmailPreview(
	userId: string,
	userName?: string | null
): Promise<string> {
	// Get all public, latest responses for user
	const responsesResult = await getUserResponses(userId, {
		visibility: 'public',
		isLatest: true
	});

	if (responsesResult.error || !responsesResult.data) {
		return 'Error loading responses';
	}

	const responses = responsesResult.data;
	let emailContent =
		'Subject: My Workplace Passport\n\nDear Line Manager,\n\nHere are my workplace needs and accommodations:\n\n';

	// Group responses by category
	const categoryGroups: { [category: string]: Array<{ question: Question; response: Response }> } = {};

	// First, collect all questions and responses, grouped by category
	for (const response of responses) {
		if (!response.question_id) continue;

		const questionResult = await getQuestionById(response.question_id);
		if (questionResult.error || !questionResult.data) continue;

		const question = questionResult.data;
		const category = question.category;

		if (!categoryGroups[category]) {
			categoryGroups[category] = [];
		}

		categoryGroups[category].push({ question, response });
	}

	// Build email content grouped by category
	for (const [category, items] of Object.entries(categoryGroups)) {
		emailContent += `${category.toUpperCase()}\n`;
		emailContent += '='.repeat(category.length) + '\n\n';

		for (const { question, response } of items) {
			emailContent += `Q: ${question.question_text}\n`;
			emailContent += `A: ${response.response_text}\n`;

			// TODO: Get related actions for this response
			emailContent += '\n';
		}

		emailContent += '\n';
	}

	emailContent += `\nBest regards,\n${userName || '[Your name]'}`;
	return emailContent;
}
