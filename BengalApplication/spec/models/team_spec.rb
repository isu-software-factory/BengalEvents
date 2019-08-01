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
      @team = Team.create(name: "Vikings")
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
      @student = @teacher.students.build(name: "Bill", user_attributes: {email: "e@gmail.com", password: "password"})
      @student.save
    end
    it "should have a team lead" do
      @team.lead = @student.id
      expect(@team.lead).to eq(1)
    end
    it "should have members" do
      @team.students << @student
      expect(@team.students.count).to eq(1)
    end
  end
end
