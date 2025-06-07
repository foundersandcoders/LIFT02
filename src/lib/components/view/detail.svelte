<script lang="ts">
	import { setView } from "$lib/components/logic/view.svelte";

	const onBackClick = () => {
		setView("list");
	};
</script>

<div class="dev">
	<h1>view/detail</h1>

	<button onclick={onBackClick} class="dev button">
		Back
	</button>
</div>