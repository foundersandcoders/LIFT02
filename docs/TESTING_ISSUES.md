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
- [ ] **Status**: Not started
- **Description**: When on the dashboard page, 'Dashboard' in breadcrumb should be bold, not underlined, and not clickable, because it is the current page the user is on.
- **Location**: Dashboard
- **Files affected**: TBD

---

### Issue #4 - Button hover effects
- [ ] **Status**: Not started
- **Description**: Each button should have a hover effect. It can be thicker border.
- **Location**: Dashboard
- **Files affected**: TBD

---

### Issue #5 - Back button position
- [ ] **Status**: Not started
- **Description**: The 'back' button should be on the left side of the breadcrumb, on the same line.
- **Location**: All pages
- **Files affected**: TBD

---

### Issue #6 - Action status terminology
- [ ] **Status**: Not started
- **Description**: It is not intuitive to use 'active' and 'inactive' to describe actions. Using 'to do' and 'done' should be clearer. So the toggle module can be: [Link button] To do [toggle] Done. At the same time, the 'Show Inactive' toggle at the top should change to 'Show done actions'.
- **Location**: Actions
- **Files affected**: TBD

---

### Issue #8 - Page title
- [ ] **Status**: Not started
- **Description**: The website should have a proper page title as displayed in the browser tab.
- **Location**: All pages
- **Files affected**: TBD

---

### Issue #9 - Save button text
- [ ] **Status**: Not started
- **Description**: The OK button should have text 'Save' instead.
- **Location**: All forms
- **Files affected**: TBD

---

### Issue #10 - Save confirmation
- [ ] **Status**: Not started
- **Description**: After editing and saving a field, there should be a confirmation message to let users know the changes have been saved.
- **Location**: All forms
- **Files affected**: TBD

---

### Issue #11 - Visibility text styling
- [ ] **Status**: Not started
- **Description**: This line of text should be black instead of grey and it misses a full stop: 'Visibility to employer. This answer and actions will be included on the email'
- **Location**: All forms
- **Files affected**: TBD

---

### Issue #12 - Mobile saved message overlap
- [ ] **Status**: Not started
- **Description**: When switching the 'Visibility to employer' toggle on mobile, 'Saved' message overlaps with section heading.
- **Location**: All forms
- **Files affected**: TBD

---

### Issue #13 - Email preview hover effects
- [ ] **Status**: Not started
- **Description**: When sending an email to the manager, in the email preview, actions fields should not have hover effect as they are not editable.
- **Location**: Email Preview
- **Files affected**: TBD

---

### Issue #14 - Email button on email preview
- [ ] **Status**: Not started
- **Description**: On the email preview page, the email button at the top-right corner in the header should not be translucent. It should be removed on this page.
- **Location**: Email Preview
- **Files affected**: TBD

---

### Issue #17 - Replace ampersands
- [ ] **Status**: Not started
- **Description**: Please replace all ampersands with 'and' in full
- **Location**: All pages
- **Files affected**: TBD

---

### Issue #18 - Remove italics
- [ ] **Status**: Not started
- **Description**: Remove all use of italics across the site
- **Location**: All pages
- **Files affected**: TBD

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
- **Completed**: 2
- **Remaining**: 15
