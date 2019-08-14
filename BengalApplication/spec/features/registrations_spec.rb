require 'rails_helper'

RSpec.feature "Registrations", type: :feature do
  context "register for event_details" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.location = @location
      @event.save
      @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 2, date_started: @occasion.start_date)
      @event_detail.save
      @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
      @student = @teacher.students.build(name: "Joe", user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      @student2 = @teacher.students.build(name: "Joey", user_attributes: {email: "ss@gmail.com", password: "password"}, participant_attributes: {})
      @student2.save
    end
    it "click on registration link to register for event, should be successful" do
      login_as(@teacher.user)
      visit "registrations/events/#{@teacher.participant.id}/#{@occasion.id}"
      click_link "Register"
      expect(page).to have_content("Teachers Main Page")
      expect(@teacher.participant.event_details.count).to eq(1)
    end
    it "should fail due to double registration" do
      login_as(@teacher.user, :scope => :user)
      @event_detail.register_participant(@teacher.participant)
      visit "registrations/events/#{@teacher.participant.id}/#{@occasion.id}"
      click_link "Register"
      expect(@teacher.participant.event_details.count).to eq(1)
      expect(page).to have_content("You are already registered for this event")
      logout(@teacher.user)
    end
    it "should fail due to full capacity" do
      login_as(@student2.user)
      @event_detail.register_participant(@student.participant)
      @event_detail.register_participant(@teacher.participant)
      visit "registrations/events/#{@student2.participant.id}/#{@occasion.id}"
      click_link "Register"
      expect(page).to have_content("Event capacity is full. Register for a different event.")
    end
  end
  context "index method" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.location = @location
      @event.save
      @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 2, date_started: @occasion.start_date)
      @event_detail.save
      @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
    end
    it 'should redirect user to list of events to register' do
      login_as(@teacher.user)
      visit "registrations/index/#{@teacher.participant.id}"
      click_link "BengalEvents"
      expect(page).to have_content("Events")
    end
  end
  context "events method" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.location = @location
      @event.save
      @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 2, date_started: @occasion.start_date)
      @event_detail.save
      @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
    end
    it "should display list of events to register" do
      login_as(@teacher.user)
      visit "registrations/events/#{@teacher.participant.id}/#{@occasion.id}"
      expect(page).to have_content(@event.name)
    end
  end
  context "drop method" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.location = @location
      @event.save
      @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 2, date_started: @occasion.start_date)
      @event_detail.save
      @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
      @event_detail.register_participant(@teacher.participant)
    end
    it "should successfully remove participant from event" do
      login_as(@teacher.user)
      visit "teachers/#{@teacher.id}"
      click_button "Drop"
      page.driver.browser.switch_to.alert.accept
      expect(@teacher.participant.event_details.count).to eq(0)
    end
  end
end
