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
      expect(page).to have_content("Upcoming Activities")
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

  context "all user profiles" do
    before(:each) do
      @coordinator = User.find(9)
      login_as(@coordinator)
      visit all_users_path
    end

    it "Should successfully delete any user" do
      first(".btn-danger").click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Successfully Deleted User")
    end
  end

  context "coordinator and admin controls" do
    before(:each) do
      @admin = User.find(9)
      login_as @admin
      visit profile_path(@admin)
    end
    it "can hide an event for users manually" do
      expect(Event.first.visible).to eq(true)
      uncheck "check_visible"
      sleep(2)
      expect(Event.first.visible).to eq(false)
    end
    
    it "can show an event for users manually" do
      expect(Event.first.visible).to eq(true)
      uncheck "check_visible"
      sleep(2)
      expect(Event.first.visible).to eq(false)
      sleep(1)
      check "check_visible"
      sleep(2)
      expect(Event.first.visible).to eq(true)
    end
  end

  context "new admin" do
    before(:each) do
      @admin = User.find(9)
      login_as @admin
      visit profile_path(@admin)

      button=all(".dropdown-toggle").last
      button.click
      option=find("a", text: "Admin")
      option.click
      sleep(1)
    end
    it "create a new admin successfully" do
      within('form') do
        fill_in "first_name", with: 'Daniel'
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielAdmin@gmail.com"
        fill_in "user_name", with: "AdminnD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button 'Create Account'
      expect(page).to have_content("Successfully Created Admin")
    end

    it "should fail if name is missing" do
      within('form') do
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielAdmin@gmail.com"
        fill_in "user_name", with: "AdD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("First name can't be blank")
    end

    it "should fail if last name is missing" do
      within('form') do
        fill_in "first_name", with: "Daniel"
        fill_in "email", with: "danielAdmin@gmail.com"
        fill_in "user_name", with: "AdD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("Last name can't be blank")
    end

    it "should fail if username is missing" do
      within('form') do
        fill_in "first_name", with: "Daniel"
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielAdmin@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("User name can't be blank")
    end

    it "should fail if name is missing" do
      within('form') do
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielAdmin@gmail.com"
        fill_in "user_name", with: "AdD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("First name can't be blank")
    end



    it "should fail if password is missing" do
      within('form') do
        fill_in "first_name", with: 'Daniel'
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielAdmin@gmail.com"
        fill_in "user_name", with: "AdD234"
        fill_in "password_confirmation", with: "password"
      end
      click_button 'Create Account'
      expect(page).to have_content("Password can't be blank")
    end
  end

  context "create new coordinator" do
    before(:each) do
      @admin = User.find(9)
      login_as @admin
      visit profile_path(@admin)

      button=all(".dropdown-toggle").last
      button.click
      option=find("a", text: "Coordinator")
      option.click
      sleep(1)
    end

    it "create a new coordinator succesfully" do
      within('form') do
        fill_in "first_name", with: 'Daniel'
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielAdmin@gmail.com"
        fill_in "user_name", with: "AdminnD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button 'Create Account'
      expect(page).to have_content("Successfully Created Coordinator")
    end

    it "should fail if name is missing" do
      within('form') do
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielCor@gmail.com"
        fill_in "user_name", with: "CD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("First name can't be blank")
    end

    it "should fail if last name is missing" do
      within('form') do
        fill_in "first_name", with: "Daniel"
        fill_in "email", with: "danielCor@gmail.com"
        fill_in "user_name", with: "CD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("Last name can't be blank")
    end

    it "should fail if username is missing" do
      within('form') do
        fill_in "first_name", with: "Daniel"
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielCor@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("User name can't be blank")
    end

    it "should fail if name is missing" do
      within('form') do
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielCor@gmail.com"
        fill_in "user_name", with: "CD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("First name can't be blank")
    end



    it "should fail if password is missing" do
      within('form') do
        fill_in "first_name", with: 'Daniel'
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielCor@gmail.com"
        fill_in "user_name", with: "CD234"
        fill_in "password_confirmation", with: "password"
      end
      click_button 'Create Account'
      expect(page).to have_content("Password can't be blank")
    end
  end
end
