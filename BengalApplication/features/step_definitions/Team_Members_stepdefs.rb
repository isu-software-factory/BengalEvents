

Given("Team lead is at invite team page") do
  # create student, teacher, team,
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  @student = @teacher.students.build(name: "Ben", user_attributes: {email: "ben@gmail.com", password: "password"}, participant_attributes: {})
  @student.save
  @student2 = @teacher.students.build(name: "Bill", user_attributes: {email: "bill@gmail.com", password: "password"}, participant_attributes: {})
  @student2.save
  @student3 = @teacher.students.build(name: "Bob", user_attributes: {email: "bob@gmail.com", password: "password"}, participant_attributes: {})
  @student3.save
  @student4 = @teacher.students.build(name: "sam", user_attributes: {email: "sam@gmail.com", password: "password"}, participant_attributes: {})
  @student4.save
  @team = Team.create(name: "Tigers", lead: @student.id, participant_attributes: {})
  @team.lead = @student.id
  @team.register_member(@student)

  # login and go to team invite page
  login_as(@student.user)
  visit "teams/#{@team.id}/invite"
end

When("Team lead fills out emails and sends invites") do
  within("form") do
    fill_in "email1", with: @student2.user.email
    fill_in "email2", with: @student3.user.email
    fill_in "email3", with: @student4.user.email
  end
  click_button "Invite"
end

When("Members click join link") do
  # open_email(@student2.user.email)
  # current_email.click_link "Join"
  emails = [@student2.user.email, @student3.user.email, @student4.user.email]
  emails.each do |e|
    open_email(e)
    current_email.click_link 'Join'
  end
end

Then("Team will have {int} members") do |max|
  expect(@team.students.count).to eq(max)
end



Given("Team lead invites {int} members") do |int|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("Team lead goes to invite team page") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("Team lead fills out one email and sends invite") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("Member clicks join link") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("Member will not be a part of team") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("Team lead is the only member") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("Team lead will not see register for events link") do
  pending # Write code here that turns the phrase above into concrete actions
end
