require 'rails_helper'
include Warden::Test::Helpers
RSpec.feature "Events", type: :feature do
  context "create new event" do
    before(:each) do
      Warden.test_reset!
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "sup@gmail.com", password: "password" })
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Events")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      sponsor = Sponsor.create(name: "Sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      login_as(sponsor.user, :scope => :user)
      visit new_occasion_event_path(@occasion.id)
      within('form') do
       fill_in "event[name]", with: "Robotics"
       select("Gym", from: 'event[location_id]')
      end
    end

    scenario "should be successful" do
      within('form') do
       fill_in "event[description]", with: "Robots in the gym"
      end
      click_button 'Confirm'
      expect(page).to have_content("List of Events")

    end

    scenario "should fail" do
      click_button "Confirm"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "update an event" do
    before(:each) do
      # create event
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "sup@gmail.com", password: "password" })
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Events")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @location2 = @occasion.locations.build(name: "Stadium")
      @location2.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @sponsor = Sponsor.create(name: "Sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @event = @sponsor.events.build(name: "Robots", description: "Electronics")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
    end
    scenario "should be successful" do
      login_as(@sponsor.user, :scope => :user)
      visit edit_occasion_event_path(occasion_id: @occasion.id, id: @event.id)
      # fill form
      within('form') do
        fill_in "event[name]", with: "Biology"
        select("Stadium", from: 'event[location_id]')
        fill_in "event[description]", with: "Science"
      end
        click_button "Confirm"
        expect(page).to have_content("Biology")
        expect(page).to have_content("Stadium")
        expect(page).to have_content("Science")
    end
    scenario "should fail" do
      login_as(@sponsor.user, :scope => :user)
      visit edit_occasion_event_path(occasion_id: @occasion.id, id: @event.id)
      # fill form
      within('form') do
        fill_in "event[name]", with: ""
        select("Stadium", from: 'event[location_id]')
        fill_in "event[description]", with: "Science"
      end
      click_button "Confirm"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "destroy event" do
    before(:each) do
      # create event
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "sup@gmail.com", password: "password" })
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Events")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @sponsor = Sponsor.create(name: "Sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @event = @sponsor.events.build(name: "Robots", description: "Electronics")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
    end

    scenario "should be successful" do
      login_as(@sponsor.user, :scope => :user)
      visit occasion_path(@occasion.id)
      #click destroy
      expect(Event.count).to eq(1)
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      expect(Event.count).to eq(0)
      expect(page).to have_content "Event was successfully deleted"
    end
  end
end
