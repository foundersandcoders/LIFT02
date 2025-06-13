<script lang="ts">
	import type { View } from "$lib/types/ui";
	import type { Question } from "$lib/types/main";
	import { getContext } from 'svelte';

	export let question: Question;

	const setView = getContext<(view:View) => void>('setView');

	const onclick = () => {setView("detail")};
	const onkeydown = (e: KeyboardEvent) => {
    if (e.key === 'Enter') setView("detail")
  };
</script>

<div class="p-4 m-2 flex justify-between border border-primary rounded" {onclick} {onkeydown} role="button" tabindex="0">
  <div><pre>status</pre></div>
	<div>{question.preview}</div>
  <div><pre>actions</pre></div>
</div>