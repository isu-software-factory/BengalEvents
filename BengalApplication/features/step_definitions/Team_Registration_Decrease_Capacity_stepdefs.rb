





Given("Team member count is two and Event capacity is {int}") do |capacity|
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
  @student2 = @teacher.students.build(name: "Joey", user_attributes: {email: "ss@gmail.com", password: "password"}, participant_attributes: {})
  @student2.save
  @team = Team.create(name: "Tigers", lead: @student.id, participant_attributes:{})
  @team.register_member(@student)
  @team.register_member(@student2)
  @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: capacity, date_started: @occasion.start_date)
  @event_detail.save
end

Given("Team lead is at registration page") do
  # login and visit registration page as a team
  login_as(@student.user)
  visit "registrations/events/#{@team.participant.id}/#{@occasion.id}"
end

When("Team lead clicks on register link of an event") do
  # click link
  click_link "Register"
end

Then("Event capacity will be {int}") do |remaining|
  event_detail = EventDetail.first
  expect(event_detail.capacity_remaining).to eq(remaining)
end


