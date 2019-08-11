
Feature: Create a team
  as a student and assign team lead


  Scenario: Student creates a new team
    Given Student is logged in and at student page
    And clicks create team link
    When Student enters "Tigers" for team name and clicks create button
    Then Student will be directed to their team page
    And Student will be the team lead
