require 'rails_helper'

RSpec.describe Activity, type: :model do
  context "Associations Test" do

    before(:each ) do
      @event = Event.first
      @activity = Activity.first
      @session = Session.first
      @user = User.first
    end

    it "has an event" do
      expect(@activity.event).to eq(@event)
    end

    it "has many sessions" do
      expect(@activity.sessions.first).to eq(@session)
    end

    it "belongs to a user" do
      #expect(@activity.user.)
    end


  end
end
