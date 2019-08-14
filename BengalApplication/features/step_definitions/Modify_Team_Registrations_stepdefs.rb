

Given("Team lead is at team page") do
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
  @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 10, date_started: @occasion.start_date)
  @event_detail.save

  # login and go to team page
  login_as(@student.user)
  visit "teams/#{@team.id}"
end

When("Team lead clicks drop button by member info") do
  click_button "Drop"
end

Then("Team will have one less member") do
  expect(Team.first.students.count).to eq(1)
end

Given("Team lead is at team page and team is registered for an event") do
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
  @team = Team.create(name: "Tigers", lead: @student.id, participant_attributes:{})
  @team.register_member(@student)
  @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 10, date_started: @occasion.start_date)
  @event_detail.save
  # register team for event
  @event_detail.register_participant(@team.participant)

  # login and go to team page
  login_as(@student.user)
  visit "teams/#{@team.id}"
end

When("Team lead clicks drop button by event info") do
  click_button("Drop")
end

Then("Team will have one less event registered") do
  expect(Team.first.participant.event_details.count).to eq(0)
end

