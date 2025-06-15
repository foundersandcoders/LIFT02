import { getUserResponses } from '$lib/services/database/responses';
// import { getUserActions } from '$lib/services/database/actions';
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

	const responses = responsesResult.data;
	let emailContent =
		'Subject: My Workplace Passport\n\nDear Line Manager,\n\nHere are my workplace needs and accommodations:\n\n';

	// Build tree structure for each response
	for (const response of responses) {
		// Get the question for this response
		if (!response.question_id) continue;

		const questionResult = await getQuestionById(response.question_id);
		if (questionResult.error || !questionResult.data) continue;

		const question = questionResult.data;

		// Add question and response to email
		emailContent += `**${question.category}**\n`;
		emailContent += `Q: ${question.question_text}\n`;
		emailContent += `A: ${response.response_text}\n`;

		// TODO: Get related actions for this response
		emailContent += '\n';
	}

	emailContent += '\nBest regards,\n[Your name]';
	return emailContent;
}
