require 'rails_helper'


RSpec.describe Sponsor, type: :model do
  fixtures :coordinators, :occasions, :events, :event_details, :sponsors, :supervisors, :users

  context "validation tests" do
    it "ensures name" do
      sponsor = Sponsor.new(user_attributes: {email: "dcan@gmail.com", password: "password"}).save
      expect(sponsor).to eq(false)
    end

    it "should be created successfully" do
      sponsor = Sponsor.new(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"}).save
      expect(sponsor).to eq(true)
    end
  end


  context "association tests" do
    before do
      @sponsor = sponsors(:sponsor_carlos)
      @event = events(:two)
      @user = users(:sponsor)
      @supervisor = supervisors(:sponsor)
    end

    it "can have an event" do
      expect(@sponsor.supervisor.events.first).to eq(@event)
    end

    it "should have a user" do
      expect(@sponsor.user).to eq(@user)
    end

    it "should have a supervisor" do
      expect(@sponsor.supervisor).to eq(@supervisor)
    end
  end
end
