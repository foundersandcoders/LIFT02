<script lang="ts">
	import '../app.css';
	import { setContext } from 'svelte';
	import Header from "$lib/components/layouts/Header.svelte";
	import Footer from "$lib/components/layouts/Footer.svelte";
	import StateTable from '$lib/components/logic/StateTable.svelte';
	import type { AppState, Detail, List, ItemCategory, RowId, TableName, ViewName } from "$lib/types/appState";
	import { inspectPrefixDev as preDev, inspectPrefixApp as preApp } from "$lib/utils/inspector";

	// Dev Mode
	let devMode = $state<boolean>(false);
	$inspect(devMode).with((type, value) => console.log(`${preDev}${type} devMode: ${value}`));

	// let profileId = $derived(devMode ? "550e8400-e29b-41d4-a716-446655440001" : null);
	// $inspect(profileId).with((type, value) => console.log(`${preDev}${type} profileId: ${value}`));

	// App State
	let appState = $state<AppState>({
		profile: {
			id: null
		},
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

	$inspect(appState.profile.id).with((type, value) => console.log(`${preApp}${type} profile.id: ${value}`));
	$inspect(appState.view.name).with((type, value) => console.log(`${preApp}${type} view.name: ${value}`));
	$inspect(appState.list.table).with((type, value) => console.log(`${preApp}${type} list.table: ${value}`));
	$inspect(appState.list.category.raw).with((type, value) => console.log(`${preApp}${type} list.cat.raw: ${value}`));
	$inspect(appState.list.category.format).with((type, value) => console.log(`${preApp}${type} list.cat.format: ${value}`));
	$inspect(appState.detail.table).with((type, value) => console.log(`${preApp}${type} detail.table: ${value}`));
	$inspect(appState.detail.item.rowId).with((type, value) => console.log(`${preApp}${type} detail.item.rowId: ${value}`));

	// App Context
	setContext("getApp", () => appState);
	setContext('getDetail', () => appState.detail);
	setContext('getDetailItem', () => appState.detail.item.rowId);
	setContext('getDetailTable', () => appState.detail.table);
	setContext('getDevMode', () => devMode);
	setContext('getList', () => appState.list);
	setContext('getListCategory', () => appState.list.category);
	setContext('getListTable', () => appState.list.table);
	setContext('getProfileId', () => appState.profile.id);
	setContext('getViewName', () => appState.view.name);

	setContext('setDetail', (newDetail:Detail) => { appState.detail = newDetail });
	setContext('setDetailTable', (newTable:null | TableName) => { appState.detail.table = newTable });
	setContext('setDetailItem', (newDbId:null | RowId) => { appState.detail.item.rowId = newDbId });
	setContext('setDevMode', () => { devMode = !devMode });
	setContext('setList', (newList:List) => { appState.list = newList });
	setContext("setListCategory", (newCategory:ItemCategory) => { appState.list.category = newCategory });
	setContext("setListTable", (newTable:null | TableName) => { appState.list.table = newTable });
	setContext("setProfileId", (newId:null | RowId) => { appState.profile.id = newId });
	setContext('setViewName', (newView:ViewName) => { appState.view.name = newView });

	let { children } = $props();
</script>

<Header />

{@render children()}

{#if devMode} <StateTable /> {/if}

<Footer {devMode} profileId={appState.profile.id}/>

<!-- note: Header/Footer Components
 	It might be overkill to have the header & footer as separate components as they only appear here, but I'll do it that way for now as future-proofing
	-->