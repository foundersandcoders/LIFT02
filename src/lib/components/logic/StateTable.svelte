<script lang="ts">
  import { getContext } from "svelte";
	import type { AppState, RowId } from "$lib/types/appState";

	const getApp = getContext<() => AppState>('getApp');
	const app:AppState = $derived(getApp());

	const setProfileId = getContext<(profileId:null|RowId) => void>('setProfileId');

	const onclick = () => {
		setProfileId(app.profile.id ? null : "550e8400-e29b-41d4-a716-446655440001");
	};
</script>

<section id="dev-menu" class="values">
	<div id="dev-menu-header" class="">
		<button id="dev-menu-header-button" {onclick} class="btn-dev">
			Log {app.profile.id ? "Out" : "In"}
		</button>
	</div>

	<table id="dev-menu-table" class="table table-zebra">
		<thead>
			<tr>
				<th>Key 1</th>
				<th>Key 2</th>
				<th>Key 3</th>
				<th>Value</th>
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
									<td>{JSON.stringify(subSubValue).replace("null", "-----")}</td>
								</tr>
							{/each}
						{:else}
							<tr>
								<td>{key}</td>
								<td>{subKey}</td>
								<td>-----</td>
								<td>{JSON.stringify(subValue).replace("null", "-----")}</td>
							</tr>
						{/if}
					{/each}
				{:else}
					<tr>
						<td>{key}</td>
						<td> ----- </td>
						<td> ----- </td>
						<td>{JSON.stringify(value).replace("null", "-----")}</td>
					</tr>
				{/if}
			{/each}
		</tbody>
	</table>
</section>