require 'rails_helper'

RSpec.describe Event, type: :model do
  fixtures :sponsors, :occasions, :locations, :events, :event_details,
           :supervisors, :coordinators

  context "validation tests" do
    before do
      @sponsor = sponsors(:sponsor_carlos)
      @occasion = occasions(:one)
      @location = locations(:one)
    end


    it "ensures name" do
      event = @sponsor.supervisor.events.build(description: "great")
      event.occasion = @occasion
      event.location = @location
      e = event.save
      expect(e).to eq(false)
    end

    it "ensures description" do
      event = @sponsor.supervisor.events.build(name: "Robotics")
      event.occasion = @occasion
      event.location = @location
      e = event.save
      expect(e).to eq(false)
    end

    it "should successfully create an event" do
      event = @sponsor.supervisor.events.build(name: "Robotics", description: "great")
      event.occasion = @occasion
      event.location = @location
      e = event.save
      expect(e).to eq(true)
    end
  end

  context "association tests" do
    before do
      @sponsor = sponsors(:sponsor_carlos)
      @coordinator = coordinators(:coordinator_rebeca)
      @occasion = occasions(:one)
      @location = locations(:one)
      @event = events(:one)
      @event2 = events(:two)
      @event_detail = event_details(:one)
    end


    it "should have an occasion" do
      expect(@event.occasion).to eq(@occasion)
    end

    it "should have an event detail" do
      expect(@event.event_details.first).to eq(@event_detail)
    end

    it "should have a location" do
      expect(@event.location).not_to eq(nil)
    end

    it "can have a coordinator" do
      expect(@event.supervisor.director).to eq(@coordinator)
    end

    it "can have a sponsor" do
      expect(@event2.supervisor.director).to eq(@sponsor)
    end
  end
end
