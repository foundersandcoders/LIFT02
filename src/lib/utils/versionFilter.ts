import type { Action, Response } from '$lib/types/tableMain';

/**
   * Get the latest version of each response for a 
  user+question combination
   */
export function filterLatestResponses(responses: Response[]): Response[] {
	console.groupCollapsed('🔍 filterLatestResponses');
	console.log('📥 Input responses:', responses.length);

	const latestResponsesMap = new Map<string, Response>();
	for (const response of responses) {
		const key = `${response.user_id}-${response.question_id}`;
		const existing = latestResponsesMap.get(key);

		// Validate creation date data integrity
		if (!response.created_at) {
			console.warn(`Response ${response.id} has no created_at timestamp`);
		}
		if (existing && !existing.created_at) {
			console.warn(`Existing response ${existing.id} has no created_at timestamp`);
		}

		// Use creation date to determine latest response
		const responseDate = new Date(response.created_at || Date.now());
		const existingDate = new Date(existing?.created_at || Date.now());

		console.log(`🔄 Processing response ${response.id}:`, {
			key,
			responseDate: responseDate.toISOString(),
			existingDate: existing ? existingDate.toISOString() : 'none',
			isNewer: !existing || responseDate > existingDate,
			status: response.status
		});

		if (!existing || responseDate > existingDate) {
			latestResponsesMap.set(key, response);
			console.log(`✅ Set as latest for key: ${key}`);
		} else {
			console.log(`❌ Keeping existing for key: ${key}`);
		}
	}

	const result = Array.from(latestResponsesMap.values());
	console.log('📤 Filtered result:', result.length, 'responses');
	console.groupEnd();
	return result;
}

/**
   * Get the latest version of each action for a 
  user+response combination
   */
export function filterLatestActions(actions: Action[]): Action[] {
	const latestActionsMap = new Map<string, Action>();
	for (const action of actions) {
		const userId = action.user_id;
		const questionId = action.question_id || '';
		const key = userId + '-' + questionId;
		const existing = latestActionsMap.get(key);

		// Validate creation date data integrity
		if (!action.created_at) {
			console.warn(`Action ${action.id} has no created_at timestamp`);
		}
		if (existing && !existing.created_at) {
			console.warn(`Existing action ${existing.id} has no created_at timestamp`);
		}

		// Use creation date to determine latest action
		const actionDate = new Date(action.created_at || 0);
		const existingDate = new Date(existing?.created_at || 0);

		if (!existing || actionDate > existingDate) {
			latestActionsMap.set(key, action);
		}
	}
	return Array.from(latestActionsMap.values());
}
