require 'rails_helper'

RSpec.feature "Registrations", type: :feature do
  context "register for sessions" do
    before(:each) do
      @teacher = User.first
      @student = User.find(2)
      @student2 = User.find(3)
      @session = Session.find(4)
      login_as(@student2)
      visit root_path(role: "User", id: @student2.id)
    end

    it "click on checkbox to register for activity, should be successful" do
      # click first row
      first(".event-collapse").click()
      check "register"
      expect(first(".registered")).to have_content("Registered")
    end

    it "should not allow due to double registration" do
      first(".event-collapse").click()
      check "register"
      expect(first(".registered")).not_to have_field("register")
    end

    it "should fail due to full capacity" do
      # capacity left is 1 - teacher = 0
      @session.register_participant(@teacher)
      first(".event-collapse").sibling(".event-collapse").click()
      check "register"

      # Alert box
      expect(page).to have_content("Activity capacity is full. Register for a different Activity.")
    end
  end


  context "activities method" do
    before(:each) do
      @student = User.find(2)
      @team = Team.first
      login_as(@student)
    end

    it "should display list of non competition activities only to users" do
      visit root_path(role: "User", id: @student.id)
      expect(page).to have_content("Bengal Stem Day")
      expect(page).to have_content("Robotics")
      expect(page).to have_content("Raspberry Pi")
    end

    it "should display list of competition activities only to teams" do
      visit "events/index/Team/1"
      expect(page).to have_content("Bengal Stem Day")
      expect(page).to have_content("Developing A Game")
    end
  end

  context "drop method" do
    before(:each) do
      @teacher = User.find(2)
      login_as(@teacher)
      visit root_path(role: "User", id: @teacher.id)
    end

    it "should successfully remove participant from event" do
      first(".event-collapse").click()
      expect(first(".registered")).to have_content("Registered")
      # click the unregister button
      find('.remove-button').click()

      expect(first(".registered")).not_to have_content("Registered")
    end
  end

end
