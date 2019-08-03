
Feature: Team can register for events
  As a team we can register on the site in order to later
  login and register for events.


  Scenario: Team lead register team for event
    Given Team lead is in team page
    And Team lead clicks on register link
    And Team lead chooses an occasion
    When Team lead clicks register for event detail
    Then Team is registered for event
    And Team lead is redirected back to team page