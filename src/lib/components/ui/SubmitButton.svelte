<script lang="ts">
	import { createAction } from '$lib/services/database/actions';
	import { createResponse } from '$lib/services/database/responses';
	import type { QuestionDetails } from '../cards/QuestionCard.svelte';

	//Delete later --> for development only
	const user_id = '550e8400-e29b-41d4-a716-446655440005';
	const questionId = 'bacc6ffa-b589-4bdc-8eb8-d29eeef7f153';

	interface Props {
		text: string;
		status: string;
		visibility: string;
		details: QuestionDetails;
	}

	let { text, status, details, visibility }: Props = $props();

	function handleSubmit() {
		createResponse(user_id, {
			response_text: details.responseInput,
			question_id: questionId,
			status: status,
			visibility: visibility
		});
		createAction(user_id, {
			type: details.actionType,
			description: details.actionsInput,
			response_id: details.responseId
		});
	}
</script>

<button type="button" onclick={handleSubmit} class="rounded-2xl border p-4">{text}</button>
