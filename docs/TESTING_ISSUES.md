# LIFT Workwise Testing Issue Log

Track testing issues and their resolution status. Work through these one by one, committing after each fix.

## Issues

### Issue #1 - Logo hover effect
- [x] **Status**: ✅ Fixed
- **Description**: The LIFT logo in the header should not have a hover effect and should not appear translucent.
- **Location**: Header
- **Files affected**: `src/lib/components/layouts/Header.svelte` (line 116)
- **Solution**: Removed `hover:opacity-80`, `transition-opacity`, and `cursor-pointer` classes from logo button

---

### Issue #2 - Icon hover effects
- [x] **Status**: ✅ Fixed
- **Description**: The icons in these four buttons should have a visible hover effect: generate an email summary, get help, font size settings, profile settings. Previously they had a white background that made icons disappear.
- **Location**: All pages (header and footer)
- **Files affected**:
  - `src/lib/components/layouts/Header.svelte` (email button - line 161, 169)
  - `src/lib/components/ui/HelpButton.svelte` (help button - line 92)
  - `src/lib/components/ui/FontSizeControl.svelte` (font size button - line 98, 102)
  - `src/lib/components/ui/ProfileButton.svelte` (profile button - line 28, 32)
- **Solution**: Removed white background hover effect and added 25% scale zoom on icon/text only (not border) using `transition-transform hover:scale-125` and `group-hover:scale-125`

---

### Issue #3 - Dashboard breadcrumb styling
- [x] **Status**: ✅ Fixed
- **Description**: When on the dashboard page, 'Dashboard' in breadcrumb should be bold, not underlined, and not clickable, because it is the current page the user is on.
- **Location**: Dashboard
- **Files affected**: `src/lib/components/ui/Breadcrumb.svelte` (line 105-109)
- **Solution**: Changed Dashboard breadcrumb item to be non-clickable (`clickable: false`) when current view is dashboard. The existing CSS already styles non-clickable items as bold without underline using `.breadcrumb-current` class.

---

### Issue #4 - Button hover effects
- [x] **Status**: ✅ Fixed
- **Description**: Each button should have a hover effect. It can be thicker border.
- **Location**: Dashboard and question lists
- **Files affected**: `src/app.css` (lines 89-91, 106, 353)
- **Solution**: Added inset box-shadow on hover to create a thicker border effect that grows inward (doesn't affect layout). Applied to:
  - `.dash-tile-rect` (2px inset)
  - `.dash-tile-square` (2px inset combined with existing shadow)
  - `.list-item-questions` (2px inset combined with existing shadow)

---

### Issue #5 - Back button position
- [ ] **Status**: ❌ Not implemented - breaks layout
- **Description**: The 'back' button should be on the left side of the breadcrumb, on the same line. Remove the icon, only text "back"
- **Location**: All pages
- **Files affected**: N/A
- **Reason not implemented**: Moving the back button to the left side of the breadcrumb breaks all the style logic. The current grid layout has the breadcrumb on the left and back button on the right, which is intentional for the overall design system.

---

### Issue #6 - Action status terminology
- [x] **Status**: ✅ Fixed
- **Description**: It is not intuitive to use 'active' and 'inactive' to describe actions. Using 'to do' and 'done' should be clearer. So the toggle module can be: [Link button] To do [toggle] Done. At the same time, the 'Show Inactive' toggle at the top should change to 'Show done actions'.
- **Location**: Actions
- **Files affected**:
  - `src/lib/components/ui/ActionStatusToggle.svelte` (lines 17, 24)
  - `src/lib/components/ui/ShowArchivedToggle.svelte` (line 14)
- **Solution**: Added static labels "To do" and "Done" on either side of the toggle switch. Changed "Show Inactive" to "Show done actions" in the filter toggle. Layout: [Link button] To do [toggle] Done

---

### Issue #8 - Page title
- [x] **Status**: ✅ Fixed
- **Description**: The website should have a proper page title as displayed in the browser tab.
- **Location**: All pages
- **Files affected**: `src/app.html` (line 7)
- **Solution**: Added `<title>LIFT Workwise</title>` to the HTML head in app.html

---

### Issue #9 - Save button text
- [x] **Status**: ✅ Fixed
- **Description**: The OK button should have text 'Save' instead.
- **Location**: All forms
- **Files affected**: `src/lib/components/cards/QuestionCard.svelte` (lines 239, 310)
- **Solution**: Changed button text from "OK" to "Save" in QuestionCard component. Also updated comment reference to "Save button".

---

### Issue #10 - Save confirmation
- [x] **Status**: ✅ Fixed
- **Description**: After editing and saving a field, there should be a confirmation message to let users know the changes have been saved.
- **Location**: All forms
- **Files affected**: `src/lib/components/cards/QuestionCard.svelte` (lines 105, 232, 329-331)
- **Solution**: Added `saveSuccess` state that shows "Saved" message for 2 seconds after successfully saving response text. Message appears inline next to Save/Undo buttons in green text.

---

### Issue #11 - Visibility text styling
- [x] **Status**: ✅ Fixed
- **Description**: This line of text should be black instead of grey and it misses a full stop: 'Visibility to employer. This answer and actions will be included on the email'
- **Location**: All forms
- **Files affected**: `src/lib/components/ui/ToggleStatus.svelte` (line 16-17)
- **Solution**: Added `text-base-content` class to make text black instead of grey, and added full stop at end of sentence

---

### Issue #12 - Mobile saved message overlap
- [x] **Status**: ✅ Fixed
- **Description**: When switching the 'Visibility to employer' toggle on mobile, 'Saved' message overlaps with section heading.
- **Location**: All forms
- **Files affected**: `src/lib/components/ui/SaveStatus.svelte` (lines 9-22), `src/lib/components/cards/QuestionCard.svelte` (line 286, 293)
- **Solution**: Removed "Saving..." state to eliminate visual flicker. Added `pr-16` padding to heading to reserve space for "Saved" message. Added `z-10` to ensure message appears above heading on mobile.

---

### Issue #13 - Email preview hover effects
- [x] **Status**: ✅ Fixed
- **Description**: When sending an email to the manager, in the email preview, actions fields should not have hover effect as they are not editable.
- **Location**: Email Preview
- **Files affected**: `src/app.css` (lines 538-542)
- **Solution**: Added CSS rule to remove hover effects from `.action-item` elements within `#email-content`, setting `hover:shadow-none` and `cursor: default`

---

### Issue #14 - Email button on email preview
- [x] **Status**: ✅ Fixed
- **Description**: On the email preview page, the email button at the top-right corner in the header should not be translucent. It should be removed on this page.
- **Location**: Email Preview
- **Files affected**: `src/lib/components/layouts/Header.svelte` (line 148)
- **Solution**: Added `!isInEmailView` condition to the email button's `{#if}` block to completely hide it when viewing email preview, and removed `isInEmailView` from the `isDisabled` logic since button is now hidden

---

### Issue #17 - Replace ampersands
- [x] **Status**: ✅ Fixed
- **Description**: Please replace all ampersands with 'and' in full
- **Location**: All pages
- **Files affected**: `src/lib/components/cards/QuestionCard.svelte` (lines 267, 342)
- **Solution**: Replaced "Delete Response & Actions" with "Delete Response and Actions" in both the modal title and button text

---

### Issue #18 - Remove italics
- [x] **Status**: ✅ Fixed
- **Description**: Remove all use of italics across the site
- **Location**: All pages
- **Files affected**:
  - `src/app.css` (line 321)
  - `src/lib/components/ui/FontSizeControl.svelte` (line 107)
  - `src/lib/components/ui/HelpModal.svelte` (line 85)
- **Solution**: Removed `italic` class/styling from action question preview text, font size control icon, and help modal screenshot captions

---

### Issue #20 - Manager actions field text
- [ ] **Status**: Not started
- **Description**: Change the field on manager actions to 'The actions you'd like your manager to take in response to this question.'
- **Location**: All forms
- **Files affected**: TBD

---

### Issue #21 - "Islington" reference
- [ ] **Status**: Not started
- **Description**: In My workplace adjustments, it says 'What do you need to thrive in your role here at Islington?' Is this right, at Islington suggest the council when this is for wider use and I guess this will be available to the other LIFT boroughs?
- **Location**: My workplace adjustments
- **Files affected**: TBD

---

## Progress Summary

- **Total Issues**: 17
- **Completed**: 7
- **Remaining**: 9 (1 rejected - Issue 5)
