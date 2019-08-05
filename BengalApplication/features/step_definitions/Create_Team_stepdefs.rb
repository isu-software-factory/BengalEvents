World(Devise::TestHelpers)
include Warden::Test::Helpers
Given("Student is logged in and at student page") do
  # create teacher and student
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  @student = @teacher.students.build(name: "Ben", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes: {})
  @student.save

  # log in
  login_as(@student.user, :scope => :user)
  visit "students/#{@student.id}"
end

Given("clicks create team link") do
  # click create team
  click_link "Create Team"
end

When("Student enters {string} for team name and clicks create button") do |name|
  # fill team name
  within("form") do
    fill_in "team_name", with: name
  end
  # click create button
  click_button "Create"
end

Then("Student will be directed to their team page") do
  # should be at team page
  expect(page).to  have_content("Team")
end

Then("Student will be the team lead") do
  team = @student.teams.last
  expect(team.lead).to eq(@student.id)
end

