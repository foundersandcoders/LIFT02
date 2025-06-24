<script lang="ts">
	import { createAction } from '$lib/services/database/actions';
	import { createResponse } from '$lib/services/database/responses';
	import type { QuestionDetails } from '$lib/types/appState';
	import { getContext } from 'svelte';

	interface Props {
		text: string;
		status: string;
		visibility: string;
		actionType: string;
		details: QuestionDetails;
	}

	let { text, status, details, actionType, visibility }: Props = $props();

	const profileId:string = getContext('getProfileId');
	const questionId:string = getContext('getDetailItemId');

	const onclick = () => {
		createResponse(profileId, {
			response_text: details.responseInput,
			question_id: questionId,
			status: status,
			visibility: visibility
		});
		createAction(profileId, {
			type: actionType,
			description: details.actionsInput,
			response_id: details.responseId
		});
	};
</script>

<button {onclick} type="submit" class="btn-submit">
	{text}
</button>
