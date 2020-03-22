require 'rails_helper'
include Warden::Test::Helpers
RSpec.feature "Events", type: :feature do

  context "create new event" do
    before(:each) do
      @sponsor = User.find(7)
      # log in
      login_as(@sponsor)
      visit new_activity_path(event_id: 1)
    end

    scenario "should be successful with all inputs entered" do
      within('form') do
        fill_in "name_New_1", with: "Robots in the gym"
        fill_in "description_1", with: "All about robots"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_1")
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
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_1")
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
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_1")
        fill_in "start_time_New_1", with: "9:30"
        fill_in "end_time_1", with: "10:30"
        fill_in "capacity_1", with: "3"
      end

      first(".new-session").click

      # second session
      within("form") do
        fill_in "start_time_2", with: "11:30"
        fill_in "end_time_2", with: "12:30"
        fill_in "capacity_2", with: "3"
      end

      first(".new-session").click

      # third session
      within("form") do
        fill_in "start_time_3", with: "1:30"
        fill_in "end_time_3", with: "2:30"
        fill_in "capacity_3", with: "3"
      end

      within("form") do
        select("203 (Ballroom)", from: "room_select_1")
      end

      check "same_room"
      click_button "Confirm"
      Capybara.default_max_wait_time = 500
      expect(Activity.find(4).sessions.count).to eq(3)
      expect(Activity.find(4).sessions.first.rooms.first.room_number).to eq("203")
      expect(Activity.find(4).sessions[1].rooms.first.room_number).to eq("203")
      expect(Activity.find(4).sessions[2].rooms.first.room_number).to eq("203")
      expect(page).to have_content("Successfully Created Activity")
    end

    scenario "should be successful when multiple activities" do
      within('form') do
        fill_in "name_New_1", with: "Robots in the gym"
        fill_in "description_1", with: "All about robots"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_1")
        fill_in "start_time_New_1", with: "9:30"
        fill_in "end_time_1", with: "10:30"
        select("102 (Cafe)", from: "room_select_1")
        fill_in "capacity_1", with: "3"
      end

      first(:xpath, "//button[@title='Add New Activity']").click

      within('form') do
        fill_in "name_New_2", with: "Python"
        fill_in "description_2", with: "Learn Python"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_2")
        select("102 (Cafe)", from: "room_select_2")
        fill_in "start_time_New_2", with: "5:30"
        fill_in "end_time_2", with: "6:30"
        fill_in "capacity_2", with: "3"
      end

      click_button 'Confirm'
      expect(page).to have_content("Successfully Created Activity")
    end


    context "update an event" do
      before(:each) do
        @coordinator = User.find(9)
        @event = Event.first
        @activity = Activity.first
        # log in
        login_as(@coordinator)
        visit edit_activity_path(event_id: @event.id, id: @activity.id)
      end

      scenario "should be successful when name is updated" do
        # fill form
        within('form') do
          fill_in "name_New_1", with: "Robots in the gym"
        end
        click_button "Confirm"
        expect(page).to have_content("Successfully updated Event.")
      end
      #
      # scenario "should fail" do
      #   # fill form
      #   within('form') do
      #     fill_in "event[name]", with: ""
      #     select("SUB", from: 'event[location_id]')
      #     fill_in "event[description]", with: "Science"
      #   end
      #   click_button "Confirm"
      #   expect(page).to have_content("Name can't be blank")
      # end
    end

    # context "destroy event" do
    #   before(:each) do
    #     @event = events(:one)
    #     @event.location = @location
    #     @sponsor = sponsors(:sponsor_carlos)
    #     @occasion = occasions(:one)
    #     # log in
    #     login_as(@sponsor.user)
    #     visit event_path(@occasion.id)
    #   end
    #
    #   scenario "should be successful" do
    #     #click destroy
    #     click_link "Delete"
    #     page.driver.browser.switch_to.alert.accept
    #     expect(page).to have_content "Event was successfully deleted"
    #   end
    # end
  end
end
