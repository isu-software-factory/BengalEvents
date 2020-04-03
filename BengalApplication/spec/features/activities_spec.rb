require 'rails_helper'
include Warden::Test::Helpers
RSpec.feature "Activities", type: :feature do

  context "create new event" do
    before(:each) do
      @sponsor = User.find(7)
      # log in
      login_as(@sponsor)
      visit new_activity_path(event_id: 1)
    end

    it "should be successful with all inputs entered" do
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

    it "should be successful with multiple sessions" do
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

    it "should be successful when using same room checkbox" do
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
      expect(Activity.find(4).sessions.count).to eq(3)
      expect(Activity.find(4).sessions.first.room.room_number).to eq("203")
      expect(Activity.find(4).sessions[1].room.room_number).to eq("203")
      expect(Activity.find(4).sessions[2].room.room_number).to eq("203")
      expect(page).to have_content("Successfully Created Activity")
    end

    it "should be successful when multiple activities" do
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


    context "update an activity" do
      before(:each) do
        @coordinator = User.find(9)
        @event = Event.first
        @activity = Activity.first
        # log in
        login_as(@coordinator)
        visit edit_activity_path(event_id: @event.id, id: @activity.id)
      end

      it "should be successful when name is updated" do
        # fill form
        within('form') do
          fill_in "name_New_1", with: "Droids"
        end
        click_button "Confirm"
        expect(Activity.first.name).to eq("Droids")
        expect(page).to have_content("Successfully updated Event.")
      end

      it "should be successful when description is updated" do
        # fill form
        within('form') do
          fill_in "description_1", with: "Program"
        end
        click_button "Confirm"
        expect(Activity.first.description).to eq("Program")
        expect(page).to have_content("Successfully updated Event.")
      end

      it "should be successful when iscompetetion is updated" do
        within('form') do
          check "iscompetetion_1"
        end
        click_button "Confirm"
        expect(Activity.first.iscompetetion).to eq(true)
        expect(page).to have_content("Successfully updated Event.")
      end

      it "should be successful when session time is updated" do
        within("form") do
          fill_in "start_time_New_1", with: "10:30"
          fill_in "end_time_1", with: "11:30"
        end
        click_button "Confirm"
        start_time = Time.new(2020,3,30,10,30,0, "-06:00")
        end_time = Time.new(2020, 3, 30, 11, 30, 0, "-06:00")
        expect(Activity.first.sessions.first.start_time).to eq(start_time)
        expect(Activity.first.sessions.first.end_time).to eq(end_time)
      end

      it "should be successful when session capacity is updated" do
        within("form") do
          fill_in "capacity_1", with: "5"
        end
        click_button "Confirm"
        expect(Activity.first.sessions.first.capacity).to eq(5)
      end

      it "should be successful when session room is updated" do
        within("form") do
          select("203 (Ballroom)", from: "room_select_1")
        end
        click_button "Confirm"
        expect(Activity.first.sessions.first.room.room_number).to eq("203")
      end


      #
      # it "should fail" do
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
    #   it "should be successful" do
    #     #click destroy
    #     click_link "Delete"
    #     page.driver.browser.switch_to.alert.accept
    #     expect(page).to have_content "Event was successfully deleted"
    #   end
    # end
  end
end
