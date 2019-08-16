require 'rails_helper'

RSpec.feature "Homeroutes", type: :feature do
  context "routing users" do
    before do
      @teacher = Teacher.create(name: "teacher", school: "valley", student_count: 23, chaperone_count: 232, user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {})
      @student = @teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "g@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "c@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
    end
    it "routes sponsor" do
      login_as(@sponsor.user)

      visit "homeroutes/routes"
      expect(page).to have_content("Welcome, #{@sponsor.name}")
    end

    it "routes teacher" do
      login_as(@teacher.user)

      visit "homeroutes/routes"
      expect(page).to have_content("Teachers Main Page")
    end

    it "routes coordinator" do
      login_as(@coordinator.user)

      visit "homeroutes/routes"
      expect(page).to have_content("c@gmail.com")
    end

    it "routes student" do
      login_as(@student.user)

      visit "homeroutes/routes"
      expect(page).to have_content("Registration Details")
    end

    it "routes to homeroutes routes page" do
      visit "homeroutes/routes"
      expect(page).to have_content("Upcoming Events")
    end
  end
end
