require 'rails_helper'

RSpec.feature "Occasions", type: :feature do
  fixtures :coordinators, :users, :occasions

  context "create new occasion" do
    before(:each) do
      Warden.test_reset!
      @coordinator = coordinators(:coordinator_rebeca)
      login_as(@coordinator.user)

      visit new_occasion_path
      within('form') do
        select("2019", from: "occasion[start_date(1i)]")
        select("September", from: "occasion[start_date(2i)]")
        select("23", from: "occasion[start_date(3i)]")
        select("2019", from: "occasion[end_date(1i)]")
        select("October", from: "occasion[end_date(2i)]")
        select("23", from: "occasion[end_date(3i)]")
      end
    end

    scenario "should be successful" do
      within('form') do
        fill_in "occasion[name]", with: "BengalEvents"
        fill_in "occasion[description]", with: "Stem Day"
      end
      click_button 'Create'
      expect(page).to have_content("Fill in the details.")

    end

    scenario "should fail" do
      click_button "Create"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "update occasion" do
    before do
      @coordinator = coordinators(:coordinator_rebeca)
      @occasion = occasions(:one)

      login_as(@coordinator.user)
      visit edit_occasion_path(@occasion)
    end

    scenario "should be successful" do
      within("form")do
        fill_in "occasion[name]", with: "Bengal"
      end
      click_button 'Create'
      expect(page).to have_content("Occasions")
    end

    scenario "should fail" do
      within('form') do
        fill_in "occasion[name]", with: ""
      end
      click_button "Create"
      expect(page).to have_content "Name can't be blank"
    end
  end

  context "destroy occasion" do
    before(:each) do
      @coordinator = coordinators(:coordinator_rebeca)
      @occasion = occasions(:one)

      login_as(@coordinator.user)
      visit coordinator_path(@coordinator.id)
    end
    scenario "should be successful" do
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Successfully Deleted Occasion.")
    end
  end
end
