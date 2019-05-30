## Stakeholders
 - User
   - Student
   - Teacher
   - Team (Group of Users)
 - Sponsor
   - Student Organization
   - Academic Program
   - Business
 - Event Coordinator
 - Developer

## User Stories

### Login - High

1. As a user of the system I can complete the process without having to login more than once. Story Points: 2
2. As a user I can login so that I can use the system - Priority 0, Story Points: 3

### Account Management - Medium

1. As a user who can login, I can request to change my password so that if I forget I have the ability to continue using the service Story Points: 3
2. As a user who can login, I can request my username or password be sent to me in the case that I have forgot Story Points: 3

### User Settings
1. As a user who is logged in, I can change my password. Story Points: 1


### Group Management - High

1. As a teacher, who is logged in, I have the ability to print a list of my registered students - Priority 1 Story Points: 2
2. As a teacher I can login to access class and student related information - Priority 1 Story Points: 1
3. As a teacher who is logged in, I have the ability to display the schedules of each my registered students - Priority 1 Story Points:2
4. As a teacher, who is logged in, I have the ability to display student schedules as a whole class - Priority 1 Story Points: 2
5. As a teacher, who is logged in, I have the ability to print individual student schedules - Priority 2 Story Points: 2
6. As a teacher, who is logged in, I can view a summary of my class and each student's status - Priority 1 Story Points: 5?
7. As a team member I can access team and team member related information - Priority 2 Story Points: 1
8. As a team member who is logged in, I have the ability to print a list of my registered team members - Priority 2 Story Points: 1
9. As a team member who is logged in, I have the ability to display the team's schedule - Priority 2 Story Points: 2
10. As a team member who is logged in, I have the ability to print the team's schedule - Priority 2 Story Points: 1
11. As a student who is logged in, I can create a team, becoming the team lead. Priority 2 Story Points: 3
12. As a team lead, I can modify my team's registration details (add/drop members, change schedule) - Priority 2 Story Points: 8

### Events Management - High

1. As a user I can see an event summary page which shows the contact info, number of students registered, number of sessions for each event, total capacity of each event, and event location so that I may be well informed. - Priority 1 Story Points: 3
2. As a user I can print the event summary page so that I may have a hard copy - Priority 2 Story Points: 1
3. As a user, I can retrieve event details without having to login. - Priority 1 Story Points: 1
4. As a teacher, who is logged in, I can print a check-in list for my students. - Priority 2 Story Points: 3
5. As a sponsor, who is logged in, I can create a new event associated with my organization - Priority 0 Story Points: 8
6. As a sponsor, who is logged in, I can delete or modify an existing event associated with my organization - Priority 5
7. As a team when registering for an event, we only use a single slot as to allow for maximal event registration - Priority 2 Story Points: 1
8. As a team registering for an event the size of my team will decrease the overall capacity of the event upon successful registration - Priority 2 Story Points:1
9. As a User I cannot register for an event more than one time, such that, there are no duplicate registrations - Priority 1 Story Points: 1
10. As an event coordinator I can change the location of an event, which then changes the location for all event sessions simultaneously - Priority 1 Story Points: 1
11. As an event coordinator I can assign event locations and no event is to be co-located with another at the same time. - Priority 1 Story Points: 3

### Registration - High

1. As a teacher I can register for the event so that I can participate and my students can participate. - Priority 2 Story Points: 5
2. As a teacher, I create my account and provide the system with my name, school name, phone number, email, number of chaperones, and number of expected students. - Priority 0 Story Points: 3
3. As a teacher, who is logged in, I add each student who will be participating in events. - Priority 1 Story Points: 5
4. As a student I can join the waitlist for an over capacity event so that I can join later when there is space. - Priority 3 Story Points: 1
5. As a student I can register with the event system so that I can participate in events - Priority 1 Story Points: 2
//As a student I can register for an event session using a provided link connected to my teachers account. - Priority 2//Not needed?//
6. As a sponsor, I can register as an event sponsor so that I may create and edit events. - Priority 1 Story Points: 3
7. As a team we can register on the site in order to later login and register for events - Priority 2 Story Points: 2
8. As a team we can register a maximum of 4 and a minimum of 2 team members. - Priority 2 Story Points: 1

### Reminders - Medium

1. As a student when I register for a "make-ahead" activity, a reminder is shown at registration time to indicate that this activity requires me to prepare my entry prior to attending the event. - Priority 3 Story Points: 1
2. As a student registered for a "make-ahead" activity, I expect a reminder (via email) of the requirements to prepare my entry at least one week prior to the activity. - Priority 3 Story Points: 2

### System Administration - Medium

1. As a developer I should be able to deploy to the server with a simple command at the command line without causing downtime - Priority 2 Story Points: 1
3. As a developer I should be capable of testing the system with a single command. - Priority 2 Story Points: 5

# Product Quality Concerns

- Maintainability
  * Modularity
  * Reusability
  * Analysability
  * Modifiability
  * Testability

  * There will be a need to extend this system beyond Bengal STEM day
  * There will be a need for this system to be maintained by multiple teams over the years
- Security
  * We need to ensure that user information is not capable of being exposed to others
  * We need to ensure that XSS and CRSF vulnerabilities are not threats
- Portability
  * Adaptability
  * Installability
  * Replaceability
- Usability
  * User Error Protection
  * User Interface Aesthetics
  * Accessibility
- Functional Suitability
  * Functional Completeness
  * Functional Correctness
  * Functional Appropriateness
- Reliability
  * Availability
  * Fault Tolerance
  * Recoverability
- Performance Efficiency
  * Time Behavior
  * Resource Utilization
  * Capacity
- Compatibility
- Portability
  * Adaptability
  * Installability
  * Replaceability

# Quality In Use Concerns

- Satisfaction
  * Usefulness
  * Trust
  * Pleasure
  * Comfort
- Effectiveness
- Freedom from Risk
  * Economic Risk Mitigation
  * Health and Safety Risk Mitigation
  * Environmental Risk Mitigation
- Efficiency
- Context Coverage
  * Context Completeness
  * Flexibility
