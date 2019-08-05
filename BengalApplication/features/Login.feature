Feature: Login as a user.
  User can login to use the system


  Scenario: Teacher logs in
    Given Teacher has account created and is at login page
    When Teacher enters login credentials and clicks log in button
    Then Teacher logs in successfully


  Scenario: Student logs in
    Given Student has account created and is at login page
    When Student enters login credentials and clicks log in button
    Then Student logs in successfully


  Scenario: Sponsor logs in
    Given Sponsor has account created and is at login page
    When Sponsor enters login credentials and clicks log in button
    Then Sponsor logs in successfully


  Scenario: Coordinator logs in
    Given Coordinator has account created and is at login page
    When Coordinator enters login credentials and clicks log in button
    Then Coordinator logs in successfully
