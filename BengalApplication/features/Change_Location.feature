
  Feature: Change the location of every event sessions simultaneously
    As an event coordinator I can change the location of an event,
    which then changes the location for all event sessions simultaneously.


    Scenario: Change location of an event
      Given Sponsor is at event edit page
      When Sponsor selects a different location
      Then The location of every event time slot will have the same location
