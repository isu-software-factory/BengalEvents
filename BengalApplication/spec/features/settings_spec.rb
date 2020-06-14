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
      visit root_path
      expect(Setting.first).to_not eq(nil)
      expect(Setup.first).to_not eq(nil)
    end

    it "should set default Settings" do
      visit root_path
      @setting = Setting.first
      expect(@setting.primary_color).to eq("#6d6e71")
      expect(@setting.secondary_color).to eq("#f47920")
      expect(@setting.additional_color).to eq("#f69240")
      expect(@setting.font).to eq("Arial")
      expect(@setting.site_name).to eq("Bengal Stem Day")
    end

    it "should create an admin successfully" do
      visit root_path
      within("form") do
        fill_in "first_name", with: "Admin"
        fill_in "last_name", with: "Admin"
        fill_in "user_name", with: "Admin"
        fill_in "email", with: "add@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Next"
      expect(User.find_by(first_name: "Admin").roles.first.role_name).to eq("Admin")
    end

    it "should send user to settings page after admin page" do
      visit root_path
      within("form") do
        fill_in "first_name", with: "Admin"
        fill_in "last_name", with: "Admin"
        fill_in "user_name", with: "Adminasdls"
        fill_in "email", with: "addscass@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Next"
      expect(page).to have_content("School Information Input")
    end

    it "should update primary_color successfully" do
      visit root_path
      within("form") do
        fill_in "first_name", with: "Admin"
        fill_in "last_name", with: "Admin"
        fill_in "user_name", with: "Admin"
        fill_in "email", with: "add@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Next"

      fill_in "primary_color", with: "#f20230"
      click_button "Save and Continue"
      expect(Setting.first.primary_color).to eq("#f20230")
    end

    it "should update secondary_color successfully" do
      visit root_path
      within("form") do
        fill_in "first_name", with: "Admin"
        fill_in "last_name", with: "Admin"
        fill_in "user_name", with: "Admin"
        fill_in "email", with: "add@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Next"

      fill_in "secondary_color", with: "#f20230"
      click_button "Save and Continue"
      expect(Setting.first.secondary_color).to eq("#f20230")
    end

    it "should update additional_color successfully" do
      visit root_path
      within("form") do
        fill_in "first_name", with: "Admin"
        fill_in "last_name", with: "Admin"
        fill_in "user_name", with: "Admin"
        fill_in "email", with: "add@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Next"

      fill_in "additional_color", with: "#f20230"
      click_button "Save and Continue"
      expect(Setting.first.additional_color).to eq("#f20230")
    end

    it "should update font successfully" do
      visit root_path
      within("form") do
        fill_in "first_name", with: "Admin"
        fill_in "last_name", with: "Admin"
        fill_in "user_name", with: "Admin"
        fill_in "email", with: "add@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Next"

      select "Times", from: "font"
      click_button "Save and Continue"
      expect(Setting.first.font).to eq("Times")
    end

    it "should update site_name successfully" do
      visit root_path
      within("form") do
        fill_in "first_name", with: "Admin"
        fill_in "last_name", with: "Admin"
        fill_in "user_name", with: "Admin"
        fill_in "email", with: "add@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Next"

      fill_in "site_name", with: "Stem Day"
      click_button "Save and Continue"
      expect(Setting.first.site_name).to eq("Stem Day")
    end

  end

  context "Normal Configuration Update" do
    before(:each) do
      @user = User.find(8)
      login_as @user
      visit edit_settings_path
    end

    it "should update primary_color successfully" do
      fill_in "primary_color", with: "#f20230"
      click_button "Save and Continue"
      expect(Setting.first.primary_color).to eq("#f20230")
    end

    it "should update secondary_color successfully" do
      fill_in "secondary_color", with: "#f20230"
      click_button "Save and Continue"
      expect(Setting.first.secondary_color).to eq("#f20230")
    end

    it "should update additional_color successfully" do
      fill_in "additional_color", with: "#f20230"
      click_button "Save and Continue"
      expect(Setting.first.additional_color).to eq("#f20230")
    end

    it "should update font successfully" do
      select "Times", from: "font"
      click_button "Save and Continue"
      expect(Setting.first.font).to eq("Times")
    end

    it "should update site_name successfully" do
      fill_in "site_name", with: "Stem Day"
      click_button "Save and Continue"
      expect(Setting.first.site_name).to eq("Stem Day")
    end
  end

end
