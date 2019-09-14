require 'rails_helper'
require 'spec_helper'

RSpec.describe Teacher, type: :model do
  fixtures :teachers, :students, :event_details, :participants,
           :users

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
      @teacher = teachers(:teacher_emily)
      @participant = participants(:teacher)
      @student = students(:student_1)
      @user = users(:teacher)
      @event_detail = event_details(:one)
    end

    it "should have a participant" do
      expect(@teacher.participant).to eq(@participant)
    end

    it "can have a student" do
      expect(@teacher.students.first).to eq(@student)
    end

    it "should have a user" do
      expect(@teacher.user).to eq(@user)
    end

    it "can have an event_detail" do
      @event_detail.register_participant(@teacher.participant)
      expect(@teacher.participant.event_details.first).to eq(@event_detail)
    end
  end
end
