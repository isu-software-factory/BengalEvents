require 'rails_helper'

RSpec.feature "Occasions", type: :feature do
  context "create new occasion" do
    before(:each) do
      Warden.test_reset!
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "sup@gmail.com", password: "password" })
      login_as(@coordinator.user, :scope => :user)
      visit new_occasion_path
      within('form') do
        fill_in "occasion[start_date]", with: "2019/09/01"
        fill_in "occasion[end_date]", with: "2019/09/05"
      end
    end

    scenario "should be successful" do
      within('form') do
        fill_in "occasion[name]", with: "BengalEvents"
        fill_in "occasion[description]", with: "Stem Day"
      end
      click_button 'Create'
      expect(page).to have_content("Occasions")

    end

    scenario "should fail" do
      click_button "Create"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "update occasion" do
    before do
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "pasl@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "Bengal Events", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      login_as(@coordinator.user, :scope => :user)
    end
    scenario "should be successful" do
      visit edit_occasion_path(@occasion)
      within("form")do
        fill_in "occasion[name]", with: "Bengal"
      end
      click_button 'Create'
      expect(page).to have_content("Occasions")
    end

    scenario "should fail" do
      visit edit_occasion_path(@occasion)
      within('form') do
        fill_in "occasion[name]", with: ""
      end
      click_button "Create"
      expect(page).to have_content "Name can't be blank"
    end
  end

  context "destroy occasion" do
    before(:each) do
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "pasl@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "Bengal Events", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      login_as(@coordinator.user, :scope => :user)
      visit occasions_path
    end
    scenario "should be successful" do
      expect(Occasion.count).to eq(1)
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "Occasions"
      expect(Occasion.count).to eq(0)
    end
  end
end
