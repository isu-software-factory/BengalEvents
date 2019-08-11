
Given("Team lead is in team page") do
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
  @team = Team.create(name: "Tigers", participant_attributes: {})
  @team.lead = @student.id
  @team.students << @student

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

