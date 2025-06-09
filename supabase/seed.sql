-- Seed data for questions table
-- This file populates the questions table with initial data

INSERT INTO questions (category, question_text, "order", preview) VALUES
  ('my_wellbeing', 'Is there anything either inside or outside of work that may affect your wellbeing, that you think we should know about?', 1, 'External Wellbeing Factors'),
  ('my_wellbeing', 'Please describe how you are when you are having a good day.', 2, 'On a Good Day'),
  ('my_wellbeing', 'Please describe how you are when you are having a bad, or not-so-good day. Sometimes people mask what''s really going on for them, so this may be things not visible to others.', 3, 'On a Bad Day'),
  ('my_wellbeing', 'If things are not going so well, are you aware of any early warning signs that would be useful for us to learn? What action can we take when we recognise your early warning signs? Please include how you would like us to approach and raise this with you, along with what we can and cannot do to help or support you.', 4, 'Early Warning Signals'),
  ('my_wellbeing', 'The following symptoms are indications that I am not well enough to be at work', 5, 'Symptoms I Experience'),
  ('my_responsibilities', 'Do you have any parental or caring responsibilities that you think it would be helpful for us to know about?', 6, 'My Parental & Caring Responsibilities'),
  ('my_responsibilities', 'What arrangements or support do you need from us to fulfil your role as parent or carer? This may include looking after your own wellbeing as well as that of the person you are a parent or carer for.', 7, 'Supporting My Parental & Caring Responsibilities'),
  ('my_religion', 'Are there any arrangements or support you need from us which will enable you to take part in any religious practices? This may include space to pray or holidays you observe.', 8, 'My Religious Practices'),
  ('my_religion', 'Is there anything else you think would be helpful for us to know about your religion or belief? This may include dietary needs for work events.', 9, 'Other Religious Requirements'),
  ('my_conditions', 'Use this space to give a brief description of the impact your disability or long-term condition may have at work. You may need to split this up if you have multiple conditions.', 10, 'My Disability or Long-Term Condition'),
  ('my_conditions', 'Are there any barriers which are impacting on your ability to perform in your job?', 11, 'Current Barriers'),
  ('my_support_needs', 'Share the information about your work needs that would be helpful for your colleagues.', 12, 'What I Need'),
  ('my_support_needs', 'What do you need to thrive in your role here at Islington? There is space in the next section to outline specific workplace adjustments.', 13, 'My Workplace Adjustments'),
  ('about_me', 'Is there anything you think would be helpful for your colleagues to know? How should this be shared?', 14, 'Things to Know About Me');