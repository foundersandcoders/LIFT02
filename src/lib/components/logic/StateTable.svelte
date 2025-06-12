<script>
  import { getContext } from "svelte";

	const getApp = getContext('getApp');
	const app = $derived(getApp());
</script>

<div id="values" class="dev dev-div values">
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
</div>