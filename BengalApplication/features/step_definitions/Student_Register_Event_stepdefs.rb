Given("Student is logged in and is at student page") do
  # create student and teacher
  # create event
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
