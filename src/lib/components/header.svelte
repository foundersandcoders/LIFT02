<script lang="ts">
	import { getContext } from 'svelte';

	const toggleDevMode = getContext<() => void>('toggleDevMode');
	const onToggleDevMode = () => { toggleDevMode() };
</script>

<header class="dev flex flex-row justify-between">
	<h1 class="dev">
		<strike>Beacons</strike> Questionnaire
	</h1>

	<button onclick={onToggleDevMode} class="dev button">
		Toggle Dev Mode
	</button>
</header>