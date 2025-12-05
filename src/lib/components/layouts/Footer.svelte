<script lang="ts">
	import StateTable from '$lib/components/logic/StateTable.svelte';
	import FontSizeControl from '../ui/FontSizeControl.svelte';
	import HelpButton from '../ui/HelpButton.svelte';
	import ProfileButton from '../ui/ProfileButton.svelte';

	let { devMode } = $props();
</script>

<footer class="footer">
	<HelpButton />

	<ProfileButton />

	<FontSizeControl />
</footer>

{#if devMode}
	<StateTable />
{/if}
