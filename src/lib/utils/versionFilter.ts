import type { Response } from '$lib/types/tableMain';

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

