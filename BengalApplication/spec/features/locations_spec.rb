

RSpec.feature "Locations", type: :feature do

  context "Creating New Location" do
    before(:each) do
      @user = User.find(9)
      login_as(@user)
      visit manage_locations_path
    end

    it "should be successful" do
      click_link "Location"
      within("form") do
        fill_in "location", with: "Gift Shop"
        fill_in "address", with: ""
      end
      click_button "Submit"
      sleep(1)
      expect(page).to have_content("Gift Shop")
      expect(Location.all.count).to eq(2)
    end

    it "should fail without location name" do
      click_link "Location"
      click_button "Submit"
      expect(page).to have_content("Location name can't be blank")
    end
  end

  context "Edit Location" do
    before(:each) do
      @user = User.find(9)
      login_as(@user)
      visit manage_locations_path
    end

    it "should be successful" do
      click_link "Edit"
      within("form") do
        fill_in "location", with: "Gift Shop"
      end
      click_button "Submit"
      sleep(5)
      expect(page).to have_content("Gift Shop")
      expect(Location.first.location_name).to eq("Gift Shop")
    end

    it "should be successful when a room is update" do
      click_link "Edit"
      within("form") do
        fill_in "room_number_1", with: "1"
      end
      click_button "Submit"
      sleep(5)
      expect(Location.first.rooms.first.room_number).to eq(1)
    end

    it "should fail if a room number is left blank" do
      click_link "Edit"
      within("form") do
        fill_in "room_number_1", with: ""
      end
      click_button "Submit"
      expect(page).to have_content("Room number can't be blank")
    end
  end

  context "Create New Room" do
    before(:each) do
      @user = User.find(9)
      login_as(@user)
      visit manage_locations_path
    end

    it "should be successful" do
      click_link "Room"
      within("form") do
        fill_in "room_number", with: "23"
        fill_in "room_name", with: "BA"
      end
      click_button "Submit"
      sleep(3)
      expect(Room.all.count).to eq(4)
    end

    it "should fail if room number is blank" do
      click_link "Room"
      within("form") do
        fill_in "room_number", with: ""
        fill_in "room_name", with: "BA"
      end
      click_button "Submit"
      expect(page).to have_content("Room number can't be blank")
    end
  end

end
