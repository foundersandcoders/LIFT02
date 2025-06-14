<script lang="ts">
	import '../app.css';
	import Header from '$lib/components/layouts/Header.svelte';
	import Footer from '$lib/components/layouts/Footer.svelte';
	import { setContext } from 'svelte';
	import type { ListCategory, View } from '$lib/types/ui';

	let devMode = $state<boolean>(true);
	setContext('getDevMode', () => devMode);
	setContext('toggleDevMode', () => {
		devMode = !devMode;
	});

	/* todo: Profile ID
		This will need to be replaced by the authentication system
		*/
	let profileId = $derived(devMode ? '550e8400-e29b-41d4-a716-446655440001' : '');
	setContext('getProfileId', () => profileId);

	let view = $state<View>('dash');
	setContext('getView', () => view);
	setContext('setView', (newView: View) => {
		view = newView;
	});

	let list = $state<ListCategory>({ raw: '', format: '' });
	setContext('getList', () => list);
	setContext('setList', (newList: ListCategory) => {
		list = newList;
	});

	let { children } = $props();

	$inspect(devMode).with((type, value) => console.log(`${type} devMode: ${value}`));
	$inspect(profileId).with((type, value) => console.log(`${type} profileId: ${value}`));
	$inspect(view).with((type, value) => console.log(`${type} view: ${value}`));
	$inspect(list).with((type, value) => console.log(`${type} list: ${value.raw}`));
</script>
<div class="min-h-screen flex flex-col">
		<Header />

	<main class="flex-1">
		{@render children()}
	</main>
	

		<Footer {devMode} {profileId}/>
</div>
