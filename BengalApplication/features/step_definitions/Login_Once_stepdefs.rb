
Given("Coordinator is already signed in and goes to occasions page") do
  # create coordinator
  @coordinator = Coordinator.create(name: "Sam", user_attributes: {email: "c@gmail.com", password: "password"})
  # sign in and go to coordinator page
  login_as(@coordinator.user, :scope => :user)
  visit "coordinators/#{@coordinator.id}"
end

When("Coordinator clicks to create a new occasion") do
  click_link "Occasion Home Page"
end

Then("Coordinator is redirected to create an occasion without having to login") do
  expect(page).to have_content("Create New Occasion")
end


Given("Sponsor is already signed in and goes to occasions page") do
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
  @occasion.save
  @location = @occasion.locations.build(name: "Gym")
  @location.save
  # create sponsor
  @sponsor = Sponsor.create(name: "Ben", user_attributes: {email: "s@gmail.com", password: "password"})
  # sign in and go to sponsor page
  login_as(@sponsor.user, :scope => :user)
  visit "sponsors/#{@sponsor.id}"
end

When("Sponsor clicks to create an event") do
  # click link to go to events
  click_link("Go to Events")
  click_link("Show")
  click_link("Create an event")
end

Then("Sponsor is redirected to create an event without having to login") do
  expect(page).to have_content("Create an Event under this BengalEvents Occasion")
end

Given("Teacher is already signed in") do
  @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
  @occasion.save
  @location = @occasion.locations.build(name: "Gym")
  @location.save
  @event = @sponsor.events.build(name: "Robotics", description: "great")
  @event.occasion = @occasion
  @event.location = @location
  @event.save
  @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23)
  @event_detail.save
  # create teacher
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  # sign in and go to teacher page
  login_as(@teacher.user, :scope => :user)
  visit "teachers/#{@teacher.id}"
end

When("Teacher clicks registration link") do
  # click register link
  click_link "Register for events"
  click_link "BengalEvents"
end

Then("Teacher is redirected to register without having to login") do
  expect(page).to have_content("Events")
end

Given("Student is already signed in") do
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
  # create teacher
  @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
  # create student
  @student = @teacher.students.build(name: "Ben", user_attributes: {email: "ben@gmail.com", password: "password"}, participant_attributes: {})
  @student.save
  # sign in and go to student page
  login_as(@student.user, :scope => :user)
  visit "students/#{@student.id}"
end

When("Student clicks registration link") do
  # click in register link
  click_link "Register for Events"
  click_link "BengalEvents"
end

Then("Student is redirected to register without having to login") do
  expect(page).to have_content("Events")
end
