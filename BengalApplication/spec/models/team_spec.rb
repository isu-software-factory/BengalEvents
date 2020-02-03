require 'rails_helper'

RSpec.describe Team, type: :model do
  fixtures :teams, :students, :teachers, :event_details,
           :participants

  context "validation test" do
    it "ensures name presence" do
      team = Team.new(name: "", lead: 1).save
      expect(team).to eq(false)
    end

    it "ensures team lead presence" do
      team = Team.new(name: "Bears").save
      expect(team).to eq(false)
    end

    it "successfully creates a team" do
      team = Team.new(name: "Bears").save
      expect(team).to eq(true)
    end
  end


  context "association test" do
    before do
      @team = Team.first
      @session = Session.first
      @student = User.find(2)
    end

    it "should have a team lead" do
      expect(@team.lead).to eq(@student.id)
    end

    it "can have members" do
      expect(@team.users.count).to eq(2)
    end

    #it "can have a session" do
    #  @session.register_participant(@team.participant)
    #  expect(@session.users.first).to eq(@team)
    #end
  end

  context "Method testing" do
    context "register_member" do
      before do
        @team = Team.first
        @student = User.find(2)
        @student2 = User.find(3)
        @student3 = User.find(4)
        @student4 = User.find(5)
        @student5 = User.find(6)
      end

      it "should add a student to team" do
        @team.register_member(@student3)
        expect(@team.students.first).to eq(@student)
      end

      it "should not add a student if capacity is 4" do
        # add members
        @team.register_member(@student)
        @team.register_member(@student2)
        @team.register_member(@student3)
        @team.register_member(@student4)

        register = @team.register_member(@student5)
        expect(register).to eq(false)
      end

      it "should not add a student if they are already on team" do
        # add member
        @team.register_member(@student)
        # re add member
        re_register = @team.register_member(@student)

        expect(re_register).to eq(false)
      end
    end

    context "get_lead" do
      before do
        @student = students(:student_1)
        @team = teams(:team_1)
      end

      it "should return the student lead of team" do
        expect(@team.get_lead).to eq(@student)
      end
    end
  end
end
