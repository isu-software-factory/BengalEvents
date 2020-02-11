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
  end
end
