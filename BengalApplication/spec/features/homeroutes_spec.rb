require 'rails_helper'

RSpec.feature "Homeroutes", type: :feature do

  context "routing users" do
    before do
      @teacher = Teacher.create(name: "Sally", school: "Valley", student_count: 25, chaperone_count: 3, user_attributes: {email: "teacher@gmail.com", password: "password"}, participant_attributes: {})
      @student = @teacher.students.build(name: "Tim", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      @sponsor = Sponsor.create(name: "Bill", user_attributes: {email: "sponsor@gmail.com", password: "password"}, supervisor_attributes: {})
      @coordinator = Coordinator.create(name: "Kelly", user_attributes: {email: "coordinator@gmail.com", password: "password"}, supervisor_attributes: {})

      visit "homeroutes/routes"
    end

    it "routes sponsor" do
      # fill form
      within("form#sign_in") do
        fill_in "user[email]", with: "#{@sponsor.user.email}"
        fill_in "user[password]", with: "password"
      end
      click_button "Sign in"
      expect(page).to have_content(" #{@sponsor.name}")
    end

    it "routes teacher" do
      # fill form
      within("form#sign_in") do
        fill_in "user[email]", with: "#{@teacher.user.email}"
        fill_in "user[password]", with: "password"
      end
      click_button "Sign in"
      expect(page).to have_content("#{@teacher.name}")
    end

    it "routes coordinator" do
      # fill form
      within("form#sign_in") do
        fill_in "user[email]", with: "#{@coordinator.user.email}"
        fill_in "user[password]", with: "password"
      end
      click_button "Sign in"
      expect(page).to have_content("#{@coordinator.name}")
    end

    it "routes student" do
      # fill form
      within("form#sign_in") do
        fill_in "user[email]", with: "#{@student.user.email}"
        fill_in "user[password]", with: "password"
      end
      click_button "Sign in"
      expect(page).to have_content("#{@student.name}")
    end

    it "routes to homeroutes routes page" do
      visit "homeroutes/routes"
      expect(page).to have_content("Upcoming Events")
    end
  end
end
