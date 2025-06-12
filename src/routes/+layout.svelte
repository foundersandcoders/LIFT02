<script lang="ts">
	import '../app.css';
	import Header from "$lib/components/layouts/Header.svelte";
	import Footer from "$lib/components/layouts/Footer.svelte";
	import { setContext } from 'svelte';
	import type { App, ListCategory, RowId, TableName, ViewName } from "$lib/types/ui";

	let app = $state<App>({
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

	let devMode = $state<boolean>(false);

	let profileId = $derived(devMode ? "550e8400-e29b-41d4-a716-446655440001" : null);

	setContext('getDetailItem', () => app.detail.item.rowId);
	setContext('getDetailTable', () => app.detail.table);
	setContext('getDevMode', () => devMode);
	setContext('getListCategory', () => app.list.category);
	setContext('getListTable', () => app.list.table);
	setContext('getProfileId', () => profileId);
	setContext('getViewName', () => app.view.name);

	setContext('setDetailTable', (newTable:TableName) => { app.detail.table = newTable });
	setContext('setDetailItem', (newDbId:RowId) => { app.detail.item.rowId = newDbId });
	setContext('setDevMode', () => {
		devMode = !devMode;
		app.profile.id = profileId;
	});
	setContext("setListCategory", (newCategory:ListCategory) => { app.list.category = newCategory });
	setContext("setListTable", (newTable:TableName) => { app.list.table = newTable });
	setContext("setProfileId", (newId:RowId) => { app.profile.id = newId });
	setContext('setViewName', (newView:ViewName) => { app.view.name = newView });

	let { children } = $props();
	
	$inspect(app.view).with((type, value) => console.log(`${type} view: ${value}`));
	$inspect(app.list).with((type, value) => console.log(`${type} list: ${value}`));
	$inspect(app.detail).with((type, value) => console.log(`${type} detail: ${value}`));
	$inspect(devMode).with((type, value) => console.log(`${type} devMode: ${value}`));
	$inspect(profileId).with((type, value) => console.log(`${type} profileId: ${value}`));
</script>

<Header />

{@render children()}

<aside id="values" class="dev dev-div values">
	<table class="border-collapse table-auto">
		<thead>
			<tr>
				<th>1</th>
				<th>2</th>
				<th>3</th>
				<th>value</th>
			</tr>
		</thead>

		<tbody>
			{#each Object.entries(app) as [key, value]}
				{#if typeof value === 'object' && value !== null}
					{#each Object.entries(value) as [subKey, subValue]}
						{#if typeof subValue === 'object' && subValue !== null}
							{#each Object.entries(subValue) as [subSubKey, subSubValue]}
								<tr>
									<td>{key}</td>
									<td>{subKey}</td>
									<td>{subSubKey}</td>
									<td>{JSON.stringify(subSubValue)}</td>
								</tr>
							{/each}
						{:else}
							<tr>
								<td>{key}</td>
								<td>{subKey}</td>
								<td> ----- </td>
								<td>{JSON.stringify(subValue)}</td>
							</tr>
						{/if}
					{/each}
				{:else}
					<tr>
						<td>{key}</td>
						<td> ----- </td>
						<td> ----- </td>
						<td>{JSON.stringify(value)}</td>
					</tr>
				{/if}
			{/each}
		</tbody>
	</table>
</aside>

<Footer {devMode} {profileId}/>

<!-- note: Header/Footer Components
 	It might be overkill to have the header & footer as separate components as they only appear here, but I'll do it that way for now as future-proofing
	-->