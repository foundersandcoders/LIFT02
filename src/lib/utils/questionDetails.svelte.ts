import { getLatestResponses } from '$lib/services/database/responses';
import { getLatestActions } from '$lib/services/database';
import type { QuestionDetails } from '$lib/components/cards/QuestionCard.svelte';

export const getQuestionDetails = async (
	user_id: string,
	questionId: string
): Promise<QuestionDetails> => {
	const response = await getLatestResponses(user_id);
	const questionResponse = response.data?.find((r) => r.question_id === questionId);
	const previousAction = await getActionDetails(questionResponse?.id, user_id);

	return {
		responseInput: questionResponse?.response_text || null,
		actionsInput: previousAction?.description || null,
		actionType: previousAction?.type || '',
		responseId: questionResponse?.id || null
	};
};

const getActionDetails = async (response_Id: string | undefined, user_id: string) => {
	const response = await getLatestActions(user_id);
	if (response?.data) {
		const actionResponse = response.data.find((r) => r.response_id === response_Id);
		return actionResponse;
	}
	return null;
};
