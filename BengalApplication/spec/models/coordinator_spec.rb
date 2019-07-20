require 'rails_helper'

RSpec.describe Coordinator, type: :model do
  context "validation tests" do
    it "ensures coordinator has a name" do
      coordinator = Coordinator.create(user_attributes: {email: "coor@gmail.com", password: "password"})
      expect(coordinator.id).to eq(nil)
    end
  end
  context "association tests" do
    before do
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "pasl@gmail.com", password: "password"})
    end
    it "should have a user" do
      expect(@coordinator.user.id).not_to eq(nil)
    end

    it "should have an occasion" do
      occasion = @coordinator.occasions.build(name: "BenagelEvent", start_date: Time.now, end_date: Time.now)
      expect(occasion.coordinator.id).to eq(@coordinator.id)

    end
  end
end
