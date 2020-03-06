require 'rails_helper'

RSpec.feature "EventDetails", type: :feature do

  context "create a new event detail" do
    before do
      @occasion = occasions(:one)
      @location = locations(:one)
      @event = events(:one)
      @event.location = @location
      @sponsor = sponsors(:sponsor_carlos)
      # log in
      login_as(@sponsor.user)
      visit new_occasion_event_event_detail_path(@occasion, @event)
    end

    it "should successfully create an event detail" do
      within("form") do
        fill_in "event_detail[capacity]", with: 10
        select("2019-06-25", from: 'selectDate')
        select("19:05", from: 'selectStartTime')
        select("22:05", from: 'selectEndTime')
      end
      click_button "Create"
      expect(page).to have_content("Successfully created Event Session")
    end

    it "should fail to create an event detail" do
      within("form") do
        select("2019-06-25", from: 'selectDate')
        select("22:05", from: 'selectStartTime')
        select("23:05", from: 'selectEndTime')
      end
      click_button "Create"
      expect(page).to have_content("Capacity can't be blank")
    end
  end

  # context "update event detail" do
  #   before do
  #     @occasion = events(:one)
  #     @location = locations(:one)
  #     @event = activities(:one)
  #     @event.location = @location
  #     @event_detail = sessions(:one)
  #     @sponsor = sponsors(:sponsor_carlos)
  #     # log in
  #     login_as(@sponsor.user)
  #     visit edit_occasion_event_event_detail_path(occasion_id: @occasion.id, event_id: @event.id, id: @event_detail.id)
  #   end
  #
  #   it "should update successfully" do
  #     within("form") do
  #       fill_in "event_detail[capacity]", with: 10
  #     end
  #     click_button "Create"
  #     expect(page).to have_content("Successfully updated.")
  #   end
  #
  #   it "should fail to update" do
  #     within("form") do
  #       fill_in "event_detail[capacity]", with: ""
  #     end
  #     click_button "Create"
  #     expect(page).to have_content("Capacity can't be blank")
  #   end
  # end


  context "delete event detail" do
    before do
      @occasion = occasions(:one)
      @event = events(:three)
      @coordinator = coordinators(:coordinator_rebeca)
      # log in
      login_as(@coordinator.user)
      visit occasion_activity_path(occasion_id: @occasion.id, id: @event.id)
    end

    it "should successfully delete" do
      expect(page).to have_content("Time Slots")
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Successfully deleted time slot")
    end
  end
end
