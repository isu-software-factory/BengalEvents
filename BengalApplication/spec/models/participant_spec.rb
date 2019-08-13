require 'rails_helper'

RSpec.describe Participant, type: :model do
  context "association tests" do
    before do
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
      @student = @teacher.students.build(name: "Bill", user_attributes: {email: "e@gmail.com", password: "password"})
      @student.save
      @team = Team.create(name: "Vikings")
    end
    it "can have a teacher" do
      Participant.create(member: @teacher)
      expect(@teacher.participant).not_to eq(nil)
    end
    it "can have a student" do
      Participant.create(member: @student)
      expect(@student.participant).not_to eq(nil)
    end
    it "can have a team" do
      Participant.create(member: @team)
      expect(@team.participant).not_to eq(nil)
    end
    it "can have an event detail" do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
      @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, date_started: @occasion.start_date, capacity: 23)
      @event_detail.save
      Participant.create(member: @student)
      @event_detail.register_participant(@student.participant)
      participant = Participant.find(@student.participant.id)
      expect(participant.event_details.count).to eq(1)
    end
  end
end
