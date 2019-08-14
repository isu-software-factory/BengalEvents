Given("Student is logged in and is at student page") do
  # create student and teacher
  # create event
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
  @student = @teacher.students.build(name: "Ben", user_attributes: {email: "ben@gmail.com", password: "password"}, participant_attributes: {})
  @student.save
  @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 10, date_started: @occasion.start_date)
  @event_detail.save

  # log in and go to student page
  login_as(@student.user, :scope => :user)
  visit "students/#{@student.id}"
end

When("Student clicks Register for Events") do
  click_link "Register for Events"
end

When("clicks an occasion") do
  click_link "BengalEvents"
end

When("clicks Register for an event detail") do
  click_link "Register"
end

Then("Student will be registered for that event") do
  expect(@student.participant.event_details.count).to eq(1)
end

Then("will be redirected to student page") do
  expect(page).to have_content("Welcome, #{@student.name}")
end
