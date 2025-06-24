<script lang="ts">
	import { dev } from "$app/environment";
  import StateTable from "$lib/components/logic/StateTable.svelte";
  import { getContext } from "svelte";

  let { devMode, profileId } = $props();

	const toggleDevMode = getContext<() => void>('setDevMode');
	const onToggleDevMode = () => {
		toggleDevMode();
	};
</script>

<footer id="footer" class="w-full bg-primary text-primary-content footer footer-center">
  <div id="footer-content" class="w-full flex justify-between">
    <div id="footer-content-profile" class="p-4">
      <p class="text-sm">
        {#if profileId}
          Profile ID: {profileId}
        {:else}
          Not Logged In
        {/if}
      </p>
    </div>

    <div id="footer-content-dev-mode" class="p-4">
      {#if devMode}<p>Dev Mode</p>{/if}
    </div>

    <div id="footer-content-dev" class="p-4">
      <!-- Dev Mode Toggle
				(Development Only)
			-->
      <button onclick={onToggleDevMode}
        class="btn-dev"
        type="button"
        aria-label="Toggle development mode"
      >
        Dev
      </button>
    </div>
  </div>
</footer>

{#if devMode}
  <StateTable />
{/if}
