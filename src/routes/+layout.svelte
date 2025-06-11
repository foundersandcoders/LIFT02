<script lang="ts">
	import '../app.css';
	import Header from "$lib/components/layouts/Header.svelte";
	import Footer from "$lib/components/layouts/Footer.svelte";
	import { setContext } from 'svelte';
	import type { App, Detail, DetailItem, List, ListCategory, Table, View, ViewName } from "$lib/types/ui";

	let devMode = $state<boolean>(true);
	let profileId = $derived(devMode ? "550e8400-e29b-41d4-a716-446655440001" : "");

	let app = $state<App>({
		view: {
			name: "dash"
		},
		list: {
			table: null,
			category: {
				raw: null,
				format: null
			}
		},
		detail: {
			table: null,
			item: {
				rowId: null
			}
		}
	});

	setContext('getDetailItem', () => app.detail.item.rowId);
	setContext('getDetailTable', () => app.detail.table);
	setContext('getDevMode', () => devMode);
	setContext('getListCategory', () => app.list.category);
	setContext('getListTable', () => app.list.table);
	setContext('getProfileId', () => profileId);
	setContext('getViewName', () => app.view.name);

	setContext('setDetailTable', (newTable:Table) => { app.detail.table = newTable });
	setContext('setDetailItem', (newDbId:string) => { app.detail.item.rowId = newDbId });
	setContext("setListCategory", (newCategory:ListCategory) => { app.list.category = newCategory });
	setContext("setListTable", (newTable:Table) => { app.list.table = newTable });
	setContext('setViewName', (newView:ViewName) => { app.view.name = newView });
	setContext('toggleDevMode', () => { devMode = !devMode });

	let { children } = $props();
	
	$inspect(app.view).with((type, value) => console.log(`${type} view: ${value}`));
	$inspect(app.list).with((type, value) => console.log(`${type} list: ${value}`));
	$inspect(app.detail).with((type, value) => console.log(`${type} detail: ${value}`));
	$inspect(devMode).with((type, value) => console.log(`${type} devMode: ${value}`));
	$inspect(profileId).with((type, value) => console.log(`${type} profileId: ${value}`));
</script>

<Header />

{@render children()}

<Footer {devMode} {profileId}/>

<!-- note: Header/Footer Components
 	It might be overkill to have the header & footer as separate components as they only appear here, but I'll do it that way for now as future-proofing
	-->