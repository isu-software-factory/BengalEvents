

Given("Sponsor is at event edit page") do
  # create coordinator, occasion, sponsor, event, and event details
  @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Stem Day")
  @occasion.save
  @location = @occasion.locations.build(name: "Gym")
  @location.save
  @location2 = @occasion.locations.build(name: "Stadium")
  @location2.save
  @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
  @event = @sponsor.events.build(name: "Robotics", description: "great")
  @event.occasion = @occasion
  @event.location = @location
  @event.save
  @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 10, date_started: @occasion.start_date)
  @event_detail.save

  # sign in and go to event edit page
  login_as(@sponsor.user)
  visit "occasions/#{@occasion.id}/events/#{@event.id}/edit"
end

When("Sponsor selects a different location") do
  # select location
  within("form") do
    select("Stadium", from: "event_location_id")
  end
  click_button "Confirm"
end

Then("The location of every event time slot will have the same location") do
  expect(Event.first.location.name).to eq("Stadium")
end

