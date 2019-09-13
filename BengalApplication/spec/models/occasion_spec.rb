require 'rails_helper'

RSpec.describe Occasion, type: :model do
  fixtures :coordinators

  context "validation tests" do
    before do
      @coordinator = coordinators(:coordinator_rebeca)
      @start_time = Time.new(2019,01,03, 01,02,23)
      @end_time = Time.new(2019, 03,04, )
    end

    it "ensures name" do
      occasion = @coordinator.occasions.build(start_date: Time.now, end_date: Time.now, description: "Events").save
      expect(occasion).to eq(false)
    end

    it "ensures start date" do
      occasion = @coordinator.occasions.build(name: "BengalEvent", end_date: Time.now, description: "Events").save
      expect(occasion).to eq(false)
    end

    it "ensures end date" do
      occasion = @coordinator.occasions.build(name: "BengalEvent", end_date: Time.now, description: "Events").save
      expect(occasion).to eq(false)
    end

    it "ensures description" do
      occasion = @coordinator.occasions.build(name: "BengalEvent", end_date: Time.now, start_date: Time.now).save
      expect(occasion).to eq(false)
    end
    it "should be created successfully" do
      occasion = @coordinator.occasions.build(name: "BengalEvent", start_date: Time.now, end_date: Time.now, description: "Events").save
      expect(occasion).to eq(true)
    end
  end

  context "association tests" do
    before do
      @coordinator = Coordinator.create(name: "coord", user_attributes: {email: "coord@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvent", start_date: Time.now, end_date: Time.now, description: "Events")
      @occasion.save
      @sponsor = Sponsor.create(name: "Sponsor", user_attributes: {email: "spon@gmail.com", password: "password"})
      @event = @sponsor.events.build(name: "robotics", description: "For people interesting in Robotics.")
      @event.occasion = @occasion
      @event.save
    end
    it "should have an event" do
      expect(@event.occasion.id).to eq(@occasion.id)
    end

    it "should have a coordinator" do
      expect(@occasion.coordinator.id).to eq(@coordinator.id)
    end

    it "can have a location" do
      location = @occasion.locations.build(name: "Gym")
      location.save
      expect(@occasion.locations.first).to eq(location)
    end
  end
  context "method tests" do
    context "start_date_before_end_date method" do
      before do
        @coordinator = Coordinator.create(name: "coord", user_attributes: {email: "coord@gmail.com", password: "password"})
      end
      it "should fail to create occasion wrong date position" do
        @occasion = @coordinator.occasions.build(name: "BengalEvents", end_date: Time.now, start_date: Time.now, description: "Events").save
        expect(@occasion).to eq(false)
      end
      it "should successfully create occasion with right date position" do
        @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Events").save
        expect(@occasion).to eq(true)
      end
    end
  end
end
