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
          fill_in "room_name_New_1", with: "Caffe"
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
          fill_in "room_name_New_1", with: "Caffe"
        end
        click_button 'Save and Continue'
        expect(page).to have_content("Activity Information")
      end

      scenario "should successfully create many rooms in one location" do
        within("form") do
          fill_in "location_1", with: "SUB"
          fill_in "address_1", with: "921 S 8th Ave, Pocatello, ID 83209"
          fill_in "room_number_New_1", with: 232
          fill_in "room_name_New_1", with: "Caffe"
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
          fill_in "room_name_New_1", with: "Caffe"
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
        expect(Room.all.count).to eq(5)
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
          fill_in "room_name_New_1", with: "Caffe"
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
          fill_in "room_name_New_1", with: "Caffe"
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
          fill_in "room_name_New_1", with: "Caffe"
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

  #context "update occasion" do
  #  before do
  #    @coordinator = coordinators(:coordinator_rebeca)
  #    @occasion = occasions(:one)
  #
  #    login_as(@coordinator.user)
  #    visit edit_event_path(@occasion)
  #  end
  #
  #  scenario "should be successful" do
  #    within("form") do
  #      fill_in "occasion[name]", with: "Bengal"
  #    end
  #    click_button 'Create'
  #    expect(page).to have_content("Occasions")
  #  end
  #
  #  scenario "should fail" do
  #    within('form') do
  #      fill_in "occasion[name]", with: ""
  #    end
  #    click_button "Create"
  #    expect(page).to have_content "Name can't be blank"
  #  end
  #end
  #
  #context "destroy occasion" do
  #  before(:each) do
  #    @coordinator = Coordinator.create(name: "Sam", user_attributes: {email: "Sam@gmail.com", password: "password"})
  #    @occasion = @coordinator.occasions.build(name: "Hal", description: "cool", start_date: Time.now)
  #
  #    login_as(@coordinator.user)
  #    visit coordinator_path(@coordinator.id)
  #  end
  #  scenario "should be successful" do
  #    #click_link('Delete', :match => :first)
  #    find('a', match: :first, text: "Delete").click
  #    page.driver.browser.switch_to.alert.accept
  #    expect(page).to have_content("Successfully Deleted Occasion.")
  #  end
  #end
end
