require 'rails_helper'

RSpec.describe Event, type: :model do
  context "validation tests" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @location = @occasion.locations.build(name: "Gym", start_time: Time.now, end_time: Time.now)
      @location.save
    end
    it "ensures name" do
      event = @sponsor.events.build(description: "great")
      event.occasion = @occasion
      event.location = @location
      event.save
      expect(event.id).to eq(nil)
    end
    it "ensures description" do
      event = @sponsor.events.build(name: "Robotics")
      event.occasion = @occasion
      event.location = @location
      event.save
      expect(event.id).to eq(nil)
    end
    it "should successfully create an event" do
      event = @sponsor.events.build(name: "Robotics", description: "great")
      event.occasion = @occasion
      event.location = @location
      event.save
      expect(event.id).not_to eq(nil)
    end
  end
  context "association tests" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @location = @occasion.locations.build(name: "Gym", start_time: Time.now, end_time: Time.now)
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
    end
    it "should have an occasion" do
      event = @sponsor.events.build( name: "Robotics", description: "great")
      event.occasion = @occasion
      event.save
      expect(event.occasion.id).not_to eq(nil)
    end

    it "should have an event detail" do
      event = @sponsor.events.build(name: "Robotics", description: "great")
      event.occasion = @occasion
      event.save
      event_detail = event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, date_started: @occasion.start_date, capacity: 23)
      event_detail.save
      expect(event_detail.event.id).to eq(event.id)
    end

    it "should have a location" do
      event = @sponsor.events.build( name: "Robotics", description: "great")
      event.occasion = @occasion
      event.location = @location
      event.save
    end
  end
end
