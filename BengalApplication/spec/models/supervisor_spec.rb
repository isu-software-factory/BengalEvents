require 'rails_helper'

RSpec.describe Supervisor, type: :model do
  fixtures :sponsors, :coordinators, :supervisors, :events

  context "association tests" do
    before do
      @sponsor = sponsors(:sponsor_carlos)
      @event = events(:one)
      @coordinator = coordinators(:coordinator_rebeca)
      @supervisor1 = supervisors(:coordinator)
      @supervisor2 = supervisors(:sponsor)
    end

    it "can have a sponsor" do
      expect(@supervisor2.director).to eq(@sponsor)
    end

    it "can have a coordinator" do
      expect(@supervisor1.director).to eq(@coordinator)
    end

    it "can have an event" do
      expect(@supervisor1.events.first).to eq(@event)
    end
  end
end
