require 'rails_helper'

RSpec.feature "Coordinators", type: :feature do
  context "create new coordinator" do
    before(:each) do
      @admin = Admin.create(name: "ad", user_attributes: {email: "a@gmail.com", password: "password"})
      Supervisor.create(director: @admin)
      login_as(@admin.user)
    end

    scenario "should be successful" do
      visit new_coordinator_path
      within('form') do
        fill_in "Name", with: 'Daniel'
        fill_in 'coordinator[user_attributes][email]', with: "hi@gmail.com"
        fill_in 'coordinator[user_attributes][password]', with: "password"
        fill_in 'coordinator[user_attributes][password_confirmation]', with: "password"
      end
      click_button 'Confirm'
      expect(page).to have_content("Occasions")
    end

    scenario "should fail" do
      visit new_coordinator_path
      within('form') do
        fill_in "coordinator[user_attributes][email]", with: "hi@gmail.com"
        fill_in "coordinator[user_attributes][password]", with: "password"
      end
      click_button "Confirm"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "update coordinator" do
   before(:each) do
     @coordinator = Coordinator.create(name: "coor", user_attributes: {email: "coord@gmail.com", password: "password"})
     Supervisor.create(director: @coordinator)
     login_as(@coordinator.user)
   end

   scenario "should be successful" do
     visit edit_user_registration_path
     within("form")do
       fill_in "user[email]", with: "WenQ@gmail.com"
       fill_in "user[current_password]", with: "password"

     end
     click_button 'Update'
     expect(page).to have_content("Your account has been updated successfully.")
   end

   scenario "should fail" do
     visit edit_user_registration_path
     within("form") do
       fill_in "user[email]", with: ""
       fill_in "user[current_password]", with: "password"
     end
     click_button "Update"
     expect(page).to have_content "Email can't be blank"
   end
  end

 # context "destroy coordinator" do
  #  scenario "should be successful" do
   #   coordinator = Coordinator.create
   #   visit coordinator_path(coordinator)
    #  click_link "Delete"
     # expect(page).to have_content "Coordinator was successfully deleted"
    #end
  #end
end
