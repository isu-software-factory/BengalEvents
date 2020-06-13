require 'rails_helper'

RSpec.feature "Settings", type: :feature do

  context "First Time Configuration" do
    before(:each) do
      Setting.first.delete
      Setup.first.delete
    end

    it "should redirect user to admin page for first time" do
      visit root_path
      expect(page).to have_content("Admin Setup")
    end

    it "should generate a Settings and Setup record" do
      pending("...")
      fail
    end

    it "should set default Settings" do
      pending("...")
      fail
    end

    it "should update primary_color successfully" do
      pending("...")
      fail
    end

    it "should update secondary_color successfully" do
      pending("...")
      fail
    end

    it "should update additional_color successfully" do
      pending("...")
      fail
    end

    it "should update font successfully" do
      pending("...")
      fail
    end

    it "should update site_name successfully" do
      pending("...")
      fail
    end

    it "should update logo successfully" do
      pending("...")
      fail
    end

  end

  context "Normal Configuration Update" do
    it "should update primary_color successfully" do
      pending("...")
      fail
    end

    it "should update secondary_color successfully" do
      pending("...")
      fail
    end

    it "should update additional_color successfully" do
      pending("...")
      fail
    end

    it "should update font successfully" do
      pending("...")
      fail
    end

    it "should update site_name successfully" do
      pending("...")
      fail
    end

    it "should update logo successfully" do
      pending("...")
      fail
    end
  end

end
