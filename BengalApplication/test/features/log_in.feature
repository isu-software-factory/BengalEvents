Feature: User logs into BengalApplication
  Admin will log in
  Teacher will log in
  Student will log in
  Activities coordinator will log in

  Scenario Outline: User will log in
    Given User enters their <username> and <password>
    When User clicks the submit button
    Then User will recieve a <answer> notification back


    Examples:
      |username | password | answer           |
      | "admin" | "admin"  | "Access Granted" |
      | "anyone"| "23lass" | "Access Denied"  |
