require 'rails_helper'

RSpec.feature "Students", type: :feature do

  context "create student" do
    before(:each) do
      @teacher = User.first
      login_as(@teacher)
      visit new_user_path("Student")
    end

    scenario "should display new field for student" do
      expect(page).not_to have_xpath("//input[@placeholder='First Name']")
      expect(page).not_to have_xpath("//input[@placeholder='Last Name']")
      expect(page).not_to have_xpath("//input[@placeholder='Student Email or Username']")
      find(".glyphicon-plus").click
      expect(page).to have_xpath("//input[@placeholder='First Name']")
      expect(page).to have_xpath("//input[@placeholder='Last Name']")
      expect(page).to have_xpath("//input[@placeholder='Student Email or Username']")
    end

    scenario "should be successful" do
      # add new student
      find(".glyphicon-plus").click
      within("form") do
        fill_in "first_10", with: "Janet"
        fill_in "last_10", with: "Terry"
        fill_in "email_10", with: "janet@gmail.com"
      end
      click_button "Submit Changes"
      expect(page).to have_content("Janet Terry")
      expect(Teacher.first.users.count).to eq(6)
    end

    scenario "should fail without first name" do
      # add new student
      find(".glyphicon-plus").click

      within("form") do
        fill_in "last_10", with: "Terry"
        fill_in "email_10", with: "janet@gmail.com"
      end
      click_button "Submit Changes"
      expect(page).to have_content("First name can't be blank")
    end

    scenario "should fail without last name" do
      # add new student
      find(".glyphicon-plus").click

      within("form") do
        fill_in "first_10", with: "Janet"
        fill_in "email_10", with: "janet@gmail.com"
      end
      click_button "Submit Changes"
      expect(page).to have_content("Last name can't be blank")
    end

    scenario "should fail without Username" do
      # add new student
      find(".glyphicon-plus").click

      within("form") do
        fill_in "first_10", with: "Janet"
        fill_in "last_10", with: "Terry"
      end
      click_button "Submit Changes"
      expect(page).to have_content("User name can't be blank")
    end
  end


  context "update student through teacher" do
    before(:each) do
      @teacher = User.first
      login_as(@teacher)
      visit new_user_path("Student")
    end

    scenario "should be successful" do
      # edit student 2
      within("form") do
        fill_in "first_2", with: "Billy"
        fill_in "last_2", with: "Smith"
        fill_in "email_2", with: "bill@gmail.com"
      end

      click_button "Submit Changes"
      expect(page).to have_content("Billy Smith")
      expect(page).to have_content("bill@gmail.com")
    end

    scenario "should fail" do
      # edit student 2
      within("form") do
        fill_in "email_2", with: ""
      end

      click_button "Submit Changes"
      expect(page).to have_content("User name can't be blank")
    end
  end


  context "update student through student" do
    before(:each) do
      @student = User.find(2)
      login_as(@student)
      visit edit_user_registration_path(@student)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "user[password]", with: "Password"
        fill_in "user[password_confirmation]", with: "Password"
        fill_in "user[current_password]", with: "password"
      end
      click_button "Update"
      expect(page).to have_content("Your account has been updated successfully")
    end

    scenario "should fail without password" do
      within("form") do
        fill_in "user[password_confirmation]", with: "Password"
        fill_in "user[current_password]", with: "password"
      end
      click_button "Update"
      expect(page).to have_content("Password can't be blank")
    end

    scenario "should fail if passwords don't match" do
      within("form") do
        fill_in "user[password]", with: "Password"
        fill_in "user[password_confirmation]", with: "Psassword"
        fill_in "user[current_password]", with: "password"
      end
      click_button "Update"
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "should fail if current password isn't valid" do
      within("form") do
        fill_in "user[password]", with: "Password"
        fill_in "user[password_confirmation]", with: "Password"
        fill_in "user[current_password]", with: "psassword"
      end
      click_button "Update"
      expect(page).to have_content("Current password is invalid")
    end
  end

  #
  # context "destroy student through teacher" do
  #   before(:each) do
  #     @teacher = teachers(:teacher_emily)
  #     login_as(@teacher.user)
  #     visit new_student_path
  #   end
  #
  #   scenario "should be successful" do
  #     # click minus button
  #     find(".glyphicon-minus", match: :first).click()
  #
  #     expect(page).not_to have_content("Robert")
  #   end
  # end

end


