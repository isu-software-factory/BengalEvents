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
      expect(page).to have_content("Welcome, Daniel")
    end

    scenario "should fail" do
      visit new_sponsor_path
      within('form') do
        fill_in "sponsor[name]", with: 'Daniel'
        fill_in "sponsor[user_attributes][password]", with: "password"
      end
        click_button "Confirm"
        expect(page).to have_content("User email can't be blank")
    end
  end

  # Will not be implemented
  # context "update sponsor" do
  #  before do
  #    @sponsor = Sponsor.create(name: "Daniel", user_attributes: {email: "s@gmail.com", password: "password"})
  #  end
  #   scenario "should be successful" do
  #     login_as(@sponsor.user)
  #    visit edit_sponsor_path(@sponsor)
  #     within("form")do
  #      fill_in "Name", with: "Jane"
  #      fill_in "sponsor[email]", with: "sup@gmail.com"
  #      fill_in "sponsor[password]", with: "password23"
  #     end
  #     click_button 'Update'
  #     expect(page).to have_content("Successfully updated")
  #   end
  #
  #   scenario "should fail" do
  #     login_as(@sponsor.user)
  #     visit edit_sponsor_path(@sponsor)
  #    within("form") do
  #      fill_in "Name", with: ""
  #     end
  #     click_button "Update"
  #     expect(page).to have_content "Name can't be blank"
  #   end
  # end

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
