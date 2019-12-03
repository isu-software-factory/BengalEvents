require 'rails_helper'

RSpec.describe Occasion, type: :model do
  fixtures :coordinators, :events, :coordinators, :locations, :occasions

  context "validation tests" do
    before do
      @coordinator = coordinators(:coordinator_rebeca)
      @start_time = Time.new(2019,01,03, 01,02,23)
      @end_time = Time.new(2019, 03,04, 02,02,23 )
    end

    it "ensures name" do
      occasion = @coordinator.occasions.build(start_date: @start_time, description: "Events").save
      expect(occasion).to eq(false)
    end

    it "ensures start date" do
      occasion = @coordinator.occasions.build(name: "BengalEvent", description: "Events").save
      expect(occasion).to eq(false)
    end

    it "ensures description" do
      occasion = @coordinator.occasions.build(name: "BengalEvent", start_date: @start_time).save
      expect(occasion).to eq(false)
    end

    it "should be created successfully" do
      occasion = @coordinator.occasions.build(name: "BengalEvent", start_date: @start_time, description: "Events").save
      expect(occasion).to eq(true)
    end

  end

  context "association tests" do
    before do
      @event = events(:one)
      @occasion = occasions(:one)
      @coordinator = coordinators(:coordinator_rebeca)
      @location = locations(:one)
    end


    it "should have an event" do
      expect(@occasion.events.first).to eq(@event)
    end

    it "should have a coordinator" do
      expect(@occasion.coordinator).to eq(@coordinator)
    end

    it "can have a location" do
      expect(@occasion.locations.first).to eq(@location)
    end
  end

end
