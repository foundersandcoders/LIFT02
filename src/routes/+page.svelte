<script lang="ts">
	import '$lib/components/QuestionCard.svelte';
	import QuestionCard from '$lib/components/QuestionCard.svelte';
	import { getQuestionById, getQuestions } from '$lib/services/database/questions';

	//Delete later --> This needs to manually updated every time you db reset
	const questionId = '68934e75-14b6-47ed-9e27-2d7fae9e579a';
</script>

<QuestionCard {questionId} />
