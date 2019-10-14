require 'rails_helper'

RSpec.feature "Registrations", type: :feature do
  fixtures :waitlists, :event_details, :users, :participants, :occasions, :supervisors, :events
  context "register for event_details" do
    before do
      @teacher = Teacher.create(name: "Em", student_count: 23, chaperone_count: 4, school: "pocatello", user_attributes: {email: "te@gmail.com", password: "password"}, participant_attributes: {})
      @student = @teacher.students.build(name: "Bill", user_attributes: {email: "stu@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      @student2 = @teacher.students.build(name: "Billy", user_attributes: {email: "stud@gmail.com", password: "password"}, participant_attributes: {})
      @student2.save
      @occasion = occasions(:two)
      @event_detail = event_details(:six)
      login_as(@teacher.user)
    end

    it "click on registration link to register for event, should be successful" do
      visit "registrations/events/#{@teacher.participant.id}/#{@occasion.id}"
      page.execute_script %Q{ $('#hide_down').removeClass('hide').addClass('show')}
      click_button("Register")
      expect(page).to have_content("#{@teacher.name}")
    end

    it "should fail due to double registration" do
      @event_detail.register_participant(@teacher.participant)
      visit "registrations/events/#{@teacher.participant.id}/#{@occasion.id}"

      page.execute_script %Q{ $('#hide_down').removeClass('hide').addClass('show')}
      click_button "Register"

      expect(page).to have_content("You are already registered for this event")
    end

    it "should fail due to full capacity" do
      @event_detail.register_participant(@student.participant)
      @event_detail.register_participant(@student2.participant)
      visit "registrations/events/#{@teacher.participant.id}/#{@occasion.id}"

      page.execute_script %Q{ $('#hide_down').removeClass('hide').addClass('show')}
      click_button "Register"

      expect(page).to have_content("Event capacity is full. Register for a different event.")
    end
  end

  context "index method" do
    before do
      @occasion = occasions(:two)
      @event_detail = event_details(:six)
      @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
    end

    it 'should redirect user to list of events to register' do
      login_as(@teacher.user)
      visit "registrations/index/#{@teacher.participant.id}"
      click_link "ASM"
      expect(page).to have_content("Events")
    end
  end

  context "events method" do
    before do
      @occasion = occasions(:two)
      @event = events(:three)
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
      @occasion = occasions(:two)
      @event_detail = event_details(:six)
      @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
      @event_detail.register_participant(@teacher.participant)
    end

    it "should successfully remove participant from event" do
      login_as(@teacher.user)
      visit "teachers/#{@teacher.id}"
      expect(page).to have_content("Computers")

      click_button "Drop"
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content("Computers")
    end
  end

  context "Waitlist method" do
    before do
      @occasion = occasions(:two)
      @event_detail = event_details(:six)
      @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
      @student = @teacher.students.build(name: "Dan", user_attributes: {email: "student@gmail.com", password: 'password'}, participant_attributes: {})
      @student.save
      @student2 = @teacher.students.build(name: "Tim", user_attributes: {email: "student2@gmail.com", password: 'password'}, participant_attributes: {})
      @student2.save
      login_as(@teacher.user)
    end

    it "will add the teacher to the waitlist successfully" do
      @event_detail.register_participant(@student.participant)
      @event_detail.register_participant(@student2.participant)

      visit "registrations/events/#{@teacher.participant.id}/#{@occasion.id}"
      page.execute_script %Q{ $('#hide_down').removeClass('hide').addClass('show')}

      click_button("Add to WaitList")
      expect(page).to have_content("You have been added to the WaitList")
    end
  end
end
