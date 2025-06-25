import type { Response, Action } from '$lib/types/tableMain';

/**
   * Get the latest version of each response for a 
  user+question combination
   */
export function filterLatestResponses(responses: Response[]): Response[] {
	const latestResponsesMap = new Map<string, Response>();
	for (const response of responses) {
		const key = `${response.user_id}-${response.question_id}`;
		const existing = latestResponsesMap.get(key);

		// Validate version data integrity
		if (response.version == null) {
			console.warn(`Response ${response.id} has null/undefined version, defaulting to 1`);
		}
		if (existing && existing.version == null) {
			console.warn(`Existing response ${existing.id} has null/undefined version, defaulting to 1`);
		}

		const responseVersion = response.version ?? 1;
		const existingVersion = existing?.version ?? 1;

		if (!existing || responseVersion > existingVersion) {
			latestResponsesMap.set(key, response);
		}
	}
	return Array.from(latestResponsesMap.values());
}

/**
   * Get the latest version of each action for a 
  user+response combination
   */
export function filterLatestActions(actions: Action[]): Action[] {
	const latestActionsMap = new Map<string, Action>();
	for (const action of actions) {
		const key = `${action.user_id}-${action.response_id}`;
		const existing = latestActionsMap.get(key);

		// Validate version data integrity
		if (action.version == null) {
			console.warn(`Action ${action.id} has null/undefined version, defaulting to 1`);
		}
		if (existing && existing.version == null) {
			console.warn(`Existing action ${existing.id} has null/undefined version, defaulting to 1`);
		}

		const actionVersion = action.version ?? 1;
		const existingVersion = existing?.version ?? 1;

		if (!existing || actionVersion > existingVersion) {
			latestActionsMap.set(key, action);
		}
	}
	return Array.from(latestActionsMap.values());
}
