
  Feature: Teacher can register for the event to participate
    As a teacher I can register for the even
    so that I can participate and my students can
    participate.


    Scenario: Teacher registers for an event
      Given Teacher clicks registration link on teacher page
      Given Teacher clicks on an occasion
      When Teacher clicks register on an event detail
      Then Teacher will be registered for that event detail
      And Will be redirected to their teacher page

