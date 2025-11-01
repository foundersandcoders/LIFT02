<script lang="ts">
	import { dev } from '$app/environment';
	import StateTable from '$lib/components/logic/StateTable.svelte';
	import { getContext } from 'svelte';
	import FontSizeControl from '../ui/FontSizeControl.svelte';
	import HelpButton from '../ui/HelpButton.svelte';
	import ProfileButton from '../ui/ProfileButton.svelte';

	let { devMode } = $props();

	const toggleDevMode = getContext<() => void>('setDevMode');
	const onToggleDevMode = () => {
		toggleDevMode();
	};
</script>

<footer class="footer">
	<HelpButton />

	<ProfileButton />

	<FontSizeControl />
</footer>

{#if devMode}
	<StateTable />
{/if}
