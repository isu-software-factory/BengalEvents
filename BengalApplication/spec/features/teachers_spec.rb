require 'rails_helper'

RSpec.feature "Teachers", type: :feature do
  context "create new teacher" do
    before(:each) do
      visit new_teacher_path
      within('form') do
        fill_in "teacher[name]", with: "valley"
        fill_in "teacher[school]", with: 'Daniel'
        fill_in 'teacher[chaperone_count]', with: 23
      end
    end

    scenario "should be successful" do
      within('form') do
        fill_in 'teacher[student_count]', with: 2
        fill_in 'teacher[user_attributes][email]', with: "da2@gmail.com"
        fill_in 'teacher[user_attributes][password]', with: "password"
        fill_in 'teacher[user_attributes][password_confirmation]', with: "password"
      end
      click_button 'Create Account'
      expect(page).to have_content("Enter student emails to register")
    end

    scenario "should fail" do
      click_button "Create Account"
      expect(page).to have_content("Student count can't be blank")
      expect(page).to have_content("User email can't be blank")
      expect(page).to have_content("User password can't be blank")
    end
  end

  context "update teacher" do
    before do
      @teacher = Teacher.create(school: "Valley", chaperone_count: 23, student_count: 232, name: "Sally", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
      login_as(@teacher.user)
    end

    scenario "should be successful" do
     visit edit_teacher_path(@teacher)
      within("form")do
       fill_in "teacher[student_count]", with: "5"
       fill_in "teacher[user][current_password]", with: "password"
      end
      click_button 'Update'
      expect(page).to have_content("Successfully updated")
    end

    scenario "should fail" do
      visit edit_teacher_path(@teacher)
     within('form') do
       fill_in "School", with: ""
      end
      click_button "Update"
      expect(page).to have_content "School can't be blank"
    end
  end

  # Will not be implemented yet
  # context "destroy teacher" do
  #  scenario "should be successful" do
  #    @teacher = Teacher.create(school: "Valley", chaperone_count: 23, student_count: 232, name: "Sally", user_attributes: {email: "t@gmail.com", password: "password"})
  #    @coordinator = Coordinator.create(name: "Sally", user_attributes: {email: "coordinator@gmail.com", password: "password"})
  #    login_as(@coordinator.user, :scope => :user)
  #    visit coordinator_path(@coordinator)
  #     click_link "Delete"
  #     expect(page).to have_content "Teacher was successfully deleted"
  #   end
  # end

end
