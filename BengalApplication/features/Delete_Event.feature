
  Feature: Delete existing event associated within an occasion
    As a sponsor, who is logged in, I can delete
    an existing event associated with an occasion.



    Scenario: Delete an event as a sponsor
      Given Sponsor is logged in and at sponsor page
      When Sponsor clicks go to events
      And Sponsor clicks Show on an Occasion
      And Sponsor clicks Delete on an event
      Then Event will be deleted
      And Sponsor won't have that event

