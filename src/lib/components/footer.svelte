<script lang="ts">
	let { devMode, profileId } = $props();
</script>

<footer id="dev-info" class="dev flex flex-row justify-between">
  <div class="dev">
    {#if profileId}
      <p>Profile ID: {profileId}</p>
    {:else}
      <p>Not Logged In</p>
    {/if}
  </div>

  <div class="dev">
    <p>Dev Mode: {devMode}</p>
  </div>
</footer>