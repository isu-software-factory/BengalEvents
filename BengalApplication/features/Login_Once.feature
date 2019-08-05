
  Feature: Complete login process without having to login more than once.
    As a user of the system I can complete
    the process without having to login more
    than once.


    Scenario: Coordinator goes to create an occasion page without having to login again
      Given Coordinator is already signed in and goes to occasions page
      When Coordinator clicks to create a new occasion
      Then Coordinator is redirected to create an occasion without having to login


    Scenario: Sponsor goes to create an event page without having to login again
      Given Sponsor is already signed in and goes to occasions page
      When Sponsor clicks to create an event
      Then Sponsor is redirected to create an event without having to login


    Scenario: Teacher goes to registration page without having to login again
      Given Teacher is already signed in
      When Teacher clicks registration link
      Then Teacher is redirected to register without having to login


    Scenario: Student goes to registration page without having to login again
      Given Student is already signed in
      When Student clicks registration link
      Then Student is redirected to register without having to login







