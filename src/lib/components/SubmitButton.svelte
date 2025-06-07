<script lang="ts">
	import { createAction } from '$lib/services/database/actions';
	import { createResponse } from '$lib/services/database/responses';

	//Delete later --> for development only
	const user_id = '550e8400-e29b-41d4-a716-446655440001';
	const questionId = '68934e75-14b6-47ed-9e27-2d7fae9e579a';

	interface Props {
		text: string;
		responseInput: string;
		actionsInput: string;
		actionType: string;
		status: string;
	}

	let { text, responseInput, actionsInput, actionType, status }: Props = $props();

	function handleSubmit() {
		createResponse(user_id, {
			response_text: responseInput,
			question_id: questionId,
			status: status
		});
		createAction(user_id, { type: actionType, description: actionsInput });
	}
</script>

<button type="button" onclick={handleSubmit} class="rounded-2xl border p-4">{text}</button>
