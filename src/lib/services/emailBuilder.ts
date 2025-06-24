import { getUserResponses } from '$lib/services/database/responses';
import { getLatestResponses } from '$lib/utils/versionFilter';
import { getActionsByResponseId } from '$lib/services/database/actions';
import { getLatestActions } from '$lib/utils/versionFilter';
import type { Action } from '$lib/types/tableMain';
import { getQuestionById } from '$lib/services/database/questions';
import { makePretty } from '$lib/utils/textTools';
import type { EmailData, EmailCategory, EmailItem } from '$lib/utils/email';

export async function generateEmailData(
	userId: string,
	userName?: string | null
): Promise<EmailData> {
	// Get all public responses for user
	const responsesResult = await getUserResponses(userId, {
		visibility: 'public'
	});

	if (responsesResult.error || !responsesResult.data) {
		throw new Error('Error loading responses');
	}

	// Get only the latest versions of responses
	const responses = getLatestResponses(responsesResult.data);

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

		// Get actions for this response
		const actionsResult = response.id ? await getActionsByResponseId(response.id) : { data: [], error: null };
		const actions = getLatestActions(actionsResult.data || []);

		// Convert actions to EmailAction format
		const emailActions = actions.map((action: Action) => ({
			description: action.description || '',
			type: action.type,
			status: action.status
		}));

		categoryGroups[category].push({
			questionText: question.question_text,
			responseText: response.response_text || '',
			actions: emailActions.length > 0 ? emailActions : undefined
		});
	}

	// Convert to EmailCategory array
	const categories: EmailCategory[] = Object.entries(categoryGroups).map(
		([categoryName, items]) => ({
			categoryName,
			items
		})
	);

	// Build EmailData object
	const emailData: EmailData = {
		subject: 'My Neacons',
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

export function renderEmailToHTML(emailData: EmailData): string {
	let emailHTML = `
		<div class="email-container max-w-4xl mx-auto bg-base-100">
			<!-- Email Header -->
			<div class="email-header mb-6 p-4">
				<h1 class="text-xl font-semibold text-primary mb-2">${emailData.subject}</h1>
				<div class="text-base-content/70 whitespace-pre-line">${emailData.introduction}</div>
			</div>

			<!-- Email Content -->
			<div class="email-content space-y-6">
	`;

	// Add categories
	for (const category of emailData.categories) {
		emailHTML += `
			<div class="category-section">
				<h2 class="category-title text-lg font-medium text-white bg-accent mb-4 py-3 px-4 uppercase tracking-wide">
					${makePretty(category.categoryName, 'db-category-name', 'email-category-title')}
				</h2>
				<div class="category-items space-y-4 px-4">
		`;

		for (const item of category.items) {
			emailHTML += `
				<div class="qa-item py-3 border-b border-base-300/50">
					<div class="question mb-3">
						<span class="question-label font-bold text-accent text-base">Q:</span>
						<span class="question-text font-semibold text-base-content text-base ml-2">${item.questionText}</span>
					</div>
					<div class="answer mt-2">
						<span class="answer-label font-medium text-secondary">A:</span>
						<span class="answer-text text-base-content/80 ml-2">${item.responseText}</span>
					</div>
					${
						item.actions && item.actions.length > 0
							? `
						<div class="actions mt-3 ml-4">
							<span class="actions-label font-medium text-primary text-sm">Actions:</span>
							<ul class="actions-list ml-2 mt-1 space-y-1">
								${item.actions
									.map(
										(action) => `
									<li class="action-item text-sm text-base-content/70">
										• ${action.description} <span class="action-status text-xs text-accent">(${action.status})</span>
									</li>
								`
									)
									.join('')}
							</ul>
						</div>
					`
							: ''
					}
				</div>
			`;
		}

		emailHTML += `
				</div>
			</div>
		`;
	}

	emailHTML += `
			</div>

			<!-- Email Footer -->
			<div class="email-footer mt-8 p-4 bg-base-200 rounded-lg text-base-content/70">
				<div class="closing">${emailData.closing}</div>
				<div class="signature font-medium text-base-content">${emailData.signature}</div>
			</div>
		</div>
	`;

	return emailHTML;
}
