<script lang="ts">
  let { devMode, profileId } = $props();
</script>

<footer class="w-full bg-primary footer footer-center flex justify-between">
  <div class="p-4">
    <p>Dev Mode: {devMode}</p>
  </div>

  <div class="p-4">
    {#if profileId}
      <p>Profile ID: {profileId}</p>
    {:else}
      <p>Not Logged In</p>
    {/if}
  </div>
</footer>
