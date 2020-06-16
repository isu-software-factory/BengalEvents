require 'rails_helper'

RSpec.describe Setup, type: :model do
  context "On create" do
    it "should default configure to false" do
      s = Setup.create()
      expect(s.configure).to eq(false)
    end
  end
end
