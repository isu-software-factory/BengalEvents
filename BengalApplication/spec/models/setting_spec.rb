require 'rails_helper'

RSpec.describe Setting, type: :model do

  context "On Create Tests" do
    it "should default primary color to #6d6e71" do
      s = Setting.create()
      expect(s.primary_color).to eq("#6d6e71")
    end

    it "should default secondary_color to #f47920" do
      s = Setting.create()
      expect(s.secondary_color).to eq("#f47920")
    end

    it "should default additional_color to #f69240" do
      s = Setting.create()
      expect(s.additional_color).to eq("#f69240")
    end

    it "should default font to Arial" do
      s = Setting.create()
      expect(s.font).to eq("Arial")
    end

    it "should default site_name to Bengal Stem Day" do
      s = Setting.create()
      expect(s.site_name).to eq("Bengal Stem Day")
    end
  end

  context "method tests" do
    context "reset_default method" do
      it "should reset all data to default" do
        @setting = Setting.first
        @setting.update(primary_color: "#f32120", secondary_color: "#f21210", additional_color: "#f12320", font: "Times New Roman", site_name: "Stem Day")
        @setting.reset_default

        expect(@setting.primary_color).to eq("#6d6e71")
        expect(@setting.secondary_color).to eq("#f47920")
        expect(@setting.additional_color).to eq("#f69240")
        expect(@setting.font).to eq("Arial")
        expect(@setting.site_name).to eq("Bengal Stem Day")
      end
    end
  end
end

