import { getLatestResponses } from '$lib/services/database/responses';
import type { QuestionConnections } from '$lib/types/appState';

export const getQuestionConnections = async (
	user_id: string,
	questionId: string
): Promise<QuestionConnections> => {
	console.groupCollapsed('📋 getQuestionDetails');
	console.log('📥 Input:', { user_id, questionId });

	const response = await getLatestResponses(user_id);
	console.log('📊 Latest responses from DB:', response);

	const latestResponsesData = response.data || [];
	console.log('🔍 Latest responses (no filtering needed):', latestResponsesData);

	const questionResponse = latestResponsesData.find((r) => r.question_id === questionId);
	console.log('🎯 Found response for this question:', questionResponse);

	const result = {
		responseInput: questionResponse?.response_text || null,
		responseId: questionResponse?.id || null,
		visibility: questionResponse?.visibility || 'private'
	};

	console.log('📤 Returning question details:', result);
	console.groupEnd();

	return result;
};

