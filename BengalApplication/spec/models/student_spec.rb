require 'rails_helper'

RSpec.describe Student, type: :model do
    fixtures :teachers, :users, :participants, :event_details, :teams, :groupings,
             :students

    context "validation tests" do
      before do
        @teacher = teachers(:teacher_emily)
      end

      it "ensures a name" do
        @student = @teacher.students.build(user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {}).save
        expect(@student).to eq(false)
      end

      it "should create student successful" do
        @student = @teacher.students.build(name: "Billy", user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {}).save
        expect(@student).to eq(true)
      end
    end


    context "association tests" do
      before do
        @participant = participants(:student_1)
        @student = students(:student_1)
        @teacher = teachers(:teacher_emily)
        @user = users(:student_1)
        @event_detail = event_details(:one)
        @team = teams(:team_1)
      end

      it "should have a participant" do
        expect(@student.participant).to eq(@participant)
      end

      it "should have a teacher" do
        expect(@student.teacher).to eq(@teacher)
      end

      it "should have a user" do
        expect(@student.user).to eq(@user)
      end

      it "can have an event_detail" do
        @event_detail.register_participant(@student.participant)
        expect(@student.participant.event_details.first).to eq(@event_detail)
      end

      it "can have a team" do
        expect(@student.teams.first).to eq(@team)
      end

  end
end
