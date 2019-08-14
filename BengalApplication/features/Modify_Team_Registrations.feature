
  Feature: Modify team's registration details
    As a team lead, I can modify my team's registration
    details (add/drop members, change schedule).



    Scenario: Team lead drops members
      Given Team lead is at team page
      When Team lead clicks drop button by member info
      Then Team will have one less member


    Scenario: Team lead drops an event for team
      Given Team lead is at team page and team is registered for an event
      When Team lead clicks drop button by event info
      Then Team will have one less event registered
