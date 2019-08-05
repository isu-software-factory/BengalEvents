require 'rails_helper'

RSpec.feature "Registrations", type: :feature do
  context "register for event_details" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.save
      @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23)
      @event_detail.save
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
    end
    it "click on registration link to register for event" do
      login_as(@teacher.user)
      visit "registrations/events/#{@teacher.participant.id}/#{@occasion.id}"
      click_link "Register"
      expect(page).to have_content("Teachers main page")
      expect(@teacher.participant.event_details.count).to eq(1)
    end
  end
end
