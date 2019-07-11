require 'rails_helper'

RSpec.feature "Teachers", type: :feature do
  context "create new teacher" do
    scenario "should be successful" do
      visit new_teacher_path
      within('form') do
        fill_in "School", with: 'Daniel'
        fill_in 'teacher[chaperone_count]', with: 23
        fill_in 'teacher[student_count]', with: 202
      end
      click_button 'Confirm'
      expect(page).to have_content("teacher")
    end
  end

end
