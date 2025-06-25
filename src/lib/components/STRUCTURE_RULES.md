# Structure Rules for LIFT Passport <!-- omit from toc -->

- [Region Elements](#region-elements)
  - [`<header>`](#header)
  - [`<nav>`](#nav)
  - [`<main>`](#main)
  - [`<footer>`](#footer)
  - [`<section>`](#section)
- [Typographic Elements](#typographic-elements)
  - [`<h1>` to `<h6>`](#h1-to-h6)

## Region Elements

### `<header>`

The app has one header element, called directly by `./+layout.svelte`

### `<nav>`

Avoid using this.

### `<main>`

The app has one main element, called directly by `./+layout.svelte` as the parent element of `./+page.svelte`.

This means that all components, except for those in `<Header/>` and `<Footer/>`, are inside a `<main>` element.

### `<footer>`

The app has one footer element, called directly by `./+layout.svelte`

### `<section>`

Where appropriate, use this instead of `<div>`. As a guide, the presence of an `<h*>` element implies that the container it labels is a valid `<section>`.

---

## Typographic Elements

### `<h1>` to `<h6>`

These elements should be used systematically in the following way:

|    Element     | Usage                                                                      |
| :------------: | :------------------------------------------------------------------------- |
|     `<h1>`     | The whole app should have one single h1 in the header element              |
|     `<h2>`     | These are view-level headers: Dashboard, List Titles, Question Card titles |
| `<h3>`, `<h4>` | These are available for use within components                              |
| `<h5>`, `<h6>` | Avoid                                                                      |
