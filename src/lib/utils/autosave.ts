/**
 * Simple autosave utilities
 */

// Simple debounce function
export function debounce(func: () => void, delay: number) {
	let timeoutId: ReturnType<typeof setTimeout>;

	return () => {
		clearTimeout(timeoutId);
		timeoutId = setTimeout(func, delay);
	};
}

// Create simple undo stack for text content
export function createUndoStack() {
	let history: string[] = [];
	let currentIndex = -1;

	function push(content: string) {
		// Remove any future history if we're in the middle
		if (currentIndex < history.length - 1) {
			history = history.slice(0, currentIndex + 1);
		}

		// Add new content
		history.push(content);

		// Keep only last 10 entries
		if (history.length > 10) {
			history = history.slice(-10);
		}

		currentIndex = history.length - 1;
	}

	function undo(): string | null {
		if (currentIndex > 0) {
			currentIndex--;
			return history[currentIndex];
		}
		return null;
	}

	function canUndo(): boolean {
		return currentIndex > 0;
	}

	function clear() {
		history = [];
		currentIndex = -1;
	}

	return { push, undo, canUndo, clear };
}