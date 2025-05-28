# LIFT Digital Workplace Passport - Functional Specification

## Overview
A digital version of Islington Council's workplace passport to support neurodivergent people in the workplace. This application allows users to document their workplace needs and share them with managers.

## Core Features

### Authentication
- Magic Link authentication via Supabase
- Secure session management with HTTP-only cookies
- Role-based permissions
- Monitoring for suspicious login attempts

### User Profile
- Basic user information: name, pronouns, job title, line manager, employer
- Profile editing capabilities
- Account management

### Dashboard
- Single page view with all categories presented as sections:
  - Profile
  - Wellness at work
  - My role as a parent or carer
  - My religion or beliefs
  - My experience as someone with a disability or long-term health condition
  - Workplace actions and support
  - Additional information and resources
- Navigation between categories via tabs, cards, or scrolling
- Help/instructional elements accessible from dashboard
- Audit trail for passport creation, reviews, updates, and sharing events

### Questionnaire System
- Non-mandatory question answering for each section
- Option to explicitly skip questions
- Free text input for responses
- Response versioning to track changes over time
- Privacy controls for each response (public, private)
- Follow-up action assignment after answers:
  - Physical sensory environment adjustment
  - Equipment requirements
  - Time and travel adjustment
  - Additional resource
  - Work style/pattern adjustment
  - Other (free form text)

### Workplace Actions Management
- Aggregated view of all assigned actions
- Ability to add additional actions manually
- Categorization of actions by type
- Version history for actions to track changes over time

### Sharing with Line Managers
- Email sharing with line manager
- Content includes all visible answers (with questions) and actions
- Complete version history of shared content
- Ability to view exactly what was shared in previous sharing events
- User control over what information is shared through visibility settings
- Option to exclude skipped questions from shared content
- Tracking of which specific versions of responses were shared

### Resources
- Links to additional external resources
- Help documentation

## User Journeys

### New User (User Case 1)
1. User visits landing page and enters email for Magic Link
2. User clicks link in email and is redirected to dashboard
3. User completes profile information
4. User fills out information in various sections on the dashboard
5. User assigns follow-up actions as needed
6. User shares relevant information with manager

### Change of Management (User Case 2)
1. User logs in to existing account
2. User updates line manager information
3. User reviews and updates sharing preferences
4. User initiates sharing with new manager
5. User adds personalized message to sharing email

### Job Change (User Case 3)
1. User logs in to existing account
2. User updates workplace details and manager contacts
3. User reviews previous responses for relevance
4. User updates responses as needed
5. User initiates sharing with new manager

## Technical Requirements

### Compliance
- WCAG 2.2 AA compliance
- DPIA (Data Protection Impact Assessment) compliant
- Secure data handling and storage

### Performance
- Fast page loads (<3s)
- Responsive design for all devices
- Offline capability for form filling

### Security
- Secure authentication
- Data encryption
- Regular security audits

### Testing
- Unit testing with Vitest
- Component testing with @testing-library/svelte
- End-to-end testing with Playwright
- 80% test coverage for critical paths

## Timeline
- Development: 12 developer days / 2 weeks (2nd half of May)
- User testing: After week 1 of development
- Deployment: End of May

## Integrations
- Supabase for data storage and authentication
  - Using environment-specific Supabase projects
  - No local instance required for development
- Email service for sharing functionality
- PDF generation for downloadable summaries

## Future Considerations
- Analytics to track usage patterns
- Enhanced sharing options
- Integration with HR systems