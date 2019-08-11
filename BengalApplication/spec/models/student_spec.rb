require 'rails_helper'

RSpec.describe Student, type: :model do

    context "validation tests" do
      before do
        @teacher = Teacher.create(name: "Kelly", user_attributes: {email: "tech@gmail.com", password: "password"})
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
        @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
        @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
        @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
        @occasion.save
        @location = @occasion.locations.build(name: "Gym", start_time: Time.now, end_time: Time.now)
        @location.save
        @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
        @time_slot.save
        @event = @sponsor.events.build(name: "Robotics", description: "great")
        @event.location = @location
        @event.occasion = @occasion
        @event.save
        @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, date_started: @occasion.start_date, capacity: 23)
        @event_detail.save
        @teacher = Teacher.create(name: "Kelly", user_attributes: {email: "tech@gmail.com", password: "password"})
        @student = @teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"})
        @student.save
        Participant.create(member: @student)
      end
      it "should have a participant" do
        expect(@student.participant).not_to eq(nil)
      end
      it "should have a teacher" do
        expect(@student.teacher.id).to eq(@teacher.id)
      end

      it "should have a user" do
        expect(@student.user.id).not_to eq(nil)
      end

      it "can have an event_detail" do
        @event_detail.register_participant(@student.participant)
        expect(@student.participant.event_details.count).to eq(1)
      end

      it "can have a team" do
        team = Team.create(name: "Kings", participant_attributes: {})
        team.lead = @student.id
        team.students << @student
        expect(@student.teams.count).to eq(1)
      end

  end
end
