Given("Teacher is a home page") do
  # go to home page
  visit "homeroutes/routes"
end

When("Teacher clicks sign up as a teacher") do
  click_link "Sign Up as Teacher"
end

When("Fills out information and clicks confirm") do
  # fill form
  within("form") do
    fill_in "teacher[name]", with: "Nancy"
    fill_in "teacher[school]", with: "Pocatello"
    fill_in "teacher[chaperone_count]", with: 5
    fill_in "teacher[student_count]", with: 40
    fill_in "teacher[user_attributes][email]", with: "nancy@gmail.com"
    fill_in "teacher[user_attributes][password]", with: "password"
    fill_in "teacher[user_attributes][password_confirmation]", with: "password"
  end
  click_button "Confirm"
end

Then("Teacher will be redirected to teacher page") do
  expect(page).to have_content("Teachers Main Page")
end
