Given("User is at home page without being logged in") do
  # create an event detail
  @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
  @occasion.save
  @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
  @event.occasion = @occasion
  @event.save
  @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23)
  @event_detail.save
  # go to home page
  visit "homeroutes/routes"
end

Then("User can see EventDetails") do
  expect(page).to have_content(@event.name)
end
