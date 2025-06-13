<script lang="ts">
	import type { View } from '$lib/types/ui';
	import { getContext } from 'svelte';
	import QuestionCard from '$lib/components/cards/QuestionCard.svelte';

	const setView = getContext<(view: View) => void>('setView');

	const onBackClick = () => {
		setView('list');
	};

	const questionId = 'bacc6ffa-b589-4bdc-8eb8-d29eeef7f153';
</script>

<div class="p-0">
		<button onclick={onBackClick} class="btn btn-primary"> Back </button>

	<div id="detail-content" class="">
		<QuestionCard {questionId} />
	</div>
</div>
