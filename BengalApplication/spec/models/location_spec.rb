require 'rails_helper'

RSpec.describe Location, type: :model do
  context "Validation Tests" do

    it "ensures location name" do
      location = Location.new(address: "235 S Ave").save
      expect(location).to eq(false)
    end

    it "should create a location successfully" do
      location = Location.new(location_name: "SUB", address: "235 S Ave").save
      expect(location).to eq(true)
    end
  end

  context "Association Tests" do
    before(:each) do
      @location = Location.first
      @room = Room.first
      @room2 = Room.find(2)
    end

    it "should have many rooms" do
      expect(@location.rooms.include?(@room)).to eq(true)
      expect(@location.rooms.include?(@room2)).to eq(true)
    end
  end
end
