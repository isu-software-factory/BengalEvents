require 'rails_helper'

RSpec.describe Location, type: :model do
  context "validation tests" do
    it "ensures name of location" do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Event")
      @occasion.save
      @location = @occasion.locations.build(name: "").save
      expect(@location).to eq(false)
    end
    end
    it "should create location successfully" do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Event")
      @occasion.save
      expect(@coordinator.id).to eq(1)
    end
  end
  context "association tests" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.save
    end
    it "can have an event" do
      @event.location = @location
      expect(@event.location).to eq(@location)
    end
    it "can have a time slot" do
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save

      @location.time_slots << @time_slot
      expect(@location.time_slots.count).to eq(1)
    end
  end
