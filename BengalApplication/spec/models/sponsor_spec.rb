require 'rails_helper'


RSpec.describe Sponsor, type: :model do
  context "association tests" do
    it "should create an event in an occasion" do
      occasion = Occasion.create(name: "BenagelEvent", start_date: 2/23/2019, end_date: 3/23/2019)
      event = Event.create(name: "robotics", location: "SUB", description: "For people interesting in Robotics.", isMakeAhead: true)
      event.occasion = occasion

      sponsor = Sponsor.new
      sponsor.save
      sponsor.event = event

      expect(sponsor.event.name).to eq("robotics")
    end

    it "should have a user" do
      pending
    end
  end
end
