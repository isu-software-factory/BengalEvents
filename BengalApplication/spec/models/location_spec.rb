require 'rails_helper'

RSpec.describe Location, type: :model do
  fixtures :occasions, :locations, :time_slots, :events

  context "validation tests" do
    before do
      @occasion = occasions(:one)
    end


    it "ensures name of location" do
      @location = @occasion.locations.build(name: "").save
      expect(@location).to eq(false)
    end

    it "ensures the uniqueness of the name" do
      # name Gym has already been taken
      @location = @occasion.locations.build(name: "Gym").save
      expect(@location).to eq(false)
    end
    it "should create location successfully" do
      @location = @occasion.locations.build(name: "SUB").save
      expect(@location).to eq(true)
    end
  end

  context "association tests" do
    before do
      @location = locations(:one)
      @event = events(:one)
      @time_slot = time_slots(:one)
    end


    it "can have an event" do
      expect(@location.events.first).to eq(@event)
    end

    it "can have a time slot" do
      @location.time_slots << @time_slot
      expect(@location.time_slots.first).to eq(@time_slot)
    end
  end
end