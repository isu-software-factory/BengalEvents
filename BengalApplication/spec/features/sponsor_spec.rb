require 'rails_helper'

RSpec.feature "Sponsors", type: :feature do

  before do
    visit new_sponsor_path
  end
  context "create new sponsor" do
    scenario "should be successful" do
      within('form') do
        fill_in "sponsor[name]", with: 'Daniel'
        fill_in 'sponsor[user_attributes][email]', with: "hi@gmail.com"
        fill_in 'sponsor[user_attributes][password]', with: "password"
        fill_in 'sponsor[user_attributes][password_confirmation]', with: "password"
      end
      click_button 'Create Account'
      expect(page).to have_content("#{"Daniel"}")
    end

    scenario "should fail" do
      within('form') do
        fill_in "sponsor[name]", with: 'Daniel'
        fill_in "sponsor[user_attributes][password]", with: "password"
      end
        click_button "Create Account"
        expect(page).to have_content("User email can't be blank")
    end
  end


  context "update sponsor" do
   before do
     @sponsor = Sponsor.create(name: "Carlos", user_attributes: {email: "sponsor@gmail.com", password: "password"}, supervisor_attributes:{})
     login_as(@sponsor.user)
     visit edit_user_registration_path(@sponsor.user)
   end

    scenario "should be successful" do
      within("form#edit_user")do
        fill_in "user_email", with: "sup@gmail.com"
        fill_in "user_password", with: "password23"
        fill_in "user_password_confirmation", with: "password23"
        fill_in "user_current_password", with: "password"
      end
      click_button 'Update'
      expect(page).to have_content("Your account has been updated successfully.")
    end

    scenario "should fail" do
      within("form#edit_user") do
       fill_in "user_email", with: ""
      end
      click_button "Update"
      expect(page).to have_content "Email can't be blank"
    end
  end

  # Not yet implemented
  # context "destroy sponsor" do
  #  scenario "should be successful" do
  #    @sponsor = Sponsor.create(name: "Dan", user_attributes: {email: "e@gmail.com", password: "password"})
  #    @coordinator = Coordinator.create(name: "Coordinator", user_attributes: {emaiL: "c@gamil.com", password: "password"})
  #    visit coordinator_path(@coordinator)
  #     click_link "Delete"
  #     expect(page).to have_content "Sponsor was successfully deleted"
  #   end
  # end
end
