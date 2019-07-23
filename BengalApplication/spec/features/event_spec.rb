require 'rails_helper'
include Warden::Test::Helpers
RSpec.feature "Events", type: :feature do
  context "create new event" do
    before(:each) do
      Warden.test_reset!
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "sup@gmail.com", password: "password" })
      @coordinator.occasions.create(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      sponsor = Sponsor.create(name: "Sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      login_as(sponsor.user, :scope => :user)
      visit new_occasion_event_path(1)
      within('form') do
       fill_in "event[name]", with: "Robtics"
       fill_in "event[location]", with: "Gym"
      end
    end

    scenario "should be successful" do
      within('form') do
       fill_in "event[description]", with: "Robots in the gym"
      end
      click_button 'Confirm'
      expect(page).to have_content("These are the lists of events under this occasion.")

    end

    scenario "should fail" do
      click_button "Confirm"
      expect(page).to have_content("Description can't be blank")
  end
  end
  end
