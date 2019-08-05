Given("Teacher is logged in and at teacher page") do
  # create teacher, and two students
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  @student = @teacher.students.build(name: "Ben", user_attributes: {email: "ben@gmail.com", password: "password"}, participant_attributes: {})
  @student.save
  @student2 = @teacher.students.build(name: "Lucas", user_attributes: {email: "lucas@gmail.com", password: "password"}, participant_attributes: {})
  @student2.save

  # log in and go to teacher page
  login_as(@teacher.user, :scope => :user)
  visit "teachers/#{@teacher.id}"
end

Then("Teacher will see student's names and email") do
  expect(page).to have_content("#{@student.name}")
  expect(page).to have_content("#{@student2.name}")
  expect(page).to have_content("#{@student.user.email}")
  expect(page).to have_content("#{@student2.user.email}")
end


