<script lang="ts">
	import { getContext } from 'svelte';
	import type { TableName, ViewName } from "$lib/types/appState";
	import type { ListEntry } from "$lib/types/tableMain";

	export let item:ListEntry;
	export let table:TableName;

	const setView = getContext<(view:ViewName) => void>('setViewName');

	const onclick = () => {
		setView("detail");

		const listEntry:ListEntry = { id: item.id };
		
		const event = new CustomEvent('itemClick', {
			detail: { table, item: listEntry }
		});

		dispatchEvent(event);
	};

	const onkeydown = (press:KeyboardEvent) => {
		if (press.key === 'Enter') onclick();
	};
</script>

<div class="dev dev-div flex flex-row justify-between" {onclick} {onkeydown} role="button" tabindex="0">
	<div class="dev dev-div dev-text"><pre>status</pre></div>
	<div class="dev dev-div dev-text">{listitem.preview}</div>
	<div class="dev dev-div dev-text"><pre>actions</pre></div>
</div>