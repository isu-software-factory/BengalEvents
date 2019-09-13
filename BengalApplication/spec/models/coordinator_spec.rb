require 'rails_helper'

RSpec.describe Coordinator, type: :model do
  fixtures :coordinators, :users, :supervisors, :events, :occasions

  context "validation tests" do
    it "ensures coordinator has a name" do
      coordinator = Coordinator.new(user_attributes: {email: "coor@gmail.com", password: "password"}).save
      expect(coordinator).to eq(false)
    end
    it "should create coordinator successfully" do
      coordinator = Coordinator.new(name: "Sally", user_attributes: {email: "c@gmail.com", password:"password"}).save
      expect(coordinator).to eq(true)
    end
  end
  
  
  context "association tests" do
    before do
      @coordinator = coordinators(:coordinator_rebeca)
    end
    it "should have a user" do
      expect(@coordinator.user.id).not_to eq(nil)
    end

    it "should have a supervisor" do
      expect(@coordinator.supervisor).not_to eq(nil)
    end

    it "can have an event" do
      expect(@coordinator.supervisor.events.first).not_to eq(nil)
    end

    it "can have an occasion" do
      expect(@coordinator.occasions.first).not_to eq(nil)
    end
  end
end
