Given("Teacher clicks registration link on teacher page") do
  # create teacher
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
  @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 10, date_started: @occasion.start_date)
  @event_detail.save
  # sign in and go to teacher page
  login_as(@teacher.user, :scope => :user)
  visit "teachers/#{@teacher.id}"
  click_link "Register for events"
end

Given("Teacher clicks on an occasion") do
  click_link "BengalEvents"
end

When("Teacher clicks register on an event detail") do
  click_link "Register"
end

Then("Teacher will be registered for that event detail") do
  expect(@teacher.participant.event_details.count).to eq(1)
end

Then("Will be redirected to their teacher page") do
  expect(page).to have_content("Teachers Main Page")
end

