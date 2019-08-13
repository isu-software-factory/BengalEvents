require 'rails_helper'

RSpec.describe Team, type: :model do
  context "validation test" do
    it "ensures name presence" do
      team = Team.new(name: "").save
      expect(team).to eq(false)
    end
  end

  context "association test" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @team = Team.create(name: "Vikings", participant_attributes: {})
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
      @student = @teacher.students.build(name: "Bill", user_attributes: {email: "e@gmail.com", password: "password"})
      @student.save
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
    end
    it "should have a team lead" do
      @team.lead = @student.id
      expect(@team.lead).to eq(1)
    end
    it "can have members" do
      @team.students << @student
      expect(@team.students.count).to eq(1)
    end
    it "can have an event detail" do
      @event_detail.register_participant(@team.participant)
      expect(@event_detail.participants.first).to eq(@team.participant)
    end
  end
  context "Method testing" do
    context "register_member" do
      before do
        @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
        @student = @teacher.students.build(name: "Bill", user_attributes: {email: "e@gmail.com", password: "password"})
        @student.save
        @student2 = @teacher.students.build(name: "Billy", user_attributes: {email: "s@gmail.com", password: "password"})
        @student2.save
        @student3 = @teacher.students.build(name: "Ben", user_attributes: {email: "b@gmail.com", password: "password"})
        @student3.save
        @student4 = @teacher.students.build(name: "Emily", user_attributes: {email: "em@gmail.com", password: "password"})
        @student4.save
        @student5 = @teacher.students.build(name: "Udy", user_attributes: {email: "ud@gmail.com", password: "password"})
        @student5.save
        @team = Team.create(name: "Vikings", lead: @student.id, participant_attributes: {})
      end
      it "should add a student to team" do
        @team.register_member(@student)
        expect(@team.students.count).to eq(1)
      end
      it "should not add a student if capacity is 4" do
        @team.register_member(@student)
        @team.register_member(@student2)
        @team.register_member(@student3)
        @team.register_member(@student4)
        register = @team.register_member(@student5)
        expect(register).to eq(false)
        expect(@team.students.count).to eq(4)
      end
      it "should not add a student if they are already on team" do
        register = @team.register_member(@student)
        re_register = @team.register_member(@student)
        expect(register).to eq(true)
        expect(re_register).to eq(false)
        expect(@team.students.count).to eq(1)
      end
    end
    context "get_lead" do
      before do
        @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
        @student = @teacher.students.build(name: "Bill", user_attributes: {email: "e@gmail.com", password: "password"})
        @student.save
        @team = Team.create(name: "Vikings", lead: @student.id, participant_attributes: {})
        @team.register_member(@student)
      end
      it "should return the student lead of team" do
        student = @team.get_lead
        expect(student).to eq(@student)
      end
    end
  end
end
