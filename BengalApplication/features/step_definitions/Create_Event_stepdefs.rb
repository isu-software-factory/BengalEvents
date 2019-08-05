Given("Sponsor is at home page and clicks sign up as sponsor") do
  # go to home page
  visit "homeroutes/routes"
  click_link "Sign Up as Sponsor"
end

When("Sponsor fills out their information and clicks confirm") do
  # fill form
  within("form") do
    fill_in "sponsor[name]", with: "Jacob"
    fill_in "sponsor[user_attributes][email]", with: "sponsor@gmail.com"
    fill_in "sponsor[user_attributes][password]", with: "password"
    fill_in "sponsor[user_attributes][password_confirmation]", with: "password"
  end
  click_button "Confirm"
end

Then("Sponsor will be redirected to sponsor page") do
  expect(page).to have_content("Welcome, Jacob")
end



Given("Sponsor has account and is signed in") do
  # create an occasion
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
  @occasion.save

  # create sponsor
  @sponsor = Sponsor.create(name: "Jacob", user_attributes: {email: "sponsor@gmail.com", password: "password"})

  # sign in and go to sponsor page
  login_as(@sponsor.user, :scope => :user)
  visit "sponsors/#{@sponsor.id}"
end

When("Sponsor clicks Go to Events") do
  click_link "Go to Events"
end

When("Sponsor clicks Show on an occasion") do
  click_link "Show"
end

When("Sponsor clicks Create an event") do
  click_link "Create an Event"
end

When("Sponsor fills out Event information and clicks confirm") do
  # fill form
  within("form") do
    fill_in "event[name]", with: "Robotics"
    fill_in "event[location]", with: "Gym"
    fill_in "event[description]", with: "Robots are cool"
  end
  click_button "Confirm"
end

Then("Sponsor will have an event") do
  expect(@sponsor.events.count).to eq(1)
end



Given("Sponsor has account and event created and is at sponsor page") do
  # create sponsor, occasion, and event
  @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
  @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
  @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
  @occasion.save
  # create an event
  @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
  @event.occasion = @occasion
  @event.save

  # login and go to sponsor page
  login_as(@sponsor.user, :scope => :user)
  visit "sponsors/#{@occasion.id}"
end

Given("Sponsor goes to occasion page to see events") do
  click_link "Go to Events"
  click_link "Show"
end

When("Sponsor clicks edit on their event") do
  click_link "Edit"
end

When("Sponsor changes event information and clicks confirm") do
  # change form
  within("form") do
    fill_in "event[name]", with: "Biology"
  end
  click_button "Confirm"
end

Then("Event will be updated to what the Sponsor edited") do
  expect(page).to have_content("BengalEvents")
  expect(page).to have_content("Biology")
  event = Event.find(@sponsor.events.first.id)
  expect(event.name).to eq("Biology")
end
