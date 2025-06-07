<script lang="ts">
	import '$lib/components/QuestionCard.svelte';
	import QuestionCard from '$lib/components/QuestionCard.svelte';
	import { getQuestionById, getQuestions } from '$lib/services/database/questions';

	//Delete later --> This needs to manually updated every time you db reset
	const questionId = '0211af06-9dfb-47ec-9424-363be6869010';
</script>

<QuestionCard {questionId} />
