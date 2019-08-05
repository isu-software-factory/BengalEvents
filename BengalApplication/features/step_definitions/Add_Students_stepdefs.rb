
Given("Teacher is logged in") do
  # create teacher
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})

  # login and go to teacher page
  login_as(@teacher.user, :scope => :user)
  visit "teachers/#{@teacher.id}"
end

When("Teacher clicks Add students") do
  click_link "Add Students"
end

When("Teacher fills out student information and clicks Add Student") do
  # fill form
  within("form") do
    fill_in "student[name]", with: "Ben"
    fill_in "student[user_attributes][email]", with: "student@gmail.com"
  end
  click_button "Add Student"
end

Then("Student account will be created") do
  expect(Student.find_by(name: "Ben")).to_not eq(nil)
end
