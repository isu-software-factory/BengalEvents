require 'rails_helper'

RSpec.describe Event, type: :model do
  context "validation tests" do
    it "ensures name" do
      event = Event.new(location: "gym", description: "in the gym").save
      expect(event).to eq(false)
    end
    it "ensures location" do
      event = Event.new(name: "robotics", description: "in the gym").save
      expect(event).to eq(false)
    end
    it "ensures description" do
      event = Event.new(location: "gym", name: "robotics").save
      expect(event).to eq(false)
    end
  end
  context "association tests" do
    it "should have an occasion" do
      occasion = Occasion.create(name: "BenagelEvent", start_date: 2/23/2019, end_date: 3/23/2019)
      event = Event.new(name: "robotics", location: "SUB", description: "For people interesting in Robotics.", isMakeAhead: true)
      event.save
      event.occasion = occasion
      expect(event.occasion).not_to eq(nil)
    end

    it "should have an event detail" do
      event = Event.create(name: "robotics", location: "SUB", description: "For people interesting in Robotics.", isMakeAhead: true)
      event_detail = EventDetail.create(capacity: 23, start_time: 2/23/2019, end_time: 2/23/2019)
      event.event_details << event_detail
    end
  end
end
