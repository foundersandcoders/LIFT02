<script lang="ts">
	import { generateUniqueId } from '$lib/utils/random';
	import { onMount, tick, untrack } from 'svelte';
	import type { Snippet } from 'svelte';

	interface Props {
		text: string;
		position?:
			| 'top'
			| 'bottom'
			| 'left'
			| 'right'
			| 'top_left'
			| 'top_right'
			| 'bottom_left'
			| 'bottom_right';
		children: Snippet;
		longPressDelay?: number; // Mobile long press delay in ms
		hideDelay?: number; // Desktop hide delay in ms
		autoHideDelay?: number; // Mobile auto-hide delay in ms
		showDelay?: number; // Desktop show delay in ms (optional)
	}

	let {
		text,
		position = 'top',
		children,
		longPressDelay = 500,
		hideDelay = 300,
		autoHideDelay = 3000,
		showDelay = 300
	}: Props = $props();

	const tooltipId = generateUniqueId('tooltip');
	let visible = $state(false);
	let mounted = $state(false);
	let touchDevice = $state(false); // Track if touch was used
	let longPressTimer: ReturnType<typeof setTimeout> | undefined;
	let hideTimer: ReturnType<typeof setTimeout> | undefined;
	let showTimer: ReturnType<typeof setTimeout> | undefined;
	let actualPosition = $state(position);
	let tooltipElement = $state<HTMLDivElement>();

	// Initialize component with proper cleanup
	onMount(() => {
		mounted = true;
		return () => {
			// Cleanup all timers on unmount
			clearTimeout(longPressTimer);
			clearTimeout(hideTimer);
			clearTimeout(showTimer);
		};
	});

	const adjustPosition = (element: HTMLDivElement) => {
		if (!element) return;

		const rect = element.getBoundingClientRect();
		const viewport = {
			width: window.innerWidth,
			height: window.innerHeight
		};

		let newPosition = position;

		// Get trigger element position for smart alignment
		const triggerRect = element.parentElement?.getBoundingClientRect();
		const isInHeader = triggerRect && triggerRect.top < 100;

		// Handle corner positions
		if (position.includes('_')) {
			// Corner positions don't need adjustment logic
			newPosition = position;
		} else if (position === 'bottom' || position === 'top') {
			// For all elements, use smart horizontal positioning or convert to corner positions
			if (rect.right > viewport.width - 10) {
				// Use corner position instead of adjustment
				newPosition = position === 'bottom' ? 'bottom_right' : 'top_right';
			} else if (rect.left < 10) {
				// Use corner position instead of adjustment
				newPosition = position === 'bottom' ? 'bottom_left' : 'top_left';
			} else {
				// Normal centering for positions with enough space
				if (isInHeader && position === 'top') {
					newPosition = 'bottom';
				} else {
					newPosition = position;
				}
			}

			// For header elements, prefer bottom positions
			if (isInHeader) {
				if (newPosition === 'top') newPosition = 'bottom';
				else if (newPosition === 'top_left') newPosition = 'bottom_left';
				else if (newPosition === 'top_right') newPosition = 'bottom_right';
			}
		}

		// Check vertical overflow
		if (rect.bottom > viewport.height - 10) {
			newPosition = 'top';
		}

		if (rect.top < 10 && !isInHeader) {
			newPosition = 'bottom';
		}

		actualPosition = newPosition;
	};

	const show = async () => {
		if (!mounted) return;
		
		clearTimeout(hideTimer);
		clearTimeout(showTimer);
		
		untrack(() => {
			visible = true;
		});

		// Wait for DOM update before adjusting position
		await tick();
		if (tooltipElement) {
			adjustPosition(tooltipElement);
		}
	};

	const hide = () => {
		if (!mounted) return;
		
		clearTimeout(longPressTimer);
		clearTimeout(showTimer);
		
		untrack(() => {
			visible = false;
			actualPosition = position; // Reset to original position
		});
	};

	const scheduleShow = (delay: number = showDelay) => {
		if (!mounted) return;
		
		clearTimeout(hideTimer);
		if (delay > 0) {
			showTimer = setTimeout(show, delay);
		} else {
			show();
		}
	};

	const handleMouseEnter = () => {
		// Don't show on mouse events if touch was used
		if (touchDevice) return;
		scheduleShow();
	};

	const handleMouseLeave = () => {
		// Don't hide on mouse events if touch was used
		if (touchDevice) return;
		scheduleHide();
	};

	const scheduleHide = (delay: number = hideDelay) => {
		if (!mounted) return;
		
		clearTimeout(hideTimer);
		clearTimeout(showTimer);
		hideTimer = setTimeout(hide, delay);
	};

	const handleTouchStart = () => {
		if (!mounted) return;
		
		touchDevice = true; // Mark as touch device
		clearTimeout(hideTimer);
		longPressTimer = setTimeout(() => {
			show();
			// Auto-hide after configured delay on mobile
			scheduleHide(autoHideDelay);
		}, longPressDelay);
	};

	const handleTouchEnd = () => {
		clearTimeout(longPressTimer);
		if (!visible) {
			hide(); // Only hide if tooltip wasn't shown yet
		}
	};

	const handleTouchMove = () => {
		clearTimeout(longPressTimer);
	};

	// Reactive cleanup effect for state changes
	$effect(() => {
		// This effect runs when visible state changes
		if (visible && tooltipElement) {
			// Ensure position is adjusted when tooltip becomes visible
			tick().then(() => {
				if (tooltipElement) {
					adjustPosition(tooltipElement);
				}
			});
		}
	});
</script>

<div
	class="relative inline-block"
	onmouseenter={handleMouseEnter}
	onmouseleave={handleMouseLeave}
	onfocus={() => !touchDevice && scheduleShow()}
	onblur={() => !touchDevice && scheduleHide()}
	ontouchstart={handleTouchStart}
	ontouchend={handleTouchEnd}
	ontouchmove={handleTouchMove}
	aria-describedby={visible ? tooltipId : undefined}
	role="button"
	tabindex="0"
>
	{@render children()}

	{#if visible}
		<div
			bind:this={tooltipElement}
			id={tooltipId}
			role="tooltip"
			aria-live="polite"
			class="pointer-events-none absolute z-[100] max-w-sm min-w-48 rounded-lg border border-gray-300 bg-white px-4 py-3 text-sm
				leading-relaxed text-gray-800 shadow-xl
				{actualPosition === 'top' ? 'bottom-full left-1/2 mb-2 -translate-x-1/2 transform' : ''}
				{actualPosition === 'bottom' ? 'top-full left-1/2 mt-2 -translate-x-1/2 transform' : ''}
				{actualPosition === 'left' ? 'top-1/2 right-full mr-2 -translate-y-1/2 transform' : ''}
				{actualPosition === 'right' ? 'top-1/2 left-full ml-2 -translate-y-1/2 transform' : ''}
				{actualPosition === 'top_left' ? 'right-0 bottom-full mb-2' : ''}
				{actualPosition === 'top_right' ? 'bottom-full left-0 mb-2' : ''}
				{actualPosition === 'bottom_left' ? 'top-full right-0 mt-2' : ''}
				{actualPosition === 'bottom_right' ? 'top-full left-0 mt-2' : ''}"
		>
			<span class="block">{text}</span>
			<!-- Arrow -->
			<div
				class="absolute
				{actualPosition === 'top' ? 'top-full left-1/2 -translate-x-1/2 transform' : ''}
				{actualPosition === 'bottom' ? 'bottom-full left-1/2 -translate-x-1/2 transform' : ''}
				{actualPosition === 'left' ? 'top-1/2 left-full -translate-y-1/2 transform' : ''}
				{actualPosition === 'right' ? 'top-1/2 right-full -translate-y-1/2 transform' : ''}
				{actualPosition === 'top_left' ? 'top-full right-4' : ''}
				{actualPosition === 'top_right' ? 'top-full left-4' : ''}
				{actualPosition === 'bottom_left' ? 'right-4 bottom-full' : ''}
				{actualPosition === 'bottom_right' ? 'bottom-full left-4' : ''}"
			>
				<!-- Arrow triangle -->
				<div
					class="
					{actualPosition === 'top' || actualPosition === 'top_left' || actualPosition === 'top_right'
						? 'border-t-[6px] border-r-[6px] border-l-[6px] border-transparent border-t-white'
						: ''}
					{actualPosition === 'bottom' ||
					actualPosition === 'bottom_left' ||
					actualPosition === 'bottom_right'
						? 'border-r-[6px] border-b-[6px] border-l-[6px] border-transparent border-b-white'
						: ''}
					{actualPosition === 'left'
						? 'border-t-[6px] border-b-[6px] border-l-[6px] border-transparent border-l-white'
						: ''}
					{actualPosition === 'right'
						? 'border-t-[6px] border-r-[6px] border-b-[6px] border-transparent border-r-white'
						: ''}"
				></div>
				<!-- Arrow border -->
				<div
					class="absolute
					{actualPosition === 'top' || actualPosition === 'top_left' || actualPosition === 'top_right'
						? '-top-[1px] left-1/2 -translate-x-1/2 transform border-t-[6px] border-r-[6px] border-l-[6px] border-transparent border-t-gray-300'
						: ''}
					{actualPosition === 'bottom' ||
					actualPosition === 'bottom_left' ||
					actualPosition === 'bottom_right'
						? '-bottom-[1px] left-1/2 -translate-x-1/2 transform border-r-[6px] border-b-[6px] border-l-[6px] border-transparent border-b-gray-300'
						: ''}
					{actualPosition === 'left'
						? 'top-1/2 -left-[1px] -translate-y-1/2 transform border-t-[6px] border-b-[6px] border-l-[6px] border-transparent border-l-gray-300'
						: ''}
					{actualPosition === 'right'
						? 'top-1/2 -right-[1px] -translate-y-1/2 transform border-t-[6px] border-r-[6px] border-b-[6px] border-transparent border-r-gray-300'
						: ''}"
				></div>
			</div>
		</div>
	{/if}
</div>

<svelte:window
	onkeydown={(e) => {
		if (visible && e.key === 'Escape') {
			hide();
		}
	}}
/>
