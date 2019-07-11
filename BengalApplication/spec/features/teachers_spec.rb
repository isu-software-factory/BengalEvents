require 'rails_helper'

RSpec.feature "Teachers", type: :feature do
  context "create new teacher" do
    before(:each) do
      visit new_teacher_path
      within('form') do
        fill_in "School", with: 'Daniel'
        fill_in 'teacher[chaperone_count]', with: 23
      end
    end

    scenario "should be successful" do
      within('form') do
        fill_in 'teacher[student_count]', with: 202
      end
      click_button 'Confirm'
      expect(page).to have_content("Teacher main view")
    end

    scenario "should fail" do
      click_button "Confirm"
      expect(page).to have_content("Student count can't be blank")
    end
  end
  context "update teacher" do
    let!(:teacher) {Teacher.create(school: "valley", chaperone_count: 23, student_count: 232)}
    scenario "should be successful" do
      visit edit_teacher_path(teacher)
      within("form")do
        fill_in "School", with: "Wendell"
        fill_in "teacher[chaperone_count]", with: 2
        fill_in "teacher[student_count]", with: 23
      end
      click_button 'Update'
      expect(page).to have_content("Successfully updated")
    end

    scenario "should fail" do
      within('form') do
        fill_in "School", with: ""
      end
      click_button "Update"
      expect(page).to have_content "School can't be blank"
    end
  end

  context "destroy teacher" do
    scenario "should be successful" do
      teacher = Teacher.create(school: "valley", chaperone_count: 23, student_count: 232)
      visit teacher_path
      click_link "Delete"
      expect(page).to have_content "Teacher was successfully deleted"
    end
  end

end
