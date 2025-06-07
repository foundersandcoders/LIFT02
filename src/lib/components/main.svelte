<script lang="ts">
	import { getView } from "$lib/components/logic/view.svelte";

	import Dash from "$lib/components/view/dash.svelte";
	import List from "$lib/components/view/list.svelte";
	import Detail from "$lib/components/view/detail.svelte";
</script>

<div class="dev">
	<h1>main</h1>

	{#if getView() === "dash"}
		<Dash />
	{:else if getView() === "list"}
		<List />
	{:else if getView() === "detail"}
		<Detail />
	{/if}
</div>