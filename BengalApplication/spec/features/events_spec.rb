require 'rails_helper'

RSpec.feature "Events", type: :feature do

  context "create new event" do
    before(:each) do
      @coordinator = User.find(9)
      login_as(@coordinator)

      visit new_event_path
    end

    context "successfully creating event" do
      before(:each) do
        fill_in "name", with: "BengalEventsAgain"
        fill_in "description", with: "Stem Day"
        fill_in "start_date", with: "2020-04-05"
      end

      it "should be successful without location address" do
        within('form') do
          fill_in "location_1", with: "SUB"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      it "should be successful with location address" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      it "should be successful without room name" do
        within('form') do
          fill_in "location_1", with: "SUB"
          fill_in "room_number_New_1", with: 232
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      it "should be successful with all fields filled in" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      it "should successfully create many rooms in one location" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        find("#location_1").click
        find(:xpath, "//button[@title='Add A New Room']").click
        within("form") do
          fill_in "room_number_2", with: 322
        end
        find("#location_1").click
        find(:xpath, "//button[@title='Add A New Room']").click
        within("form") do
          fill_in "room_number_3", with: 212
        end
        click_button 'Save and Continue'
        expect(Location.last.rooms.count).to eq(3)
      end

      it "should successfully create many locations and rooms" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        find("#location_1").click
        find(:xpath, "//button[@title='Add A New Room']").click
        within("form") do
          fill_in "room_number_2", with: 322
        end
        find("#location_1").click
        find(:xpath, "//button[@title='Add A New Location']").click
        within("form") do
          fill_in "location_2", with: "College of Tech"
          fill_in "room_number_New_3", with: 121
        end
        click_button 'Save and Continue'
        expect(Location.all.count).to eq(3)
        expect(Location.last.rooms.count).to eq(1)
        expect(Location.find(2).rooms.count).to eq(2)
        expect(Room.all.count).to eq(6)
      end
    end

    context "copying events and activities" do
      before(:each) do
        @start_date = DateTime.new(2020, 4, 5, 3)
        e = Event.new(name: "Stem", description: "Stuff", start_date: @start_date)
        e.save
        a = Activity.new(user_id: 8, name: "Robots", event_id: e.id, description: "Stuff again", equipment: "Cool Stuff", ismakeahead: false, iscompetetion: false, identifier: 20, max_team_size: nil)
        a2 = Activity.new(user_id: 8, name: "drones", event_id: e.id, description: "Stuff For you", equipment: "nothing", ismakeahead: true, iscompetetion: false, identifier: 21, max_team_size: nil)
        a.save
        a2.save

        @admin = User.find(8)
        login_as @admin
        visit copy_event_path
      end
      context "should be successful" do

        it "event is copied" do
          check "event_1"
          check "activity_1"
          click_button "Submit"


          event = Event.first
          copied_event = Event.find(3)

          expect(copied_event.name).to eq(event.name)
          expect(copied_event.description).to eq(event.description)
          expect(copied_event.start_date).to eq(event.start_date)
          sleep(8)
        end

        it "one activity is copied" do
          check "event_1"
          check "activity_1"
          click_button "Submit"


          copied_event = Event.find(3)
          activity = Activity.first
          copied_activity = copied_event.activities.first
          expect(copied_event.activities.length).to eq(1)
          expect(copied_activity.name).to eq(activity.name)
          expect(copied_activity.description).to eq(activity.description)
          expect(copied_activity.equipment).to eq(activity.equipment)
          expect(copied_activity.ismakeahead).to eq(activity.ismakeahead)
          expect(copied_activity.iscompetetion).to eq(activity.iscompetetion)
          expect(copied_activity.identifier).to eq(activity.identifier)
          expect(copied_activity.max_team_size).to eq(activity.max_team_size)
          sleep(8)
        end

        it "multiple activities are copied" do
          check "event_1"
          check "activity_1"
          check "activity_2"
          click_button "Submit"

          copied_event = Event.find(3)
          activity = Activity.first
          activity2 = Activity.find(2)
          copied_activity = copied_event.activities.first
          copied_activity2 = copied_event.activities[1]
          expect(copied_event.activities.length).to eq(2)
          expect(copied_activity.name).to eq(activity.name)
          expect(copied_activity.description).to eq(activity.description)
          expect(copied_activity.equipment).to eq(activity.equipment)
          expect(copied_activity.ismakeahead).to eq(activity.ismakeahead)
          expect(copied_activity.iscompetetion).to eq(activity.iscompetetion)
          expect(copied_activity.identifier).to eq(activity.identifier)
          expect(copied_activity.max_team_size).to eq(activity.max_team_size)

          expect(copied_activity2.name).to eq(activity2.name)
          expect(copied_activity2.description).to eq(activity2.description)
          expect(copied_activity2.equipment).to eq(activity2.equipment)
          expect(copied_activity2.ismakeahead).to eq(activity2.ismakeahead)
          expect(copied_activity2.iscompetetion).to eq(activity2.iscompetetion)
          expect(copied_activity2.identifier).to eq(activity2.identifier)
          expect(copied_activity2.max_team_size).to eq(activity2.max_team_size)
        end

        it "if multiple activities are selected from different events" do
          check "event_1"
          check "activity_1"
          check "activity_2"
          events = all(".event-collapse")
          events[1].click
          check "activity_4"
          check "activity_5"
          click_button "Submit"


          copied_event = Event.find(3)
          activity = Activity.first
          activity2 = Activity.find(2)
          activity3 = Activity.find(4)
          activity4 = Activity.find(5)
          copied_activity = copied_event.activities.first
          copied_activity2 = copied_event.activities[1]
          copied_activity3 = copied_event.activities[2]
          copied_activity4 = copied_event.activities[3]

          expect(copied_event.activities.length).to eq(4)
          expect(copied_activity.name).to eq(activity.name)
          expect(copied_activity.description).to eq(activity.description)
          expect(copied_activity.equipment).to eq(activity.equipment)
          expect(copied_activity.ismakeahead).to eq(activity.ismakeahead)
          expect(copied_activity.iscompetetion).to eq(activity.iscompetetion)
          expect(copied_activity.identifier).to eq(activity.identifier)
          expect(copied_activity.max_team_size).to eq(activity.max_team_size)

          expect(copied_activity2.name).to eq(activity2.name)
          expect(copied_activity2.description).to eq(activity2.description)
          expect(copied_activity2.equipment).to eq(activity2.equipment)
          expect(copied_activity2.ismakeahead).to eq(activity2.ismakeahead)
          expect(copied_activity2.iscompetetion).to eq(activity2.iscompetetion)
          expect(copied_activity2.identifier).to eq(activity2.identifier)
          expect(copied_activity2.max_team_size).to eq(activity2.max_team_size)

          expect(copied_activity3.name).to eq(activity3.name)
          expect(copied_activity3.description).to eq(activity3.description)
          expect(copied_activity3.equipment).to eq(activity3.equipment)
          expect(copied_activity3.ismakeahead).to eq(activity3.ismakeahead)
          expect(copied_activity3.iscompetetion).to eq(activity3.iscompetetion)
          expect(copied_activity3.identifier).to eq(activity3.identifier)
          expect(copied_activity3.max_team_size).to eq(activity3.max_team_size)

          expect(copied_activity4.name).to eq(activity4.name)
          expect(copied_activity4.description).to eq(activity4.description)
          expect(copied_activity4.equipment).to eq(activity4.equipment)
          expect(copied_activity4.ismakeahead).to eq(activity4.ismakeahead)
          expect(copied_activity4.iscompetetion).to eq(activity4.iscompetetion)
          expect(copied_activity4.identifier).to eq(activity4.identifier)
          expect(copied_activity4.max_team_size).to eq(activity4.max_team_size)
        end
      end

      context "should fail" do
        it "if multiple events are selected" do
          check "event_1"
          sleep(3)
          check "event_2"
          click_button("Submit")
          expect(page).to have_content("You can only copy 1 event.")
        end

        it "if no events are selected" do
          events = all(".event-collapse")
          events[0].click
          check "activity_1"
          click_button "Submit"
          expect(page).to have_content("You can only copy 1 event.")
        end

      end
    end

    context "should fail" do

      it "should fail if event name is missing" do
        within("form") do
          fill_in "description", with: "Stem Day"
          fill_in "start_date", with: "2020-04-05"
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        click_button "Save and Continue"
        expect(page).to have_content("Name can't be blank")
      end

      it "should fail if description is missing" do
        within("form") do
          fill_in "name", with: "BengalEventsAgain"
          fill_in "start_date", with: "2020-04-05"
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        click_button "Save and Continue"
        expect(page).to have_content("Description can't be blank")
      end

      it "should fail if start date is missing" do
        within("form") do
          fill_in "name", with: "BengalEventsAgain"
          fill_in "description", with: "Stem Day"
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        click_button "Save and Continue"
        expect(page).to have_content("Start date can't be blank")
      end


      it "should fail if locations are not filled" do
        within("form") do
          fill_in "name", with: "BengalEventsAgain"
          fill_in "description", with: "Stem Day"
          fill_in "start_date", with: "2020-04-05"
        end
        click_button "Save and Continue"
        expect(page).to have_content("Location name can't be blank")
      end

      it "should fail if room # is not filled" do
        within("form") do
          fill_in "name", with: "BengalEventsAgain"
          fill_in "start_date", with: "2020-04-05"
          fill_in "description", with: "Stem Day"
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
        end
        click_button "Save and Continue"
        expect(page).to have_content("Room number can't be blank")
      end

    end
  end

  context "update event" do
   before(:each) do
     @coordinator = User.find(8)
     @event = Event.first

     login_as(@coordinator)
     visit edit_event_path(@event)
   end

   it "should be successful when name is changed" do
     within("form") do
       fill_in "name", with: "BengalEventsAgain"
     end
     click_button 'Update'
     expect(page).to have_content("Successfully Updated " + "BengalEventsAgain")
     expect(Event.first.name).to eq("BengalEventsAgain")
   end

   it "should be successful when description is changed" do
     within("form") do
       fill_in "description", with: "Stem Day Will Be Updated"
     end
     click_button 'Update'
     expect(page).to have_content("Successfully Updated " + @event.name)
     expect(Event.first.description).to eq("Stem Day Will Be Updated")
   end

   it "should be successful when start date is changed" do
     within("form") do
       fill_in "start_date", with: "2020-04-05"
       find(:xpath, ".//input[@value='Bengal Stem Day']").click
     end
     click_button 'Update'
     expect(page).to have_content("Successfully Updated Bengal Stem Day")
   end

   it "should fail without name" do
     within('form') do
       fill_in "name", with: ""
     end
     click_button "Update"
     expect(page).to have_content "Name can't be blank"
   end

   it "should fail without description" do
     within('form') do
       fill_in "description", with: ""
     end
     click_button "Update"
     expect(page).to have_content "Description can't be blank"
   end

   it "should fail without start_date" do
     within('form') do
       fill_in "start_date", with: ""
       find(:xpath, ".//input[@value='Bengal Stem Day']").click
     end
     click_button "Update"
     expect(page).to have_content "Start date can't be blank"
   end
  end

  context "destroy event" do
   before(:each) do
     @coordinator = User.find(8)
     @event = Event.first

     login_as(@coordinator)
     visit profile_path(@coordinator)
   end

   it "should be successful" do
     find('a', match: :first, text: "Delete").click
     page.driver.browser.switch_to.alert.accept
     expect(page).to have_content("Successfully Deleted Event")
   end
    
    it "should delete all activities and sessions" do 
      find('a', match: :first, text: "Delete").click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Successfully Deleted Event")
      expect(Event.exists?(1)).to eq(false)
      expect(Activity.exists?(1)).to eq(false)
      expect(Activity.exists?(2)).to eq(false)
      expect(Activity.exists?(3)).to eq(false)
      expect(Session.exists?(1)).to eq(false)
      expect(Session.exists?(2)).to eq(false)
      expect(Session.exists?(3)).to eq(false)
      expect(Session.exists?(4)).to eq(false)
      expect(Session.exists?(5)).to eq(false)
    end
  end
end
