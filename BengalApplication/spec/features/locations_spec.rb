require 'rails_helper'

RSpec.feature "Locations", type: :feature do
  context "GET #show" do
    before do
      @coordinator = Coordinator.create(name: "Emily", user_attributes: {email: "l@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "StemDay", start_date: Time.now, end_date: Time.now, description: "Science")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
    end
    it "should be successful" do
      login_as(@coordinator.user)
      visit occasion_location_path(occasion_id: @occasion.id, id: @location.id)
      expect(page).to have_content("Create Time Slots")
    end
  end
  # Will not be implemented
  # context "GET #index" do
  #   before do
  #     @coordinator = Coordinator.create(name: "Emily", user_attributes: {email: "l@gmail.com", password: "password"})
  #     @occasion = @coordinator.occasions.build(name: "StemDay", start_date: Time.now, end_date: Time.now, description: "Science")
  #     @occasion.save
  #     @location = @occasion.locations.build(name: "Gym")
  #     @location.save
  #   end
  #   it "should be successful" do
  #     login_as(@coordinator.user)
  #     visit occasion_location_path(occasion_id: @occasion.id)
  #     expect(page).to have_content("Locations")
  #   end
  # end
  context "create new location" do
    before do
      @coordinator = Coordinator.create(name: "Emily", user_attributes: {email: "l@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "StemDay", start_date: Time.now, end_date: Time.now, description: "Science")
      @occasion.save
    end
    it "should create a location successfully" do
      login_as(@coordinator.user)
      visit new_occasion_location_path(occasion_id: @occasion.id)
      # fill form
      within("form") do
        fill_in "location[name]", with: "Stadium"
      end
      click_button "Create"
      expect(page).to have_content("Successfully created Location.")
    end
    it "should fail to create a location" do
      login_as(@coordinator.user)
      visit new_occasion_location_path(occasion_id: @occasion.id)
      # fill form
      within("form") do
        fill_in "location[name]", with: ""
      end
      click_button "Create"
      expect(page).to have_content("Name can't be blank")
    end
  end
  context "update location" do
    before do
      @coordinator = Coordinator.create(name: "Emily", user_attributes: {email: "l@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "StemDay", start_date: Time.now, end_date: Time.now, description: "Science")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
    end
    it "should successfully update location" do
      login_as(@coordinator.user)
      visit edit_occasion_location_path(occasion_id: @occasion.id, id: @location.id)
      # fill form
      within("form") do
        fill_in "location[name]", with: "Stadium"
      end
      click_button "Create"
      expect(page).to have_content("Successfully updated Location.")
    end
    it "should fail to update location" do
      login_as(@coordinator.user)
      visit edit_occasion_location_path(occasion_id: @occasion.id, id: @location.id)
      # fill form
      within("form") do
        fill_in "location[name]", with: ""
      end
      click_button "Create"
      expect(page).to have_content("Name can't be blank")
    end
  end
  context "delete location" do
    before do
      @coordinator = Coordinator.create(name: "Emily", user_attributes: {email: "l@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "StemDay", start_date: Time.now, end_date: Time.now, description: "Science")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
    end
    it "should successfully delete a location" do
      login_as(@coordinator.user)
      visit occasions_path(occasion_id: @occasion.id)
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      #expect(Location.count).to eq(0)
      expect(page).to have_content("Successfully deleted Location.")
    end
  end
end
