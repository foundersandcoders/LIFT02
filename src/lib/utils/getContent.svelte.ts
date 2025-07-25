import { getLatestActions } from '$lib/services/database';
import { getLatestResponses } from '$lib/services/database/responses';
import type { QuestionConnections } from '$lib/types/appState';
import { filterLatestResponses } from '$lib/utils/versionFilter';

export const getQuestionConnections = async (
	user_id: string,
	questionId: string
): Promise<QuestionConnections> => {
	console.groupCollapsed('📋 getQuestionDetails');
	console.log('📥 Input:', { user_id, questionId });

	const response = await getLatestResponses(user_id);
	console.log('📊 Latest responses from DB:', response);

	const latestResponsesData = response.data ? filterLatestResponses(response.data) : [];
	console.log('🔍 Filtered latest responses:', latestResponsesData);

	const questionResponse = latestResponsesData.find((r) => r.question_id === questionId);
	console.log('🎯 Found response for this question:', questionResponse);

	const previousAction = await getActionDetails(questionResponse?.id, user_id);
	console.log('⚡ Previous action:', previousAction);

	const result = {
		responseInput: questionResponse?.response_text || null,
		actionsInput: previousAction?.description || null,
		actionType: previousAction?.type || '',
		responseId: questionResponse?.id || null,
		visibility: questionResponse?.visibility || 'private'
	};

	console.log('📤 Returning question details:', result);
	console.groupEnd();

	return result;
};

const getActionDetails = async (response_Id: string | undefined, user_id: string) => {
	const response = await getLatestActions(user_id, false);
	const allActionsData = response.data || [];
	if (response?.data) {
		const actionResponse = allActionsData.find((r) => r.response_id === response_Id);
		return actionResponse;
	}

	return null;
};
