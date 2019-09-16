require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  fixtures :locations, :time_slots

  context "Validation tests" do
    before do
      @location = locations(:one)
      @start_time = Time.new(2019,06,25, 02,22,22)
      @end_time = Time.new(2019,06,26, 04,22,22)
    end

    it "ensures start time" do
      @time_slot = @location.time_slots.build(end_time: @end_time, interval: 60).save
      expect(@time_slot).to eq(false)
    end

    it "ensures end time" do
      @time_slot = @location.time_slots.build(start_time: @start_time, interval: 60).save
      expect(@time_slot).to eq(false)
    end

    it "ensures interval" do
      @time_slot = @location.time_slots.build(start_time: @start_time, end_time: @end_time).save
      expect(@time_slot).to eq(false)
    end

    it "should create time slot successfully" do
      @time_slot = @location.time_slots.build(start_time: @start_time, end_time: @end_time, interval: 60).save
      expect(@time_slot).to eq(true)
    end
  end

  context "association tests" do
    before do
      @location = locations(:one)
      @time_slot = time_slots(:one)
    end

    it "should have a location" do
      expect(@time_slot.location).to eq(@location)
    end
  end
end
