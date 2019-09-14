require 'rails_helper'

RSpec.describe Participant, type: :model do
  fixtures :teachers, :students, :teams, :event_details, :participants

  context "association tests" do
    before do
      @teacher = teachers(:teacher_emily)
      @student = students(:student_1)
      @team = teams(:team_1)
      @event_detail = event_details(:one)
      @participant1 = participants(:teacher)
      @participant2 = participants(:student_1)
      @participant3 = participants(:team)
    end


    it "can have a teacher" do
      expect(@participant1.member).to eq(@teacher)
    end

    it "can have a student" do
      expect(@participant2.member).to eq(@student)
    end

    it "can have a team" do
      expect(@participant3.member).to eq(@team)
    end

    it "can have an event detail" do
      # register
      @event_detail.register_participant(@participant1)
      expect(@event_detail.participants.first.member).to eq(@teacher)
    end
  end
end
