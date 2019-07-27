require 'rails_helper'

RSpec.feature "Occasions", type: :feature do
  context "create new occasion" do
    before(:each) do
      Warden.test_reset!
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "sup@gmail.com", password: "password" })
      login_as(@coordinator.user, :scope => :user)
      visit new_occasion_path
      within('form') do
        fill_in "occasion[start_date]", with: Time.now
        fill_in "occasion[end_date]", with: Time.now
      end
    end

    scenario "should be successful" do
      within('form') do
        fill_in "occasion[name]", with: "BengalEvents"
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
      @occasion = @coordinator.occasions.build(name: "Bengal Events", start_date: Time.now, end_date: Time.now)
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

  context "destroy coordinator" do
    scenario "should be successful" do
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "pasl@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "Bengal Events", start_date: Time.now, end_date: Time.now)
      @occasion.save
      login_as(@coordinator.user, :scope => :user)
      visit occasions_path
      click_link "Delete"
      expect(page).to have_content "Occasions"
    end
  end
end
