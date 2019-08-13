require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  context "Validation tests" do
    before do
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Event")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
    end
    it "ensures start time" do
      @time_slot = @location.time_slots.build(end_time: Time.now, interval: 60).save
      expect(@time_slot).to eq(false)
    end
    it "ensures end time" do
      @time_slot = @location.time_slots.build(start_time: Time.now, interval: 60).save
      expect(@time_slot).to eq(false)
    end
    it "ensures interval" do
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now).save
      expect(@time_slot).to eq(false)
    end
    it "should create time slot successfully" do
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60).save
      expect(@time_slot).to eq(true)
    end
  end

  context "association tests" do
    before do
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
    end
    it "should have a location" do
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save

      expect(@time_slot.location).not_to eq(nil)
    end
  end
end
