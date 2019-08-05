
  Feature: Login to access class and student information
    As a teacher I can login to access
    class and student related information.

    # name and email information for now
    Scenario: Teacher sees student information
      Given Teacher is logged in and at teacher page
      Then Teacher will see student's names and email
