import { getLatestActions } from '$lib/services/database';
import { filterLatestResponses, filterLatestActions } from '$lib/utils/versionFilter';
import { getLatestResponses } from '$lib/services/database/responses';
import type { QuestionDetails } from '$lib/types/appState';

export const getQuestionDetails = async (
	user_id: string,
	questionId: string
): Promise<QuestionDetails> => {
	const response = await getLatestResponses(user_id);
    const latestResponsesData = response.data ?
  filterLatestResponses(response.data) : [];
	const questionResponse = latestResponsesData.find((r) => r.question_id === questionId);
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
    const latestActionsData = response.data ? filterLatestActions(response.data) :
  [];
	if (response?.data) {
		const actionResponse = latestActionsData.find((r) => r.response_id === response_Id);
		return actionResponse;
	}

	return null;
};
