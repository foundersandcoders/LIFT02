## Overview

Implement email preview functionality with actions display and standardize action service type handling. This PR adds structured email generation with JSON-based rendering and ensures consistent type conversion across all action database operations.

---

## TL;DR

- Email preview now displays actions below Q&A pairs
- All action service functions return consistent tableMain types
- No breaking changes for existing code

---

## Gallery

Email preview now shows structured content with actions:
- Category headers with brand styling (teal background)
- Q&A pairs with clear visual hierarchy
- Action items listed below relevant responses with status indicators

---

## Changes

**Email System (`emailBuilder.ts`, `email.ts`)**

Implemented JSON-based email generation system
- Created EmailData interfaces for structured email content
- Added `generateEmailData()` function to create JSON object from user responses
- Added `renderEmailToHTML()` function to convert JSON to styled HTML
- Integrated action fetching and display in email preview
- Applied brand colors (primary, secondary, accent) throughout email styling

**Actions Service (`actions.ts`)**

Standardized type conversion for all action functions
- Added database to tableMain type conversion for `getUserActions`
- Added database to tableMain type conversion for `getActionById`
- Added database to tableMain type conversion for `getActionHistory`
- Added database to tableMain type conversion for `createAction`
- Added database to tableMain type conversion for `updateAction`
- Added database to tableMain type conversion for `archiveAction`
- Added database to tableMain type conversion for `getLatestActions`
- Implemented `getActionsByResponseId` function with proper versioning logic

**Utilities (`textTools.ts`)**

Enhanced text processing functions
- Updated `cleanUnderscores` to use `replaceAll` for complete underscore removal
- Improved category name display in email preview

**Email Preview Component (`EmailPreview.svelte`)**

Updated component to use new JSON-based email system
- Replaced plain text rendering with HTML rendering
- Integrated with `generateEmailData` and `renderEmailToHTML` functions

---

## Summary

Like converting a handwritten letter into a professionally formatted document with proper sections, headers, and attachments, this PR transforms the email system from basic text output into a structured, styled communication tool that includes all relevant workplace accommodation information.