

Given("Student is at team page") do
  # create student, teacher, team,
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  @student = @teacher.students.build(name: "Ben", user_attributes: {email: "ben@gmail.com", password: "password"}, participant_attributes: {})
  @student.save
  @student2 = @teacher.students.build(name: "Bill", user_attributes: {email: "bill@gmail.com", password: "password"}, participant_attributes: {})
  @student2.save
  @student3 = @teacher.students.build(name: "Bob", user_attributes: {email: "bob@gmail.com", password: "password"}, participant_attributes: {})
  @student3.save
  @team = Team.create(name: "Tigers", lead: @student.id, participant_attributes: {})
  @team.lead = @student.id
  @team.register_member(@student)
  @team.register_member(@student2)
  @team.register_member(@student3)

  # login and go to team page
  login_as(@student3.user)
  visit "teams/#{@team.id}"
end

Then("Student will see other members and team lead") do
  # page should show member names and position
  expect(page).to have_content("Bill")
  expect(page).to have_content("Ben")
  expect(page).to have_content("Bob")
  expect(page).to have_content("Member")
  expect(page).to have_content("Team Lead")
end
