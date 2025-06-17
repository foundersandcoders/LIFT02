import { getUserResponses } from '$lib/services/database/responses';
// import { getUserActions } from '$lib/services/database/actions';
import { getQuestionById } from '$lib/services/database/questions';
import type { EmailData, EmailCategory, EmailItem } from '$lib/utils/email';

export async function generateEmailData(
	userId: string,
	userName?: string | null
): Promise<EmailData> {
	// Get all public, latest responses for user
	const responsesResult = await getUserResponses(userId, {
		visibility: 'public',
		isLatest: true
	});

	if (responsesResult.error || !responsesResult.data) {
		throw new Error('Error loading responses');
	}

	const responses = responsesResult.data;

	// Group responses by category
	const categoryGroups: { [category: string]: EmailItem[] } = {};

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

		categoryGroups[category].push({
			questionText: question.question_text,
			responseText: response.response_text || ''
			// TODO: Add actions later
		});
	}

	// Convert to EmailCategory array
	const categories: EmailCategory[] = Object.entries(categoryGroups).map(([categoryName, items]) => ({
		categoryName,
		items
	}));

	// Build EmailData object
	const emailData: EmailData = {
		subject: 'My Workplace Passport',
		introduction: 'Dear Line Manager,\n\nHere are my workplace needs and accommodations:',
		categories,
		closing: 'Best regards,',
		signature: userName || '[Your name]',
		metadata: {
			userId,
			userName: userName ?? null,
			generatedAt: new Date().toISOString(),
			totalResponses: responses.length,
			totalCategories: categories.length
		}
	};

	console.log('📧 Generated Email JSON:', JSON.stringify(emailData, null, 2));
	return emailData;
}

export function renderEmailToText(emailData: EmailData): string {
	let emailContent = `Subject: ${emailData.subject}\n\n${emailData.introduction}\n\n`;

	// Add categories
	for (const category of emailData.categories) {
		emailContent += `${category.categoryName.toUpperCase()}\n`;
		emailContent += '='.repeat(category.categoryName.length) + '\n\n';

		for (const item of category.items) {
			emailContent += `Q: ${item.questionText}\n`;
			emailContent += `A: ${item.responseText}\n\n`;
		}

		emailContent += '\n';
	}

	emailContent += `\n${emailData.closing}\n${emailData.signature}`;
	return emailContent;
}
