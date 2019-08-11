
  Feature: No duplicate registrations for an event
    As a user I cannot register for an event more than
    one ime, such that, there are no duplicate registrations.


    Scenario: Student tries to register for the same event twice
      Given Student is at registration page and has register for "Robotics"
      When Student clicks register for Robotics
      Then Student will see an error and will not be signed up for the event