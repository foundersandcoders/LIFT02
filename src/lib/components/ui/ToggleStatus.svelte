<script lang="ts">
	let { visibility, toggleVisibility } = $props();

	const checked = visibility === 'private' ? false : true;

	const onclick = () => {
		toggleVisibility();
	};
</script>

<fieldset id="vis" class="form-fieldset">
	<label for="vis-label" class="label text-sm"> Visibility to employer </label>

	<label class="flex items-center gap-2">
		<input id="vis-toggle" type="checkbox" {checked} {onclick} class="toggle toggle-accent" />
		{visibility}
	</label>
</fieldset>
