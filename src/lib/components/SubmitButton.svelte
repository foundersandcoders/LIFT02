<script lang="ts">
	import { createAction } from '$lib/services/database/actions';
	import { createResponse } from '$lib/services/database/responses';

	//Delete later --> for development only
	const user_id = '550e8400-e29b-41d4-a716-446655440001';

	interface Props {
		text: string;
		responseInput: string;
		actionsInput: string;
	}

	let { text, responseInput, actionsInput }: Props = $props();

	function handleSubmit() {
		createResponse(user_id, { response_text: responseInput });
		createAction(user_id, { type: 'test_action', description: actionsInput });
	}
</script>

<button type="button" onclick={handleSubmit} class="rounded-2xl border p-4">{text}</button>
