<script lang="ts">
	import '../app.css';
	import { setContext } from 'svelte';
	import type {
		AppState,
		Detail,
		List,
		ItemCategory,
		Profile,
		RowId,
		TableName,
		View,
		ViewName
	} from '$lib/types/appState';
	import {
		inspectPrefixDev as preDev,
		inspectPrefixApp as preApp
	} from '$lib/utils/inspector';
	import Header from '$lib/components/layouts/Header.svelte';
	import Footer from '$lib/components/layouts/Footer.svelte';

	// Dev Mode
	let devMode = $state<boolean>(false);
	$inspect(devMode).with((type, value) => console.log(`${preDev}${type} devMode: ${value}`));
	setContext('getDevMode', () => devMode);
	setContext('setDevMode', () => {
		devMode = !devMode;
	});

	// =1 App State
	let appState = $state<AppState>({
		profile: {
			id: null,
			name: null
		},
		view: {
			name: 'dash'
		},
		list: {
			table: null,
			category: {
				raw: null,
				format: null
			}
		},
		detail: {
			// TODO: Remove detail table from schema
			table: null,
			item: {
				id: null
			}
		},
		dev: {
			testProfileId: '550e8400-e29b-41d4-a716-446655440001',
			testProfileName: 'Perico Palotes'
		}
	});

	// [!] Check this doesn't break the mock login
	$effect(() => {
		if (devMode) {
			// appState.profile.id = appState.dev.testProfileId;
			// appState.profile.name = appState.dev.testProfileName;
		} else {
			// appState.profile.id = null;
			// appState.profile.name = null;
		}
	});

	// =2 App State Inspectors
	$inspect(appState.profile.id).with((type, value) =>
		console.log(`${preApp}${type} profile.id: ${value}`)
	);
	$inspect(appState.view.name).with((type, value) =>
		console.log(`${preApp}${type} view.name: ${value}`)
	);
	$inspect(appState.list.table).with((type, value) =>
		console.log(`${preApp}${type} list.table: ${value}`)
	);
	$inspect(appState.list.category.raw).with((type, value) =>
		console.log(`${preApp}${type} list.cat.raw: ${value}`)
	);
	$inspect(appState.list.category.format).with((type, value) =>
		console.log(`${preApp}${type} list.cat.format: ${value}`)
	);
	$inspect(appState.detail.table).with((type, value) =>
		console.log(`${preApp}${type} detail.table: ${value}`)
	);
	$inspect(appState.detail.item.id).with((type, value) =>
		console.log(`${preApp}${type} detail.item.rowId: ${value}`)
	);

	// =1 App Context
	setContext('getApp', () => appState);
	setContext('getDetail', () => appState.detail);
	setContext('getDetailItemId', () => appState.detail.item.id);
	setContext('getDetailTable', () => appState.detail.table);
	setContext('getList', () => appState.list);
	setContext('getListCategory', () => appState.list.category);
	setContext('getListTable', () => appState.list.table);
	setContext('getProfile', () => appState.profile);
	setContext('getProfileId', () => appState.profile.id);
	setContext('getProfileName', () => appState.profile.name);
	setContext('getView', () => appState.view);
	setContext('getViewName', () => appState.view.name);

	setContext('setDetail', (newDetail: Detail) => {
		appState.detail = newDetail;
	});
	setContext('setDetailTable', (newTable: null | TableName) => {
		appState.detail.table = newTable;
	});
	setContext('setDetailItemId', (newDbId: null | RowId) => {
		appState.detail.item.id = newDbId;
	});
	setContext('setDevMode', () => {
		devMode = !devMode;
	});
	setContext('setList', (newList: List) => {
		appState.list = newList;
	});
	setContext('setListCategory', (newCategory: ItemCategory) => {
		appState.list.category = newCategory;
	});
	setContext('setListTable', (newTable: null | TableName) => {
		appState.list.table = newTable;
	});
	setContext('setProfile', (newProfile: Profile) => {
		appState.profile = newProfile;
	});
	setContext('setProfileId', (newId: null | RowId) => {
		appState.profile.id = newId;
	});
	setContext('setView', (newView: View) => {
		appState.view = newView;
	});
	setContext('setViewName', (newView: ViewName) => {
		appState.view.name = newView;
	});

	// =1 Child Props
	let { children } = $props();
</script>

<div class="flex min-h-screen flex-col">
	<Header />

	<main id={appState.view.name} class="bg-base-200 flex-1">
		{@render children()}
	</main>

	<Footer {devMode} profileId={appState.profile.id} />
</div>
