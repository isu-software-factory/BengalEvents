
  Feature: Team registration decreases the overall capacity of the event
    As a team registering for an event the size of my team will
    decrease the overall capacity of the event upon successful
    registration.



    Scenario: Team lead registers team for an event
      Given Team member count is two and Event capacity is 10
      And Team lead is at registration page
      When Team lead clicks on register link of an event
      Then Event capacity will be 8