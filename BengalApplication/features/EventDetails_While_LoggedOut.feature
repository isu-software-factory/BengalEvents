
  Feature: Retrieve event details without logging in
    As a user, I can retrieve event details without having to login


    Scenario: See EventDetails while not logged in
      Given User is at home page without being logged in
      Then User can see EventDetails