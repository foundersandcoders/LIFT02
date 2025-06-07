<script lang="ts">
	import '$lib/components/QuestionCard.svelte';
	import QuestionCard from '$lib/components/QuestionCard.svelte';
	import { getQuestionById, getQuestions } from '$lib/services/database/questions';

	//Delete later --> This needs to manually updated every time you db reset
	const questionId = 'd2f4c7f3-590c-44b4-8ca2-0d9f3b9067ba';
</script>

<QuestionCard {questionId} />
