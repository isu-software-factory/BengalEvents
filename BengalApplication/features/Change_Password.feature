

  Feature: Change password while logged in
    As a user who is logged in, I can change my password


    Scenario Outline: User changes password
      Given User "<user_type>" is logged in with "<email>" and "<password1>"
      When User clicks their "<email>"
      And Fills in password field with "<password1>" and "<password2>"
      Then User password will change to "<password2>"


    Examples:
      | user_type   | email             | password1     | password2       |
      | Teacher     | teacher@gmail.com | teachpassword | teacherpassword |
      | Student     | student@gmail.com | stupassword   | studentpassword |
      | Sponsor     | sponsor@gmail.com | sponpassword  | sponsorpassword |
      | Coordinator | coordi@gmail.com  | coordpassword | coordinatorpass |
