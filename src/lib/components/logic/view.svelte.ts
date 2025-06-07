import type { View } from "$lib/types/ui";

let view = $state<View>("dash");

export function setView(newView: View) {
  view = newView;
};

export function getView(): View {
  return view;
}