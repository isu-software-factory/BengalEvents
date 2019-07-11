require 'rails_helper'
require 'spec_helper'

RSpec.describe Teacher, type: :model do
  context "validation tests" do
    it "ensures school presence" do
      teacher = Teacher.new(chaperone_count: 3, student_count: 23).save
      expect(teacher).to eq(false)
    end
    it "ensures number of chaperones presence" do
      teacher = Teacher.new(student_count: 23, school: "Valley").save
      expect(teacher).to eq(false)
    end
    it "ensures number of students presence" do
      teacher = Teacher.new(student_count: 23, school: "Valley").save
      expect(teacher).to eq(false)
    end
  end
  context "association tests" do
    it "should have a student" do
      teacher = Teacher.new(chaperone_count: 3, student_count: 23, school: "Valley")
      teacher.save

      student = Student.new
      student.save

      teacher.student = student
      expect(teacher.student).not_to eq(nil)
    end

    it "should have a user" do
      pending
    end
  end
end
