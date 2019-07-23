require 'rails_helper'
include Warden::Test::Helpers
RSpec.feature "Events", type: :feature do
  context "create new event" do
    before(:each) do
      Warden.test_reset!
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "sup@gmail.com", password: "password" })
      @coordinator.occasions.create(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      sponsor = Sponsor.create(name: "Sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      login_as(sponsor.user, :scope => :user)
      visit new_occasion_event_path(1)
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

  context "update an event" do
    before(:each) do
      # create event
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.save
    end
    scenario "should be successful" do
      login_as(@sponsor.user, :scope => :user)

      visit edit_occasion_event_path(occasion_id: @occasion.id, id: @event.id)
      within('form') do
        fill_in "event[name]", with: "Biology"
        fill_in "event[location]", with: "SUB"
        fill_in "event[description]", with: "Science"
      end
        click_button "Confirm"
        expect(page).to have_content("Biology")
    end
    scenario "should fail" do
      login_as(@sponsor.user, :scope => :user)

      visit edit_occasion_event_path(occasion_id: @occasion.id, id: @event.id)
      within('form') do
        fill_in "event[name]", with: ""
        fill_in "event[location]", with: "SUB"
        fill_in "event[description]", with: "Science"
      end
      click_button "Confirm"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "destroy event" do
    before(:each) do
      # create event
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.save
    end

    scenario "should be successful" do
      login_as(@sponsor.user, :scope => :user)
      visit occasion_path(@occasion.id)
      #click destroy
      expect{click_link 'Destroy'}.to change(Event, :count).by(-1)
      expect(page).to have_content "Event was successfully deleted"
    end
  end
end
