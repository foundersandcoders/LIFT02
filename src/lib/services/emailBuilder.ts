import { getActionsByResponseIds } from '$lib/services/database/actions';
import { getQuestionById } from '$lib/services/database/questions';
import { getUserResponses } from '$lib/services/database/responses';
import type { Action } from '$lib/types/tableMain';
import type { EmailCategory, EmailData, EmailItem } from '$lib/utils/email';
import { makePretty } from '$lib/utils/textTools';
import DOMPurify from 'isomorphic-dompurify';

/**
 * Sanitize user input to prevent XSS attacks
 */
function sanitizeText(text: string): string {
	return DOMPurify.sanitize(text, { ALLOWED_TAGS: [] });
}

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

	// With the simplified system, all responses are already the latest version
	const responses = responsesResult.data;

	// Group responses by category
	const categoryGroups: { [category: string]: EmailItem[] } = {};

	// Batch fetch all actions for all responses
	const responseIds = responses.map((r) => r.id).filter(Boolean) as string[];
	const allActionsResult = await getActionsByResponseIds(responseIds);
	const allActions = allActionsResult.data || [];

	// Group actions by response_id for quick lookup
	const actionsByResponseId = new Map<string, Action[]>();
	for (const action of allActions) {
		if (!action.response_id) continue;
		const existingActions = actionsByResponseId.get(action.response_id);
		if (existingActions) {
			existingActions.push(action);
		} else {
			actionsByResponseId.set(action.response_id, [action]);
		}
	}

	// Process all questions and responses, grouped by category
	for (const response of responses) {
		if (!response.question_id) continue;

		const questionResult = await getQuestionById(response.question_id);
		if (questionResult.error || !questionResult.data) continue;

		const question = questionResult.data;
		const category = question.category;

		if (!categoryGroups[category]) {
			categoryGroups[category] = [];
		}

		// Get all active actions for this response from batched data
		const responseActions = response.id ? actionsByResponseId.get(response.id) || [] : [];
		const activeActions = responseActions.filter((action) => action.status === 'active');

		// Only include actions that have actual content
		const emailActions = activeActions
			.filter((action) => action.description?.trim())
			.map((action) => ({
				description: action.description!,
				type: action.type,
				status: action.status
			}));

		// Only include responses with actual content
		if (response.response_text && response.response_text.trim() !== '') {
			categoryGroups[category].push({
				questionText: question.question_text,
				responseText: response.response_text,
				actions: emailActions.length > 0 ? emailActions : undefined
			});
		}
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
		subject: '',
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

	return emailData;
}

export function renderEmailToHTML(emailData: EmailData): string {
	let emailHTML = `
		<div class="email-container max-w-4xl mx-auto bg-base-100">
			<!-- Email Header -->
			<div class="email-header mb-6 p-4">
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
						<span class="question-text font-semibold text-base-content text-base ml-2">${sanitizeText(item.questionText)}</span>
					</div>
					<div class="answer mt-2">
						<span class="answer-label font-medium text-secondary">A:</span>
						<span class="answer-text text-base-content/80 ml-2">${sanitizeText(item.responseText)}</span>
					</div>
					${
						item.actions && item.actions.length > 0
							? `
						<div class="actions mt-3 ml-4">
							<span class="actions-label font-medium text-primary text-sm">Actions:</span>
							<ol class="actions-list ml-2 mt-1 space-y-1 list-decimal list-inside">
								${item.actions
									.map(
										(action) => `
									<li class="action-item text-sm text-base-content/70">
										${sanitizeText(action.description)}
									</li>
								`
									)
									.join('')}
							</ol>
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
				<div class="closing">${sanitizeText(emailData.closing)}</div>
				<div class="signature font-medium text-base-content">${sanitizeText(emailData.signature)}</div>
			</div>
		</div>
	`;

	return emailHTML;
}
