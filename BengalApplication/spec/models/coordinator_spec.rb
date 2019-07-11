require 'rails_helper'

RSpec.describe Coordinator, type: :model do
  context "association tests" do
    it "should have a user" do
      coordinator = Coordinator.create(user_attributes: {email: "pasl@gmail.com", password: "password"})
      expect(coordinator.user).to_no eq(nil)
    end

    it "should have an occasion" do
      coordinator = Coordinator.create
      occasion = Occasion.create(name: "BenagelEvent", start_date: 2/23/2019, end_date: 3/23/2019)
      occasion.coordinator = coordinator

      expect(occasion.coordinator).not_to eq(nil)

    end
  end
end
