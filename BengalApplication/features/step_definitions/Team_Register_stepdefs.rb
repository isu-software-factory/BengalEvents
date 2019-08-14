
Given("Team lead is in team page") do
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
  @student2 = @teacher.students.build(name: "Ben", user_attributes: {email: "b@gmail.com", password: "password"}, participant_attributes: {})
  @student2.save
  @team = Team.create(name: "Tigers", lead: @student.id, participant_attributes:{})
  @team.register_member(@student)
  @team.register_member(@student2)
  @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 10, date_started: @occasion.start_date)
  @event_detail.save
  # log in and go to team page
  login_as(@student.user, :scope => :user)
  visit "teams/#{@team.id}"
end

Given("Team lead clicks on register link") do
  # click on register link
  click_link "Register for events as a team"
end

Given("Team lead chooses an occasion") do
  # click on an occasion
  click_link "BengalEvents"
end

When("Team lead clicks register for event detail") do
  # click register link
  expect(@event_detail).to_not eq(nil)
  expect(@event).to_not eq(nil)
  expect(page).to have_content("10")
  click_link "Register"
end

Then("Team is registered for event") do
  # team should have one event detail
  expect(@team.participant.event_details.count).to eq(1)
end

Then("Team lead is redirected back to team page") do
  # should be in team page
  expect(page).to have_content("Team #{@team.name}")
end

