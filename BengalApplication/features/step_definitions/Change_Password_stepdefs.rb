def create_user(user, email1, password1)
  if user == "Teacher"
    @user = Teacher.create(name: "Sam", chaperone_count: 3, student_count: 23, school: "valley", user_attributes: {email: email1, password: password1}, participant_attributes: {})
  elsif user == "Student"
    @teacher = Teacher.create(name: "Sam", chaperone_count: 3, student_count: 23, school: "valley", user_attributes: {email: email1, password: password1}, participant_attributes: {})
    @user = @teacher.students.build(name: "Billy", user_attributes: {email: email1, password: password1}, participant_attributes: {})
  elsif user == "Sponsor"
    @user = Sponsor.create(name: "Tim", user_attributes: {email: email1, password: password1})
  else
    @user = Coordinator.create(name: "Kyle", user_attributes: {email: email1, password: password1})
  end
end

Given("User {string} is logged in with {string} and {string}") do |user, email, password|
  # create the user
  @user = create_user(user, email, password)
  expect(@user).not_to eq(nil)

  # login
  login_as(@user.user)
  visit "homeroutes/routes"
end

When("User clicks their {string}") do |email|
  click_link(email)
end

When("Fills in password field with {string} and {string}") do |password, newpassword|
  # fill password
  within("form") do
    fill_in "user_password", with: newpassword
    fill_in "user_password_confirmation", with: newpassword
    fill_in "user_current_password", with: password
  end
  click_button "Update"
end

Then("User password will change to {string}") do |newpassword|
  expect(@user.user.password).to eq(newpassword)
end
