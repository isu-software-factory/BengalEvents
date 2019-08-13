require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    it "ensures email presence" do
      @sponsor = Sponsor.new(name: "sponsor", user_attributes: {password: "password"}).save
      expect(@sponsor).to eq(false)
    end
    it "ensures password presence" do
      @sponsor = Sponsor.new(name: "sponsor", user_attributes: {email: "s@gmail.com"}).save
      expect(@sponsor).to eq(false)
    end
    it "should be create successfully" do
      @sponsor = Sponsor.new(name: "sponsor", user_attributes: {email: "s@gmail.com", password: "password"}).save
      expect(@sponsor).to eq(true)
    end
  end
  context "association tests" do
    before do
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
      @student = @teacher.students.build(name: "Carlos", user_attributes: {email: "s@gmail.com", password: "password"})
      @student.save
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "c@gmail.com", password: "password"})
    end
    it "can have a student" do
      user = User.find(@student.user.id)
      expect(user.id).to eq(@student.user.id)
    end
    it "can have a teacher" do
      user = User.find(@teacher.user.id)
      expect(user.id).to eq(@teacher.user.id)
    end
    it "can have a sponsor" do
      user = User.find(@sponsor.user.id)
      expect(user.id).to eq(@sponsor.user.id)
    end
    it "can have a coordinator" do
      user = User.find(@coordinator.user.id)
      expect(user.id).to eq(@coordinator.user.id)
    end
  end
end
