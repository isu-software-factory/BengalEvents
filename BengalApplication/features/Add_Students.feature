
  Feature: Add students who will be participating
    As a teacher, who is logged in, I add
    each student who will be participating
    in events.


    Scenario: Teacher adds students
      Given Teacher is logged in
      When Teacher clicks Add students
      And Teacher fills out student information and clicks Add Student
      Then Student account will be created