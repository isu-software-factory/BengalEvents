require 'rails_helper'

RSpec.feature "Sponsors", type: :feature do
  context "create new sponsor" do
    before(:each) do
      visit new_user_path("Sponsor")
    end

    it "should be successful" do
      within('form') do
        fill_in "first_name", with: 'Daniel'
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielSponsor@gmail.com"
        fill_in "user_name", with: "SponD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button 'Create Account'
      expect(page).to have_content("#{"Daniel"}")
    end

    it "should fail if name is missing" do
      within('form') do
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielSponsor@gmail.com"
        fill_in "user_name", with: "SponD234"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("First name can't be blank")
    end

    it "should fail if last name is missing" do
      within('form') do
        fill_in "first_name", with: "Daniel"
        fill_in "email", with: "danielSponsor@gmail.com"
        fill_in "user_name", with: "SponD234"
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
        fill_in "email", with: "danielSponsor@gmail.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
      end
      click_button "Create Account"
      expect(page).to have_content("User name can't be blank")
    end

    it "should fail if name is missing" do
      within('form') do
        fill_in "last_name", with: "Cano"
        fill_in "email", with: "danielSponsor@gmail.com"
        fill_in "user_name", with: "SponD234"
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
        fill_in "email", with: "danielSponsor@gmail.com"
        fill_in "user_name", with: "SponD234"
        fill_in "password_confirmation", with: "password"
      end
      click_button 'Create Account'
      expect(page).to have_content("Password can't be blank")
    end
  end


  context "update sponsor" do
    before do
      @sponsor = User.find(7)
      login_as(@sponsor)
      visit edit_user_registration_path(@sponsor)
    end

    it "should be successful when password is updated" do
      within("form#edit_user") do
        fill_in "user[password]", with: "password23"
        fill_in "user[password_confirmation]", with: "password23"
        fill_in "user[current_password]", with: "password"
      end
      click_button 'Update'
      expect(page).to have_content("Your account has been updated successfully.")
    end

    it "should fail without password" do
      within("form") do
        fill_in "user[password_confirmation]", with: "Password"
        fill_in "user[current_password]", with: "password"
      end
      click_button "Update"
      expect(page).to have_content("Password can't be blank")
    end

    it "should fail if passwords don't match" do
      within("form") do
        fill_in "user[password]", with: "Password"
        fill_in "user[password_confirmation]", with: "Psassword"
        fill_in "user[current_password]", with: "password"
      end
      click_button "Update"
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it "should fail if current password isn't valid" do
      within("form") do
        fill_in "user[password]", with: "Password"
        fill_in "user[password_confirmation]", with: "Password"
        fill_in "user[current_password]", with: "psassword"
      end
      click_button "Update"
      expect(page).to have_content("Current password is invalid")
    end
  end

end
