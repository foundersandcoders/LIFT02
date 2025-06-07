<script lang="ts">
	import { setView } from "$lib/components/logic/view.svelte";
	import { setListNum, setTileNum, getTileNum } from "$lib/components/logic/dev.svelte";
	import { randomNum } from "$lib/utils/random";

	setTileNum(randomNum());

	const tileCountNum = getTileNum();
	const tileCountText = tileCountNum === 1 ? "tile" : "tiles";

	const onclick = (listNum: number) => {
		setListNum(listNum);
		setView("list");
	};
</script>

<div class="dev">
	<h1>view/dash</h1>

	<p>There should be {tileCountNum} {tileCountText}</p>

	{#each [...Array(tileCountNum)] as _, i}
		{@const thisList = randomNum()}
		<button on:click={() => onclick(thisList)} class="dev tile">
			<p>Tile {i + 1}</p>
			<p>{thisList} Entries</p>
		</button>
	{/each}
</div>