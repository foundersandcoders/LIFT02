<script lang="ts">
	let { showArchived, onToggle } = $props<{
		showArchived: boolean;
		onToggle: (showArchived: boolean) => void;
	}>();

	const handleToggle = (event: Event & { currentTarget: HTMLInputElement }) => {
		const isChecked = event.currentTarget.checked;
		onToggle(isChecked);
	};
</script>

<label class="flex items-center justify-end gap-2">
	<span class="text-sm">Show Inactive</span>
	<input
		type="checkbox"
		class="toggle border-grey-500 bg-grey-400 checked:border-accent-dark checked:bg-accent checked:text-gray-800"
		checked={showArchived}
		onchange={handleToggle}
	/>
</label>
