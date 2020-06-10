require 'rails_helper'

RSpec.describe Activity, type: :model do

  before(:each ) do
    @event = Event.first
    @activity = Activity.first
    @session = Session.first
    @user = User.find(7)
  end

  context "Associations Test" do

    it "has an event" do
      expect(@activity.event).to eq(@event)
    end

    it "has many sessions" do
      expect(@activity.sessions.first).to eq(@session)
    end

    it "belongs to a user" do
      expect(@activity.user). to eq(@user)
    end
  end

  context "Validations Test" do
    # before(:each ) do
    #   @event = Event.first
    #   @activity = Activity.first
    #   @session = Session.first
    #   @user = User.first
    # end

    it "validates presence of name" do
    @activity = Activity.new(name: " ", description: "5v5", event_id: @event.id, user_id: @user.id).save
    expect(@activity). to eq(false)
    end

    it "validates presence of description" do
      @activity = Activity.new(name: "Bengal War", description: "", event_id: @event.id, user_id: @user.id).save
      expect(@activity). to eq(false)
    end

    it "validates presence of event" do
      @activity = Activity.new(name: "Bengal War", description: "5v5", user_id: @user.id).save
      expect(@activity). to eq(false)
    end

    it "validates presence of user" do
      @activity = Activity.new(name: "Bengal War", description: "5v5", event_id: @event.id).save
      expect(@activity). to eq(false)
    end

    it "validates success to create an activity" do
      @activity = Activity.new(name: "Bengal War", description: "5v5", event_id: @event.id, user_id: @user.id).save
      expect(@activity). to eq(true)
    end

    it "validates max team size if activity is a competition" do
      pending("...")
      fail
    end

    it "validates an identifier" do
      pending("...")
      fail
    end
  end

  context "method tests" do
    before(:each) do
      @activity = Activity.first
    end

    it "total_participants should return the total number of participants in an activity" do
      expect(@activity.total_participants).to eq(4)
    end

    context "has_session method" do
      it "should return true if activity has the given session" do
        pending("...")
        fail
      end

      it "should return false if activity does not have given session" do
        pending("...")
        fail
      end

      it "should return false if a non session type is given to method" do
        pending("...")
        fail
      end
    end
  end
end
