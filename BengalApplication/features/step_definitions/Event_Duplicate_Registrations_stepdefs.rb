



Given("Student is at registration page and has register for {string}") do |string|
  # create student, teacher, team, coordinator, occasion, sponsor, event, and event details
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  @student = @teacher.students.build(name: "Ben", user_attributes: {email: "ben@gmail.com", password: "password"}, participant_attributes: {})
  @student.save
  @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
  @occasion.save
  @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
  @event.occasion = @occasion
  @event.save
  @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23)
  @event_detail.save

  # student register for event
  @event_detail.participants << @student.participant

  # login and go to registration page
  login_as(@student.user, :scope => :user)
  visit "registrations/events/#{@student.participant.id}/#{@event.id}"
end

When("Student clicks register for Robotics") do
  click_link "Register"
end

Then("Student will see an error and will not be signed up for the event") do
  expect(page).to have_content("You are already registered for this event")
  expect(@student.participant.event_details.count).to eq(1)
end
