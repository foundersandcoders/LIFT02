<script lang="ts">
	import { randomNum } from '$lib/utils/random';

	interface Props {
		text: string;
		position?: 'top' | 'bottom' | 'left' | 'right';
	}

	let { text, position = 'top' }: Props = $props();

	const tooltipId = `tooltip-${randomNum()}`;
	let visible = $state(false);
	let timer: number | undefined;

	const show = () => (visible = true);
	const hide = () => (visible = false);

	const handleTouchStart = () => {
		timer = window.setTimeout(() => {
			show();
		}, 500); // 500ms for a long press
	};

	const handleTouchEnd = () => {
		clearTimeout(timer);
		hide();
	};

	const handleTouchMove = () => {
		clearTimeout(timer);
	};
</script>

<div
	class="tooltip tooltip-{position}"
	data-tip={text}
	onmouseenter={show}
	onmouseleave={hide}
	onfocus={show}
	onblur={hide}
	ontouchstart={handleTouchStart}
	ontouchend={handleTouchEnd}
	ontouchmove={handleTouchMove}
	role="tooltip"
	aria-describedby={tooltipId}
>
	<slot />
</div>

<svelte:window
	onkeydown={(e) => {
		if (visible && e.key === 'Escape') {
			hide();
		}
	}}
/>
