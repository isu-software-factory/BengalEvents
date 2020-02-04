require 'rails_helper'

RSpec.feature "Homeroutes", type: :feature do

  context "routing users" do
    before do
      @teacher = Teacher.create(name: "Sally", school: "Valley", student_count: 25, chaperone_count: 3, user_attributes: {email: "teacher@gmail.com", password: "password"}, participant_attributes: {})
      @student = @teacher.students.build(name: "Tim", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      @sponsor = Sponsor.create(name: "Bill", user_attributes: {email: "sponsor@gmail.com", password: "password"}, supervisor_attributes: {})
      @coordinator = Coordinator.create(name: "Kelly", user_attributes: {email: "coordinator@gmail.com", password: "password"}, supervisor_attributes: {})

      visit "homeroutes/home"
    end

    it "home sponsor" do
      # fill form
      within("form#sign_in") do
        fill_in "user[email]", with: "#{@sponsor.user.email}"
        fill_in "user[password]", with: "password"
      end
      click_button "Sign in"
      expect(page).to have_content(" #{@sponsor.name}")
    end

    it "home teacher" do
      # fill form
      within("form#sign_in") do
        fill_in "user[email]", with: "#{@teacher.user.email}"
        fill_in "user[password]", with: "password"
      end
      click_button "Sign in"
      expect(page).to have_content("#{@teacher.name}")
    end

    it "home coordinator" do
      # fill form
      within("form#sign_in") do
        fill_in "user[email]", with: "#{@coordinator.user.email}"
        fill_in "user[password]", with: "password"
      end
      click_button "Sign in"
      expect(page).to have_content("#{@coordinator.name}")
    end

    it "home student" do
      # fill form
      within("form#sign_in") do
        fill_in "user[email]", with: "#{@student.user.email}"
        fill_in "user[password]", with: "password"
      end
      click_button "Sign in"
      expect(page).to have_content("#{@student.name}")
    end

    it "home to homeroutes home page" do
      visit "homeroutes/home"
      expect(page).to have_content("Upcoming Events")
    end
  end
end
