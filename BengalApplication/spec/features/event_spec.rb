require 'rails_helper'
include Warden::Test::Helpers
RSpec.feature "Events", type: :feature do
  fixtures :occasions, :events, :locations, :sponsors, :supervisors

  context "create new event" do
    before(:each) do
      Warden.test_reset!
      @occasion = occasions(:one)
      @location = locations(:one)
      @event = events(:one)
      @event.location = @location
      @sponsor = sponsors(:sponsor_carlos)
      # log in
      login_as(@sponsor.user)
      visit new_occasion_event_path(@occasion.id)

      within('form') do
       fill_in "event[name]", with: "Robotics"
       select("Gym", from: 'event[location_id]')
      end
    end

    scenario "should be successful" do
      within('form') do
       fill_in "event[description]", with: "Robots in the gym"
      end
      click_button 'Confirm'
      expect(page).to have_content("Successfully created Event.")

    end

    scenario "should fail" do
      click_button "Confirm"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "update an event" do
    before(:each) do
      Warden.test_reset!
      @occasion = occasions(:one)
      @location = locations(:one)
      @event = events(:one)
      @event.location = @location
      @sponsor = sponsors(:sponsor_carlos)
      # log in
      login_as(@sponsor.user)
      visit edit_occasion_event_path(occasion_id: @occasion.id, id: @event.id)
    end

    scenario "should be successful" do
      # fill form
      within('form') do
        fill_in "event[name]", with: "Biology"
        select("SUB", from: 'event[location_id]')
        fill_in "event[description]", with: "Science"
      end
        click_button "Confirm"
        expect(page).to have_content("Successfully updated Event.")
    end

    scenario "should fail" do
      # fill form
      within('form') do
        fill_in "event[name]", with: ""
        select("SUB", from: 'event[location_id]')
        fill_in "event[description]", with: "Science"
      end
      click_button "Confirm"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "destroy event" do
    before(:each) do
      @event = events(:one)
      @event.location = @location
      @sponsor = sponsors(:sponsor_carlos)
      # log in
      login_as(@sponsor.user)
      visit occasion_path(@occasion.id)
    end

    scenario "should be successful" do
      #click destroy
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "Event was successfully deleted"
    end
  end
end
