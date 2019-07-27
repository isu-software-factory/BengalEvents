require 'rails_helper'
require 'spec_helper'

RSpec.describe Teacher, type: :model do
  context "validation tests" do
    it "ensures school presence" do
      teacher = Teacher.new(chaperone_count: 3, student_count: 23, name: "teach").save
      expect(teacher).to eq(false)
    end
    it "ensures number of chaperone's presence" do
      teacher = Teacher.new(student_count: 23, school: "Valley", name: "teach").save
      expect(teacher).to eq(false)
    end
    it "ensures number of students presence" do
      teacher = Teacher.new(student_count: 23, school: "Valley", name: "teach").save
      expect(teacher).to eq(false)
    end
    it "ensures name presence" do
      teacher = Teacher.new(student_count: 23, school: "valley", chaperone_count: 3).save
      expect(teacher).to eq(false)
    end
    it "should create teacher successfully" do
      teacher = Teacher.new(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}).save
      expect(teacher).to eq(true)
    end
  end
  context "association tests" do
    before do
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "te@gmail.com", password: "password"})

    end
    it "should have a participant" do
      Participant.create(member: @teacher)
      expect(@teacher.participant).not_to eq(nil)
    end
    it "should have a student" do
      student = @teacher.students.build(name: "student", user_attributes: {email: "g@gmail.com", password: "password"})
      student.save
      expect(student.teacher.id).to eq(@teacher.id)
    end
    it "should have a user" do
      expect(@teacher.user.id).not_to eq(nil)
    end
    it "can have an event_detail" do
      Participant.create(member: @teacher)
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.save
      @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23)
      @event_detail.save
      @event_detail.participants << @teacher.participant
      expect(@teacher.participant.event_details.count).to eq(1)
    end
  end
end
