

Given("Team member is at team page") do
  # time for event details
  @time1 = Time.now
  @time2 = Time.now
  # create two students and team
  # create events
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  @student = @teacher.students.build(name: "Ben", user_attributes: {email: "ben@gmail.com", password: "password"}, participant_attributes: {})
  @student.save
  @student2 = @teacher.students.build(name: "Lucas", user_attributes: {email: "lucas@gmail.com", password: "password"}, participant_attributes: {})
  @student2.save
  @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
  @occasion.save
  @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
  @event.occasion = @occasion
  @event.save
  @event_detail = @event.event_details.build(start_time: @time1, end_time: @time2, capacity: 23)
  @event_detail.save
  @team = Team.create(name: "Tigers", participant_attributes: {})
  @team.lead = @student.id
  @team.students << @student
  @team.students << @student2

  # Register team for event
  @team.participant.event_details << @event_detail

  # sign in as student2 and go to team page
  login_as(@student2.user, :scope => :user)
  visit "teams/#{@team.id}"
end

Then("Team member can see team's registered schedule for events") do
  # page should have
  # event details name
  expect(page).to have_content(@event.name)
  # start time
  expect(page).to have_content(@time1)
  # end time
  expect(page).to have_content(@time2)
  # location
  expect(page).to have_content(@event.location)
  # description
  expect(page).to have_content(@event.description)
end
