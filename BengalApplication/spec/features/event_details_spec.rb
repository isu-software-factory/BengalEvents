require 'rails_helper'

RSpec.feature "EventDetails", type: :feature do
  fixtures :sponsors, :users, :occasions, :events, :locations

  context "create a new event detail" do
    before do
      @occasion = occasions(:one)
      @location = locations(:one)
      @event = events(:one)
      @event.location = @location
      @sponsor = sponsors(:sponsor_carlos)
      # log in
      login_as(@sponsor.user)
      visit new_occasion_event_event_detail_path(@occasion, @event)
    end

    it "should successfully create an event detail" do
      within("form") do
        fill_in "event_detail[capacity]", with: 10
        select("2018-08-13", from: 'selectDate')
        select("00:00", from: 'selectStartTime')
        select("00:00", from: 'selectEndTime')
      end
      click_button "Create Event detail"
      expect(page).to have_content("Successfully create Event Session")
    end

    it "should fail to create an event detail" do
      within("form") do
        select(@time1, from: 'selectDate')
        select("00:00", from: 'selectStartTime')
        select("00:00", from: 'selectEndTime')
      end
      click_button "Create Event detail"
      expect(page).to have_content("Capacity can't be blank")
    end
  end

  context "update event detail" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem day")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
      @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, date_started: @occasion.start_date, capacity: 2)
      @event_detail.save
    end
    it "should update successfully" do
      login_as(@sponsor.user)
      visit edit_occasion_event_event_detail_path(occasion_id: @occasion.id, event_id: @event.id, id: @event_detail.id)
      within("form") do
        fill_in "event_detail[capacity]", with: 10
      end
      click_button "Update Event detail"
      expect(page).to have_content("Successfully updated.")
    end
    it "should fail to update" do
      login_as(@sponsor.user)
      visit edit_occasion_event_event_detail_path(occasion_id: @occasion.id, event_id: @event.id, id: @event_detail.id)
      within("form") do
        fill_in "event_detail[capacity]", with: ""
      end
      click_button "Update Event detail"
      expect(page).to have_content("Capacity can't be blank")
    end
  end
  context "delete event detail" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
      @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, date_started: @occasion.start_date, capacity: 2)
      @event_detail.save
    end
    it "should successfully delete" do
      login_as(@sponsor.user)
      visit occasion_event_path(occasion_id: @occasion.id, id: @event_detail.id)
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Successfully deleted time slot")
    end
  end
end
