require 'rails_helper'

RSpec.feature "Sponsors", type: :feature do
  context "create new sponsor" do
    scenario "should be successful" do
      visit new_sponsor_path
      within('form') do
        fill_in "sponsor[name]", with: 'Daniel'
        fill_in 'sponsor[user_attributes][email]', with: "hi@gmail.com"
        fill_in 'sponsor[user_attributes][password]', with: "password"
        fill_in 'sponsor[user_attributes][password_confirmation]', with: "password"
      end
      click_button 'Confirm'
      expect(page).to have_content("Events Upcoming")
    end

    scenario "should fail" do
      visit new_sponsor_path
      within('form') do
        fill_in "sponsor[name]", with: 'Daniel'
        fill_in "sponsor[user_attributes][password]", with: "password"
        click_button "Confirm"
        expect(page).to have_content("Name")
      end
    end
  end

  #context "update sponsor" do
   # let!(:sponsor) {Student.create}
    #scenario "should be successful" do
     # visit edit_sponsor_path(sponsor)
      #within("form")do
       # fill_in "Name", with: "Wendell"
        #fill_in "sponsor[email]", with: "sup@gmail.com"
        #fill_in "sponsor[password]", with: "password23"

      #end
      #click_button 'Update'
      #expect(page).to have_content("Successfully updated")
    #end

    #scenario "should fail" do
     # within('form') do
       # fill_in "Name", with: ""
      #end
      #click_button "Update"
      #expect(page).to have_content "Name can't be blank"
    #end
  #end

  #context "destroy sponsor" do
   # scenario "should be successful" do
    #  sponsor = Student.create
     # visit sponsor_path(sponsor)
      #click_link "Delete"
      #expect(page).to have_content "Student was successfully deleted"
    #end
  #end
end
