



Given("Student is at registration page and has register for {string}") do |string|
  # create student, teacher, team, coordinator, occasion, sponsor, event, and event details
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
  @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
  @student = @teacher.students.build(name: "Joe", user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {})
  @student.save
  @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 10, date_started: @occasion.start_date)
  @event_detail.save

  # student register for event
  @event_detail.participants << @student.participant

  # login and go to registration page
  login_as(@student.user, :scope => :user)
  visit "registrations/events/#{@student.participant.id}/#{@occasion.id}"
end

When("Student clicks register for Robotics") do
  click_link "Register"
end

Then("Student will see an error and will not be signed up for the event") do
  expect(page).to have_content("You are already registered for this event")
  expect(@student.participant.event_details.count).to eq(1)
end
