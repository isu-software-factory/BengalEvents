require 'rails_helper'

RSpec.feature "Teachers", type: :feature do
  context "create new teacher" do

    scenario "should fail" do
      visit new_user_path("Teacher")
      click_button "Create Account"
      expect(page).to have_content("User name can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("School name can't be blank")
      expect(page).to have_content("Chaperone count can't be blank")
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
    end
  end
  scenario "should be successful" do
    visit new_user_path("Teacher")
    expect(page).to have_content("Sign Up")
    within('form') do
      fill_in "school_name", with: "valley"
      fill_in "chaperone_count", with: 2
      fill_in 'first_name', with: "Jimmy"
      fill_in 'last_name', with: "Howard"
      fill_in 'email', with: "how@gmail.com"
      fill_in 'user_name', with: "jimIS23"
      fill_in 'password', with: "password"
      fill_in "password_confirmation", with: "password"
    end
    click_button 'Create Account'
    expect(page).to have_content("Enter Student Name and (Email or Username)")
  end
end

  #context "update teacher" do
  #  before do
  #    @teacher = User.first
  #    login_as(@teacher)
  #  end
  #
  #  scenario "should be successful" do
  #   visit edit_teacher_path(@teacher)
  #    within("form")do
  #     fill_in "teacher[student_count]", with: "5"
  #     fill_in "teacher[user][current_password]", with: "password"
  #    end
  #    click_button 'Update'
  #    expect(page).to have_content("Successfully updated")
  #  end
  #
  #  scenario "should fail" do
  #    visit edit_teacher_path(@teacher)
  #   within('form') do
  #     fill_in "School", with: ""
  #    end
  #    click_button "Update"
  #    expect(page).to have_content "School can't be blank"
  #  end
  #end

  context "Controlling Student" do
    before(:each) do
      @teacher = User.first
      login_as(@teacher)
      visit profile_path(@teacher)
    end

    it "teacher resets student password and creates a new one" do
      button=all(".dropdown-toggle").last
      button.click
      option=find("a", text: "Request New Password")
      option.click
      expect(page).to have_content("Successfully Reset Password")
    end

    it "teacher can register the student for an activity" do
      button=all(".dropdown-toggle").last
      button.click
      option=find("a", text: "Register For Student")
      option.click
      first(".event-collapse").click
      check "register"
      expect(first(".registered")).to have_content("Registered")
    end
  end


