<script lang="ts">
  import StateTable from "$lib/components/logic/StateTable.svelte";

  let { devMode, profileId } = $props();
</script>

<footer id="footer" class="w-full bg-primary footer footer-center">
  <div id="footer-content" class="w-full flex justify-between">
    <div id="footer-content-dev-mode" class="p-4">
      <p>Dev Mode: {devMode}</p>
    </div>

    <div id="footer-content-profile" class="p-4">
      {#if profileId}
        <p>Profile ID: {profileId}</p>
      {:else}
        <p>Not Logged In</p>
      {/if}
    </div>
  </div>
</footer>

{#if devMode}
  <StateTable />
{/if}
