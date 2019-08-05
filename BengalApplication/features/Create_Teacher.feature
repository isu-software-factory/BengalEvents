
  Feature: Create account for teachers and fill in the information
    As a teacher, I create my account and provide the
    system with my name, school name, email, number of
    chaperones, and number of expected students.



    Scenario: Create a teacher account
      Given Teacher is a home page
      When Teacher clicks sign up as a teacher
      And Fills out information and clicks confirm
      Then Teacher will be redirected to teacher page