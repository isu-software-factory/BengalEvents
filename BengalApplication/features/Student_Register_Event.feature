
  Feature: Student can register to participate in events
    As a student I can register with the event system so
    tt I can participate in events.



    Scenario: Student register for an event
      Given Student is logged in and is at student page
      When Student clicks Register for Events
      And clicks an occasion
      And clicks Register for an event detail
      Then Student will be registered for that event
      And will be redirected to student page
