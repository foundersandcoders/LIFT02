# Project Brief

## Objective

One of the LIFT programme objectives is a thought leadership output focused on gathering all the insight from the best practice happening across our knowledge economy sectors into a digital resource that can support making these industries more inclusive and accessible.

Since there are a vast number of toolkits which are broad reaching and comprehensive (including the launch of the GLA toolkits). LIFT has decided to zoom in and focus our research into supporting neurodivergent people which is of pertinent interest and priority across our boroughs.

Alot of the resources currently available are pdf and document formatted, often very compliance formatted hence not impacting the day-to-day workplace culture and environment. Whilst larger companies have resources available to dedicate whole teams to diversity and inclusion, SMEs dont have such things available. LIFT therefore wants to tap into our access to larger businesses' resources and make it accessible to SMEs by digitising the work and making it interactive, palatable and useful day-to-day.

In focusing in on supporting neurodivergent people at on-boarding and development stages, we hope the resource can be used and useful to all employees by generally making a more inclusive and adjusted workplace.

## Outline & Brief

To develop a digital version of Islington Councils existing workplace passport, that is accessible to a range of local employers, and provides a more user-friendly format than the existing pdf document. This should take the form of an online form, that provides the user with a downloadable and shareable document once complete. It should be simple, intuitive and fairly self-explanatory. It should also be easy to communicate across changing roles, workplaces and managers.

The user should have a profile and account that they can log into which is secure, and that allows them to review the information on the passport on a continuous basis. They should be able to update the passport as and when is necessary, including when their needs or circumstances change, and also when moving roles or when their line management changes.

While we see this as a tool that employers would encourage new staff to use, the completed passport should be owned by the employee, not the employer.

## Main Function & Deliverables

### User Journey

1. Landing page that has a login
2. Once logged in, the user sees a dashboard that has tiles for the following categories (Dashboard should look similar to the LIFT opportunities portal in appearance):
   a. Profile
   b. Wellness at work
   c. My role as a parent or carer
   d. My religion or beliefs
   e. My experience as someone with a disability or long-term condition
   f. Workplace adjustments and support
   g. Additional information and resources
3. Profile should include basic account details: name, pronouns, job title, line manager, employer, and options to edit these.
4. Categories b-e include the questions as currently exist in the workplace passport, i.e. when the user clicks onto wellness at work, they are presented with the list of questions as they currently appear in the Workwise page
5. When the user clicks on the question, a box pops up which allows them to enter their answer as free text.
6. It is not mandatory for the user to complete each question.
7. Following free text answer to be given an option of follow up actions, to include:
   a. physical sensory environment adjustment
   b. equipment requirements
   c. time travel adjustment
   d. additional resource
   e. work style/ work pattern adjustment
   f. 'Other' > additional free form text
8. When the user assigns an action, it should populate a line in the workplace adjustments and support section, which is a separate category on the dashboard. (we might need to discuss this bit further)
9. Workplace adjustments and support section should bank all the different actions assigned, and give the user the option to add additional lines.
10. Additional information and resources section should have links to further resources we will provide these.
11. The user should be able to share the completed passport questions and workplace adjustments with their manager. This should be sent to the manager by email from the app. They should also be able to download a complete summary of their responses for their own reference. (again we might need to discuss this further)
12. We should include some basic instructions on how to complete the tool somewhere on the dashboard page or a help icon?
13. Can there be some sort of audit trail of when the passport was created, reviewed, updated, and shared?

### Timeline

- Final sprint to completed in 12 developer days / 2 weeks - 2nd half of May
- Need to do user testing after week 1 of second sprint - to get feedback

## User profile

To be used by managers and employers to help on-board and track progress, support and adjust needs of neurodivergent employees.

Neurodivergent and wider employees to communicate their reasonable workplace adjustments, changes in circumstances and needs to their line managers.

To positively impact the workplace environment by establishing a culture of inclusivity, communication and support

### User case 1; someone just starting a new job

A person who is neurodivergent who needs adjustments in lighting and sound levels in work environment. They also are not comfortable disclosing their neurodiversity face to face. At induction the employer would explain that they are subscribed to a service where they can track their feelings about their work environment and contribute to a better workplace for everyone by sharing how they work best, and what optimum conditions would need to be in place.

### User case 2; someone new line manager

User 1 has had their line manager changed. They no longer want to share physical adjustments they need but do want to alert them about social queues, how they like to be communicated with in the mornings and that they dont like to speak at group meetings. They should be able to login, update info on new line manager, change what they can make public or not, and alert their new supervisor in an email. They should be able to add free form text to the email to intro the reason for the email, and add if there any actions or if its just something to be aware of.

### User case 3; new job existing login

Similar to user 2 they would be able to review on their dashboard what they would like to update and make public. They would update their workplace details and manager contacts on the dashboard. They would then be able to email an invitation to their manager to subscribe to and accept email alerts.

## Compliance

- [ ] Touch base with Digital Services DPIA will change
- [ ] DPIA completion
- [ ] WCAG 2.2 AA guidelines compliant
- [ ] Accessibility testing - check in about brand guidelines & accessibility with Alastair
- [ ] Info stored on a Supabase DB
- [ ] Deployed on Vercel
