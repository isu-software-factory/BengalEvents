require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each)do
    @event = Event.first
    @activity = Activity.first
    @start_date = DateTime.new(2020,4,5,3)
  end

  context "Associations Test" do

    it "has activities" do
      expect(@event.activities.first). to eq(@activity)
    end

context "Validation Tests: " do

  it "validates name of the event" do
    @event = Event.new(name: " ", description: "Students gather around.", start_date: @start_date).save
    expect(@event). to eq(false)
  end

  it "validates description of the event" do
    @event = Event.new(name: "Stem Day ", description: "", start_date: @start_date).save
    expect(@event). to eq(false)
  end

  it "validates start date of the event" do
    @event = Event.new(name: "Stem Day ", description: "").save
    expect(@event). to eq(false)
  end

  it "successfully creates an event" do
    @event = Event.new(name: "Stem Day ", description: "Students gather around", start_date: @start_date).save
    expect(@event). to eq(true)
  end
end
    end
end
