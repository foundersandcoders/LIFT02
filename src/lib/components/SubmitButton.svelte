<script lang="ts">
	import { createAction } from '$lib/services/database/actions';
	import { createResponse } from '$lib/services/database/responses';

	//Delete later --> for development only
	const user_id = '550e8400-e29b-41d4-a716-446655440005';
	const questionId = 'bacc6ffa-b589-4bdc-8eb8-d29eeef7f153';

	interface Props {
		text: string;
		responseInput: string;
		actionsInput: string;
		actionType: string;
		status: string;
		isPublic: string;
		responseId: string;
	}

	let { text, responseInput, actionsInput, actionType, status, isPublic, responseId }: Props =
		$props();

	function handleSubmit() {
		createResponse(user_id, {
			response_text: responseInput,
			question_id: questionId,
			status: status,
			visibility: isPublic
		});
		createAction(user_id, { type: actionType, description: actionsInput, response_id: responseId });
	}
</script>

<button type="button" onclick={handleSubmit} class="rounded-2xl border p-4">{text}</button>
