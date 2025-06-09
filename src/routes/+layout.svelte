<script lang="ts">
	import '../app.css';
	import Header from "$lib/components/layouts/Header.svelte";
	import Footer from "$lib/components/layouts/Footer.svelte";
	import { setContext } from 'svelte';
	import type { View } from "$lib/types/ui";

	let devMode = $state<boolean>(true);
	setContext('devMode', () => devMode);
	setContext('toggleDevMode', () => { devMode = !devMode });

	/* todo: Profile ID
		This will need to be replaced by the authentication system
		*/
	let profileId = $derived(devMode ? "550e8400-e29b-41d4-a716-446655440001" : "");
	setContext('profileId', () => profileId);

	let view = $state<View>("dash");
	setContext('view', () => view);
	setContext('setView', (newView: View) => { view = newView });

	let { children } = $props();
</script>

<Header />

{@render children()}

<Footer {devMode} {profileId}/>

<!-- note: Header/Footer Components
 	It might be overkill to have the header & footer as separate components as they only appear here, but I'll do it that way for now as future-proofing
	-->