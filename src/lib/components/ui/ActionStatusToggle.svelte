<script lang="ts">
	let { status, onStatusChange } = $props<{
		status: 'active' | 'archived';
		onStatusChange: (newStatus: 'active' | 'archived') => void;
	}>();

	const checked = $derived(status === 'archived');

	const handleToggle = (event: Event & { currentTarget: HTMLInputElement }) => {
		const isArchived = event.currentTarget.checked;
		const newStatus = isArchived ? 'archived' : 'active';
		onStatusChange(newStatus);
	};
</script>

<label class="flex items-center gap-2">
	<input
		type="checkbox"
		class="toggle border-accent-dark bg-accent checked:border-gray-500 checked:bg-gray-400 checked:text-gray-800"
		{checked}
		onchange={handleToggle}
	/>
	<span class="w-16 text-sm">{status === 'active' ? 'Active' : 'Inactive'}</span>
</label>
