# Teacher
Given("Teacher has account created and is at login page") do
  # create teacher
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})

  # go to sign in page
  visit "users/sign_in"
end

When("Teacher enters login credentials and clicks log in button") do
  # fill form
  within("form") do
    fill_in "user_email", with: "t@gmail.com"
    fill_in "user_password", with: "password"
  end
  # click log in
  click_button "Log in"
end

Then("Teacher logs in successfully") do
  # should got to teachers page
  expect(page).to have_content("Teachers Main Page")
end

# Student
Given("Student has account created and is at login page") do
  # create teacher and student
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  @student = @teacher.students.build(name: "Billy", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes: {})
  @student.save

  # go to sign in page
  visit "users/sign_in"
end

When("Student enters login credentials and clicks log in button") do
  # fill form
  within("form") do
    fill_in "user_email", with: "student@gmail.com"
    fill_in "user_password", with: "password"
  end
  # click log in
  click_button "Log in"
end

Then("Student logs in successfully") do
  # should be at student page
  expect(page).to have_content("Welcome, #{@student.name}")
end


Given("Sponsor has account created and is at login page") do
  # create coordinator
  @sponsor = Sponsor.create(name: "Ben", user_attributes: {email: "sponsor@gmail.com", password:"password"})

  # go to sign in page
  visit "users/sign_in"
end

When("Sponsor enters login credentials and clicks log in button") do
  # fill form
  within("form") do
    fill_in "user_email", with: "sponsor@gmail.com"
    fill_in "user_password", with: "password"
  end
  # click log in
  click_button "Log in"
end

Then("Sponsor logs in successfully") do
 # should be at sponsor page
 expect(page).to have_content("Welcome, #{@sponsor.name}")
end

Given("Coordinator has account created and is at login page") do
  # create coordinator
  @coordinator = Coordinator.create(name: "Sally", user_attributes: {email: "coordinator@gmail.com", password: "password"})

  # go to sign in page
  visit "users/sign_in"
end

When("Coordinator enters login credentials and clicks log in button") do
  # fill form
  within("form") do
    fill_in "user_email", with: "coordinator@gmail.com"
    fill_in "user_password", with: "password"
  end
  # click log in
  click_button "Log in"
end

Then("Coordinator logs in successfully") do
  # should go to coordinator page
  expect(page).to have_content("coordinator@gmail.com")
end


