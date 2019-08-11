require 'rails_helper'


RSpec.describe Sponsor, type: :model do
  context "validation tests" do
    it "ensures name" do
      sponsor = Sponsor.new(user_attributes: {email: "dcan@gmail.com", password: "password"}).save
      expect(sponsor).to eq(false)
    end

    it "should be created successfully" do
      sponsor = Sponsor.new(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"}).save
      expect(sponsor).to eq(true)
    end
  end
  context "association tests" do
    before do
      @coordinator = Coordinator.create(name: "coord", user_attributes: {email: "coord@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvent", end_date: Time.now, start_date: Time.now, description: "Event")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym", start_time: Time.now, end_time: Time.now)
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
    end
    it "can have an event" do
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.save
      expect(@event.sponsor.id).to eq(@sponsor.id)
    end

    it "should have a user" do
      expect(@sponsor.user.id).not_to eq(nil)
    end
  end
end
