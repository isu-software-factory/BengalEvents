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

  context "teams registering" do
    before(:each) do
      @student = User.find(3)
      @student2 = User.find(4)
      @team = Team.find(2)
      @team2 = Team.find(3)
    end

    it "should not allow a team to register if the team restriction is not met" do
      login_as(@student)
      visit team_path(@team)
      click_link "Register For Activities"
      first(".event-collapse").click
      check "register"
      expect(page).to have_content("Your team does not meet the team size restriction")
    end

    it "should successfully register a team" do
      login_as(@student2)
      visit team_path(@team2)
      click_link "Register For Activities"
      first(".event-collapse").click
      check "register"
      expect(first(".registered")).to have_content("Registered")
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

    it "should successfully remove participant from session" do
      first(".event-collapse").click()
      expect(first(".registered")).to have_content("Registered")
      # click the unregister button
      find('.remove-button').click()

      expect(first(".registered")).not_to have_content("Registered")
    end

    it "should successfully remove participant from session in profile" do
      visit profile_path(@teacher)
      first(:xpath, ".//input[@value='Drop']").click
      page.driver.browser.switch_to.alert.accept
      sleep(3)
      expect(@teacher.sessions.include?(Session.first)).to eq(false)
    end

    context "for team" do
      before(:each) do
        @team = Team.first
        @user = User.find(2)
        login_as(@user)
      end

      it "should successfully remove team from session" do
        visit root_path(role: "Team", id: @team.id)
        first(".event-collapse").click
        expect(first(".registered")).to have_content("Registered")
        find('.remove-button').click

        expect(first(".registered")).not_to have_content("Registered")
      end
    end
  end

  context "Capacity" do
    before(:each) do
      @student = User.find(4)
      @team = Team.find(3)
      login_as(@student)
    end

    it "competition activity should decrease capacity per team" do
      visit team_path(@team)
      click_link "Register For Activities"
      first(".event-collapse").click()
      expect(first(".capacity_remaining")).to have_content("1")
      # register
      check "register"

      expect(first(".capacity_remaining")).to have_content("0")
    end

    it "non-competition activity should decrease capacity per participant" do
      visit root_path(role: "User", id: @student.id)
      first(".event-collapse").click()
      expect(first(".capacity_remaining")).to have_content("23")
      # register
      check "register"

      expect(first(".capacity_remaining")).to have_content("22")
    end
  end

  context "Wait List" do
    before(:each) do
      @student = User.find(3)
      @student2 = User.find(4)
      @student3 = User.find(5)
      @session = Session.find(4)
      @session.register_participant(@student)
      @session.waitlist.users << @student2

    end

    it "user drops session should successfully register user in wait list" do
      login_as(@student)
      visit root_path(role: "User", id: @student.id)
      expect(@session.waitlist.users.include?(@student2)).to eq(true)
      tbl = all(".event-collapse").last
      tbl.click
      expect(page).to have_content("0")
      expect(page).to have_content("8")
      btn = all(".remove-button").last
      btn.click
      sleep(4)
      expect(Session.find(4).waitlist.users.include?(@student2)).to eq(false)
      expect(Session.find(4).users.include?(@student2)).to eq(true)
    end

    it "user clicks on waitlist and they will be added to the session waitlist" do
      login_as(@student3)
      visit root_path(role: "User", id: @student3.id)
      expect(@session.waitlist.users.include?(@student3)).to eq(false)
      expect(@session.waitlist.users.include?(@student2)).to eq(true)
      tbl = all(".event-collapse").last
      tbl.click
      click_link "Add To Waitlist"
      sleep(1)
      expect(Session.find(4).waitlist.users.include?(@student3)).to eq(true)
      expect(page).to have_content("You have been successfully added to the waitlist")
    end

    it "team clicks on waitlist and they will be added to the session waitlist" do
      @team = Team.find(2)
      @team2 = Team.find(3)
      @session = Session.find(5)
      @team.users.delete(User.find(2))
      expect(@session.activity.iscompetetion).to eq(true)
      @session.register_participant(@team)
      @session.waitlist.teams << @team2
      expect(@session.capacity_remaining).to eq(0)
      login_as(@student2)
      visit team_path(@team2)
      # on registration page
      click_link "Register For Activities"
      tbl = all(".event-collapse").last
      tbl.click
      click_link "Add To Waitlist"
      sleep(1)
      expect(Session.find(5).waitlist.teams.include?(@team2)).to eq(true)
      expect(page).to have_content("You're team has been successfully added to the waitlist")
    end

    context "emails" do

      it "should sent an email to the student if the student is in waitlist and a participant drops from that activity" do
        @student = User.find(2)
        @student2 = User.find(3)
        @student3 = User.find(4)
        @session = Session.find(4)
        @session.register_participant(@student3)

        login_as(@student)

        @session.waitlist.users << @student2
        visit root_path(role: "User", id: @student2.id)
        tbl = all(".event-collapse").last
        tbl.click
        expect(page).to have_content("0")
        expect(page).to have_content("8")
        btn = all(".remove-button").last
        btn.click
        sleep(1)
        open_email(@student2.email)
        expect(current_email).to have_content("You have been automatically registered for " + @session.activity.name)
        clear_emails
      end

      it "should send an email if the participant is a team" do
        @student = User.find(3)
        @student2 = User.find(4)
        @team = Team.find(2)
        @team2 = Team.find(3)
        @session = Session.find(5)
        @team.users.delete(User.find(2))
        expect(@session.activity.iscompetetion).to eq(true)
        @session.register_participant(@team)
        @session.waitlist.teams << @team2
        expect(@session.capacity_remaining).to eq(0)
        login_as(@student)

        visit team_path(@team)
        click_link "Register For Activities"
        tbl = all(".event-collapse").last
        tbl.click
        btn = all(".remove-button").last
        btn.click
        sleep(1)
        open_email(@student2.email)
        expect(current_email).to have_content("You're team has been automatically registered for " + @session.activity.name)
        clear_emails
      end
    end
  end

  context "Hidden Events" do
    before(:each) do
      @event = Event.first
      @teacher = User.first
      login_as @teacher
    end
    it "should show event if visibility is true" do
      visit register_for_activity_path(role: "User", id: @teacher.id)
      expect(page).to have_content("Bengal Stem Day")
    end

    it "should not show event if visibility is false" do
      @event.update(visible: false)
      visit register_for_activity_path(role: "User", id: @teacher.id)
      expect(page).not_to have_content("Bengal Stem Day")
    end

    it "should show event if visibility time constraint is met" do
      date = DateTime.now + 60
      @event.update(visible_constraint: date)
      expect(@event.visible).to eq(true)
      visit register_for_activity_path(role: "User", id: @teacher.id)
      sleep(1)
      expect(page).to have_content("Bengal Stem Day")
    end

    it "should not show event if visibility time constraint isn't met" do
      date = DateTime.new(2020, 4, 5, 3)
      @event.update(visible_constraint: date)
      visit register_for_activity_path(role: "User", id: @teacher.id)
      expect(page).not_to have_content("Bengal Stem Day")
    end
  end



end
