require 'rails_helper'

RSpec.feature "Homeroutes", type: :feature do

  context "routing users" do
    before(:each) do
      @teacher = User.first
      @student = User.find(2)
      @sponsor = User.find(7)
      @coordinator = User.find(9)
      @admin = User.find(8)

      visit "homeroutes/home"
    end

    it "home to homeroutes home page" do
      visit "homeroutes/home"
      expect(page).to have_content("Upcoming Events")
    end

    context "signing in" do

      it "should sign in with username" do
        within("form#sign_in") do
          fill_in "user_login", with: "bil232"
          fill_in "user_password", with: "password"
        end
        click_button "Sign in"
        expect(page).to have_content("Bill")
      end

      it "should sign in with email" do
        within("form#sign_in") do
          fill_in "user_login", with: "bil@gmail.com"
          fill_in "user_password", with: "password"
        end
        click_button "Sign in"
        expect(page).to have_content("Bill")
      end

      it "should fail if username is incorrect" do
        within("form#sign_in") do
          fill_in "user_login", with: "bil23asd2"
          fill_in "user_password", with: "password"
        end
        click_button "Sign in"
        expect(page).to have_content("Invalid Username or email or password.")
      end

      it "should fail if email is incorrect" do
        within("form#sign_in") do
          fill_in "user_login", with: "bil23@gmail.com"
          fill_in "user_password", with: "password"
        end
        click_button "Sign in"
        expect(page).to have_content("Invalid Username or email or password.")
      end

      it "should fail if password is incorrect" do
        within("form#sign_in") do
          fill_in "user_login", with: "bil232"
          fill_in "user_password", with: "passwasdfaord"
        end
        click_button "Sign in"
        expect(page).to have_content("Invalid Username or email or password.")
      end
    end
  end
end
