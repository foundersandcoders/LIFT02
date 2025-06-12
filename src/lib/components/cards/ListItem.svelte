<script lang="ts">
	import type { View } from '$lib/types/ui';
	import type { Question } from '$lib/types/main';
	import { getContext } from 'svelte';

	export let question: Question;

	const setView = getContext<(view: View) => void>('setView');

	const onclick = () => {
		setView('detail');
	};
	const onkeydown = (e: KeyboardEvent) => {
		if (e.key === 'Enter') setView('detail');
	};
</script>

<div
	class="dev dev-div flex flex-row justify-between"
	{onclick}
	{onkeydown}
	role="button"
	tabindex="0"
>
	<div class="dev dev-div dev-text"><pre>status</pre></div>
	<div class="dev dev-div dev-text">{question.preview}</div>
	<div class="dev dev-div dev-text"><pre>actions</pre></div>
</div>
