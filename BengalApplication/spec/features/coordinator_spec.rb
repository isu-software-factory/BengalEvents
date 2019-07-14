require 'rails_helper'

RSpec.feature "Coordinators", type: :feature do
  context "create new coordinator" do

    scenario "should be successful" do
      visit new_coordinator_path
      within('form') do
        fill_in "Name", with: 'Daniel'
        fill_in 'coordinator[email]', with: "hi@gmail.com"
        fill_in 'coordinator[password]', with: "password"
      end
      click_button 'Confirm'
      expect(page).to have_content("Coordinator main view")
    end

    scenario "should fail" do
      visit new_coordinator_path
      within('form') do
        fill_in "Name", with: 'Daniel'
        fill_in "coordinator[password]", with: "password"
      end
      click_button "Confirm"
      expect(page).to have_content("Name can't be blank")
    end
  end
  context "update coordinator" do
    let!(:coordinator) {Coordinator.create}
    scenario "should be successful" do
      visit edit_coordinator_path(coordinator)
      within("form")do
        fill_in "Name", with: "Wendell"
        fill_in "coordinator[email]", with: "sup@gmail.com"

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

  context "destroy coordinator" do
    scenario "should be successful" do
      coordinator = Coordinator.create
      visit coordinator_path(coordinator)
      click_link "Delete"
      expect(page).to have_content "Coordinator was successfully deleted"
    end
  end
end
