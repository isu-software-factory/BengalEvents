require 'rails_helper'
include Warden::Test::Helpers
RSpec.feature "Events", type: :feature do

  context "create new event" do
    before(:each) do
      @sponsor = User.find(7)
      # log in
      login_as(@sponsor)
      visit new_activity_path(event_id:1)
    end

    scenario "should be successful with all inputs entered" do
      within('form') do
       fill_in "name_New_1", with: "Robots in the gym"
       fill_in "description_1", with: "All about robots"
       select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select")
       fill_in "start_time_New_1", with: "9:30"
       fill_in "end_time_1", with: "10:30"
       select("102 (Cafe)", from: "room_select_1")
       fill_in "capacity_1", with: "3"
      end

      click_button 'Confirm'
      expect(page).to have_content("Successfully Created Activity")
    end

    scenario "should be successful with multiple sessions" do
      within('form') do
        fill_in "name_New_1", with: "Robots in the gym"
        fill_in "description_1", with: "All about robots"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select")
        fill_in "start_time_New_1", with: "9:30"
        fill_in "end_time_1", with: "10:30"
        select("102 (Cafe)", from: "room_select_1")
        fill_in "capacity_1", with: "3"
      end

      first(".new-session").click

      within("form") do
        fill_in "start_time_2", with: "11:30"
        fill_in "end_time_2", with: "12:30"
        select("102 (Cafe)", from: "room_select_2")
        fill_in "capacity_2", with: "3"
      end

      click_button 'Confirm'
      expect(page).to have_content("Successfully Created Activity")
    end

    scenario "should be successful when using same room checkbox" do
      within('form') do
        fill_in "name_New_1", with: "Robots in the gym"
        fill_in "description_1", with: "All about robots"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select")
        fill_in "start_time_New_1", with: "9:30"
        fill_in "end_time_1", with: "10:30"
        fill_in "capacity_1", with: "3"
      end

      first(".new-session").click

      within("form") do
        fill_in "start_time_2", with: "11:30"
        fill_in "end_time_2", with: "12:30"
        fill_in "capacity_2", with: "3"
      end

      first(".new-session").click

      within("form") do
        fill_in "start_time_3", with: "1:30"
        fill_in "end_time_3", with: "2:30"
        fill_in "capacity_3", with: "3"
      end

      check "same_room"

      within("form") do
        select("203 (Ballroom)", from: "room_select_1")
      end

      click_button "Confirm"
      expect(Session.find(6).rooms.first.room_number).to eq("203")
      expect(Session.find(6).rooms[1].room_number).to eq("203")
      expect(Session.find(6).rooms[2].room_number).to eq("203")
      expect(page).to have_content("Successfully Created Activity")


    end

  #  scenario "should fail" do
  #    click_button "Confirm"
  #    expect(page).to have_content("Description can't be blank")
  #  end
  #end

  #context "update an event" do
  #  before(:each) do
  #    Warden.test_reset!
  #    @occasion = occasions(:one)
  #    @location = locations(:one)
  #    @event = events(:one)
  #    @event.location = @location
  #    @sponsor = sponsors(:sponsor_carlos)
  #    # log in
  #    login_as(@sponsor.user)
  #    visit edit_occasion_activity_path(occasion_id: @occasion.id, id: @event.id)
  #  end
  #
  #  scenario "should be successful" do
  #    # fill form
  #    within('form') do
  #      fill_in "event[name]", with: "Biology"
  #      select("SUB", from: 'event[location_id]')
  #      fill_in "event[description]", with: "Science"
  #    end
  #      click_button "Confirm"
  #      expect(page).to have_content("Successfully updated Event.")
  #  end
  #
  #  scenario "should fail" do
  #    # fill form
  #    within('form') do
  #      fill_in "event[name]", with: ""
  #      select("SUB", from: 'event[location_id]')
  #      fill_in "event[description]", with: "Science"
  #    end
  #    click_button "Confirm"
  #    expect(page).to have_content("Name can't be blank")
  #  end
  #end
  #
  #context "destroy event" do
  #  before(:each) do
  #    @event = events(:one)
  #    @event.location = @location
  #    @sponsor = sponsors(:sponsor_carlos)
  #    @occasion = occasions(:one)
  #    # log in
  #    login_as(@sponsor.user)
  #    visit event_path(@occasion.id)
  #  end
  #
  #  scenario "should be successful" do
  #    #click destroy
  #    click_link "Delete"
  #    page.driver.browser.switch_to.alert.accept
  #    expect(page).to have_content "Event was successfully deleted"
  #  end
  end
end
