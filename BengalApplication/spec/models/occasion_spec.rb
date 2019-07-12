require 'rails_helper'

RSpec.describe Occasion, type: :model do
  context "validation tests" do
    it "ensures name" do
      occasion = Occasion.new(start_date: 2/23/2018, end_date: 2/19/2019).save
      expect(occasion).to eq(false)
    end

    it "ensures start date" do
      occasion = Occasion.new(name: "BengalEvent", end_date: 2/2/2019).save
      expect(occasion).to eq(false)
    end

    it "ensures end date" do
      occasion = Occasion.new(name: "BengalEvent", end_date: 2/2/2019).save
      expect(occasion).to eq(false)
    end
  end

  context "association tests" do
    let (:occasion) {Occasion.create(name: "BenagelEvent", start_date: 2/23/2019, end_date: 3/23/2019)}
    it "should have an event" do
      event = Event.new(name: "robotics", location: "SUB", description: "For people interesting in Robotics.", isMakeAhead: true)
      event.save
      event.occasion = occasion
      expect(event.occasion).not_to eq(nil)
    end

    it "should have a coordinator" do
      coordinator = Coordinator.new
      coordinator.save
      occasion.coordinator = coordinator
      expect(occasion.coordinator).not_to eq(nil)
    end
  end
end
