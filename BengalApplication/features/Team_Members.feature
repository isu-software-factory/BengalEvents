
  Feature: Team can register max of 4 and min of 2
    As a team we can register a maximum of 4 and
    a minimum of 2 team members.



    Scenario: Invited 4 members join team
      Given Team lead is at invite team page
      When Team lead fills out emails and sends invites
      And  Members click join link
      Then Team will have 4 members

    Scenario: Invited 5 members to join team
      Given Team lead invites four members
      And Team lead goes to invite team page
      When Team lead fills out one email and sends invite
      And Member clicks join link
      Then Member will not be a part of team

    Scenario: Team lead doesn't invite members
      Given Team lead is the only member
      Then Team lead will not see register for events link
