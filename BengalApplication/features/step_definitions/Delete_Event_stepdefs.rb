Given("Sponsor is logged in and at sponsor page") do
  # create sponsor and event
  @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
  @occasion.save
  @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
  @event.occasion = @occasion
  @event.save
  @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23)
  @event_detail.save

  # login and go to sponsor page
  login_as(@sponsor.user, :scope => :user)
  visit "sponsors/#{@sponsor.id}"
end

When("Sponsor clicks go to events") do
  click_link "Go to Events"
end

When("Sponsor clicks Show on an Occasion") do
  click_link "Show"
end

When("Sponsor clicks Delete on an event") do
  click_link "Delete"
end

Then("Event will be deleted") do
  events = Event.all
  expect(events.first).to eq(nil)
end

Then("Sponsor won't have that event") do
  expect(@sponsor.events.count).to eq(0)
end

