require 'rails_helper'

RSpec.feature "Events", type: :feature do
  context "create new event" do
    before(:each) do
      occasion = Occasion.create(start_date: 2/23/2018, end_date: 2/19/2019)
      visit new_occasion_event_url(:occasion_id => 1)
      within('form') do
        fill_in "event[name]", with: "Robtics"
        fill_in "event[location]", with: "Gym"
      end
    end

    scenario "should be successful" do
      within('form') do
        fill_in "event[description]", with: "Robots in the gym"
      end
      click_button 'Confirm'
      expect(page).to have_content("These are the lists of events under this occasion.")
    end

    scenario "should fail" do
      click_button "Confirm"
      expect(page).to have_content("Description can't be blank")
    end
  end
end
