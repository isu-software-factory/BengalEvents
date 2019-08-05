
  Feature: Register as event sponsor to create and edit events
    As a sponsor, I can register as an event sponsor
    so that I may create and edit events.


    Scenario: Sponsor makes account
      Given Sponsor is at home page and clicks sign up as sponsor
      When Sponsor fills out their information and clicks confirm
      Then Sponsor will be redirected to sponsor page


    Scenario: Sponsor creates an event
      Given Sponsor has account and is signed in
      When Sponsor clicks Go to Events
      And Sponsor clicks Show on an occasion
      And Sponsor clicks Create an event
      And Sponsor fills out Event information and clicks confirm
      Then Sponsor will have an event


      Scenario: Sponsor edits an event
        Given Sponsor has account and event created and is at sponsor page
        And Sponsor goes to occasion page to see events
        When Sponsor clicks edit on their event
        And Sponsor changes event information and clicks confirm
        Then Event will be updated to what the Sponsor edited
