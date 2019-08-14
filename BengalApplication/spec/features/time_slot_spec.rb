require 'rails_helper'

RSpec.feature "TimeSlots", type: :feature do
  # Not going to implement
  # context "GET #index" do
  #   before do
  #     @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  #     @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
  #     @occasion.save
  #     @location = @occasion.locations.build(name: "Gym")
  #     @location.save
  #     @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
  #     @time_slot.save
  #   end
  #   it "should successfully get index of time slots" do
  #     login_as(@coordinator.user)
  #     visit occasion_location_time_slot_path(occasion_id: @occasion.id, location_id: @location.id)
  #     expect(page).to have_content("Time Slots")
  #   end
  # end
  context "create new time_slot" do
    before do
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
    end
    it "should successfully create a time slot" do
      login_as(@coordinator.user)
      visit new_occasion_location_time_slot_path(occasion_id: @occasion.id, location_id: @location.id)
      # fill form
      within("form") do
        fill_in "time_slot[interval]", with: 60
        select("12", from: 'time_slot_start_time_4i')
        select("00", from: 'time_slot_start_time_5i')
        select("12", from: 'time_slot_end_time_4i')
        select("00", from: 'time_slot_end_time_4i')
      end
      click_button "Create"
      expect(page).to have_content("Create Time Slots")
    end
    it "should fail to create a time slot" do
      login_as(@coordinator.user)
      visit new_occasion_location_time_slot_path(occasion_id: @occasion.id, location_id: @location.id)
      # fill form
      within("form") do
        fill_in "time_slot[interval]", with: ""
        select("12", from: 'time_slot_start_time_4i')
        select("00", from: 'time_slot_start_time_5i')
        select("12", from: 'time_slot_end_time_4i')
        select("00", from: 'time_slot_end_time_4i')
      end
      click_button "Create"
      expect(page).to have_content("Interval can't be blank")
    end
  end
  context "delete time_slot" do
    before do
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
    end
    it "should successfully delete time slot" do
      login_as(@coordinator.user)
      visit occasion_location_path(occasion_id: @occasion.id, location_id: @location.id, id: @time_slot.id)

      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Successfully deleted time slot")
    end
  end

end
