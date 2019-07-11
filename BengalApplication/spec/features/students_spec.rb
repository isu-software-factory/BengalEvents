require 'rails_helper'

RSpec.feature "Students", type: :feature do
  context "create new student" do


    scenario "should be successful" do
      visit new_student_path
      within('form') do
        fill_in "Name", with: 'Daniel'
        fill_in 'student[email]', with: "hi@gmail.com"
    end
      click_button 'Confirm'
      expect(page).to have_content("Student main view")
    end

    scenario "should fail" do
      visit new_student_path
      within('form') do
        fill_in "Name", with: 'Daniel'
      click_button "Confirm"
      expect(page).to have_content("Name can't be blank")
    end
    end
    end
  context "update student" do
    let!(:student) {Student.create}
    scenario "should be successful" do
      visit edit_student_path(student)
      within("form")do
        fill_in "Name", with: "Wendell"
        fill_in "student[email]", with: "sup@gmail.com"

      end
      click_button 'Update'
      expect(page).to have_content("Successfully updated")
    end

    scenario "should fail" do
      within('form') do
        fill_in "Name", with: ""
      end
      click_button "Update"
      expect(page).to have_content "Name can't be blank"
    end
  end

  context "destroy student" do
    scenario "should be successful" do
      student = Student.create
      visit student_path(student)
      click_link "Delete"
      expect(page).to have_content "Student was successfully deleted"
    end
  end
end
