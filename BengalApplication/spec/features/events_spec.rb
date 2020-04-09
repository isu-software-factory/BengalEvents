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

      scenario "should be successful without location address" do
        within('form') do
          fill_in "location_1", with: "SUB"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      scenario "should be successful with location address" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      scenario "should be successful without room name" do
        within('form') do
          fill_in "location_1", with: "SUB"
          fill_in "room_number_New_1", with: 232
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      scenario "should be successful with all fields filled in" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      scenario "should successfully create many rooms in one location" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        first(:xpath, "//button[@title='Add A New Room']").click
        within("form") do
          fill_in "room_number_2", with: 322
        end
        first(:xpath, "//button[@title='Add A New Room']").click
        within("form") do
          fill_in "room_number_3", with: 212
        end
        click_button 'Save and Continue'
        expect(Location.last.rooms.count).to eq(3)
      end

      scenario "should successfully create many locations and rooms" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_1", with: "Caffe"
        end
        first(:xpath, "//button[@title='Add A New Room']").click
        within("form") do
          fill_in "room_number_2", with: 322
        end
        first(:xpath, "//button[@title='Add A New Location']").click
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

    context "should fail" do

      scenario "should fail if event name is missing" do
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

      scenario "should fail if description is missing" do
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

      scenario "should fail if start date is missing" do
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


      scenario "should fail if locations are not filled" do
        within("form") do
          fill_in "name", with: "BengalEventsAgain"
          fill_in "description", with: "Stem Day"
          fill_in "start_date", with: "2020-04-05"
        end
        click_button "Save and Continue"
        expect(page).to have_content("Location name can't be blank")
      end

      scenario "should fail if room # is not filled" do
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

   scenario "should be successful when name is changed" do
     within("form") do
       fill_in "name", with: "BengalEventsAgain"
     end
     click_button 'Update'
     expect(page).to have_content("Successfully Updated " + "BengalEventsAgain")
     expect(Event.first.name).to eq("BengalEventsAgain")
   end

   scenario "should be successful when description is changed" do
     within("form") do
       fill_in "description", with: "Stem Day Will Be Updated"
     end
     click_button 'Update'
     expect(page).to have_content("Successfully Updated " + @event.name)
     expect(Event.first.description).to eq("Stem Day Will Be Updated")
   end

   scenario "should be successful when start date is changed" do
     within("form") do
       fill_in "start_date", with: "2020-04-05"
       fill_in "name", with: "BengalEventsAgain"
     end
     click_button 'Update'
     expect(page).to have_content("Successfully Updated BengalEventsAgain")
   end

   scenario "should fail without name" do
     within('form') do
       fill_in "name", with: ""
     end
     click_button "Update"
     expect(page).to have_content "Name can't be blank"
   end

   scenario "should fail without description" do
     within('form') do
       fill_in "description", with: ""
     end
     click_button "Update"
     expect(page).to have_content "Description can't be blank"
   end

   scenario "should fail without start_date" do
     within('form') do
       fill_in "start_date", with: ""
       fill_in "name", with: "BengalEventsAgain"
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

   scenario "should be successful" do
     find('a', match: :first, text: "Delete").click
     page.driver.browser.switch_to.alert.accept
     expect(page).to have_content("Successfully Deleted Event")
   end
  end
end
