require 'rails_helper'

RSpec.describe Waitlist, type: :model do
  fixtures :event_details, :waitlists, :participants

  context "association tests" do
    before do
      @event_detail = event_details(:one)
      @waitlist = waitlists(:one)
      @participant = participants(:teacher)
    end

    it "has an event_detail" do
      expect(@waitlist.event_detail).to eq(@event_detail)
    end

    it "can have a participant" do
      expect(@waitlist.participants.first).to eq(@participant)
    end
  end


end
