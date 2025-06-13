<script lang="ts">
	let { visibility, toggleVisibility } = $props();
</script>

<fieldset class="fieldset border-primary rounded-xl border-2 p-4 flex justify-between">
  <label for="visibilityToggle" class="text-sm">Visibility to employer</label>
  <label class="label text-sm flex justify-end">
    <input id="visibilityToggle" type="checkbox" checked={visibility === "private" ? false : true} onclick={toggleVisibility} class="toggle toggle-primary border-2" />
    {visibility}
  </label>
</fieldset>