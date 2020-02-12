require 'rails_helper'

RSpec.describe Session, type: :model do

  context "validation tests" do
    before(:each) do
      @activity = Activity.first
      @start_time = DateTime.new(2020,4,5,3)
      @end_time = DateTime.new(2020,4,5,4)
    end

    it "should ensure start_time" do
      session = @activity.sessions.new(end_time: @end_time, capacity: 5).save
      expect(session).to eq(false)
    end

    it "should ensure end_time" do
      session = @activity.sessions.new(start_time: @start_time, capacity: 5).save
      expect(session).to eq(false)
    end

    it "should ensure capacity" do
      session = @activity.sessions.new(start_time: @start_time, end_time: @end_time).save
      expect(session).to eq(false)
    end

    it "should save successfully" do
      session = @activity.sessions.new(start_time: @start_time, end_time: @end_time, capacity: 5).save
      expect(session).to eq(true)
    end
  end

  context "association tests" do
    before(:each) do
      @activity = Activity.first
      @session = Session.first
      @teacher = User.find(1)
      @student = User.find(2)
    end

    it "should have an activity" do
      expect(@session.activity).to eq(@activity)
    end

    it "should have users" do
      expect(@session.users.first).to eq(@teacher)
      expect(@session.users[1]).to eq(@student)
    end

    it "should have a waitlist" do
      pending "need to add to seed and database"
    end
  end

  context "method tests" do
    before(:each) do
      @session = Session.find(4)
      @session2 = Session.last
      @teacher = User.find(1)
      @student = User.find(3)
      @student2 = User.find(2)
      @student3 = User.find(4)
      @team = Team.find(2)
      @team2 = Team.first
      @team3 = Team.last
    end

    context "register_participant method" do
      it "should successfully register a user" do
        success = @session.register_participant(@student)
        expect(success).to eq(true)
      end

      it "should not allow a user to register twice" do
        success = @session.register_participant(@student2)
        expect(success).to eq(false)
      end

      it "should not allow a user to register if the capacity is zero" do
        @session.register_participant(@student3)
        success = @session.register_participant(@student)
        expect(success).to eq(false)
      end

      it "should allow teachers to register" do
        expect(@session.users.include?(@teacher)).to eq(false)
        success = @session.register_participant(@teacher)
        expect(success).to eq(true)
        expect(@session.users.include?(@teacher)).to eq(true)
      end

      it "should allow students to register" do
        expect(@session.users.include?(@student3)).to eq(false)
        success = @session.register_participant(@student3)
        expect(success).to eq(true)
        expect(@session.users.include?(@student3)).to eq(true)
      end

      it "should allow teams to register" do
        expect(@session2.teams.include?(@team)).to eq(false)
        success = @session2.register_participant(@team)
        expect(success).to eq(true)
        expect(@session2.teams.include?(@team)).to eq(true)
      end

      it "should not allow a team to register twice" do
        success = @session2.register_participant(@team2)
        expect(success).to eq(false)
      end

      it "should not allow a team to register if the capacity is zero" do
        @session2.register_participant(@team)
        success = @session2.register_participant(@team3)
        expect(success).to eq(false)
      end

    end

    context "capacity_remaining method" do
      it "should return zero when capacity is full" do
        @session.register_participant(@student)
        expect(@session.capacity_remaining).to eq(0)
      end

      it "should return one capacity left" do
        expect(@session.capacity_remaining).to eq(1)
      end
    end

    context "wait_list_check method" do
      pending "waiting to implement"
    end

  end
end
