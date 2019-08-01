require 'rails_helper'

RSpec.feature "Groupings", type: :feature do
  context "Get #add" do
    before do
      @team = Team.create(name: "Vikings", participant_attributes: {})
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
      @student = @teacher.students.build(name: "Billy", user_attributes: {email: "s@gmail.com", password: "password"})
      @student.save
    end
    it "adds student to team" do
      visit "groupings/add/#{@student.id}/#{@team.id}"
      expect(@team.students.count).to eq(1)
      expect(page).to have_content("Team")
    end
  end
end
