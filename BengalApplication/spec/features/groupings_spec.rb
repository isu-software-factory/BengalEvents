require 'rails_helper'

RSpec.feature "Groupings", type: :feature do
  context "Add student to a team" do
    before do
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
      @student = @teacher.students.build(name: "Billy", user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      @student2 = @teacher.students.build(name: "Bill", user_attributes: {email: "sa@gmail.com", password: "password"}, participant_attributes: {})
      @student2.save
      @student3 = @teacher.students.build(name: "Sarah", user_attributes: {email: "sarah@gmail.com", password: "password"}, participant_attributes: {})
      @student3.save
      @student4 = @teacher.students.build(name: "Time", user_attributes: {email: "Tim@gmail.com", password: "password"}, participant_attributes: {})
      @student4.save
      @student5 = @teacher.students.build(name: "Tom", user_attributes: {email: "Tom@gmail.com", password: "password"}, participant_attributes: {})
      @student5.save
      @team = Team.create(name: "Vikings", lead: @student.id, participant_attributes: {})
      @team.register_member(@student)
    end
    it "successfully adds student to team" do
      visit "groupings/add/#{@student.id}/#{@team.id}"
      expect(@team.students.count).to eq(1)
      expect(page).to have_content("Team")
    end
    it "should fail due to max capacity reach" do
      @team.register_member(@student2)
      @team.register_member(@student3)
      @team.register_member(@student4)
      visit "groupings/add/#{@student5.id}/#{@team.id}"
      expect(@team.students.count).to eq(4)
      expect(page).to have_content("Member limit of 4 reached. No more room for new member")
    end
  end
  context "drop a member" do
    before do
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
      @student = @teacher.students.build(name: "Billy", user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      @team = Team.create(name: "Vikings", lead: @student.id, participant_attributes: {})
      @team.register_member(@student)
      @student2 = @teacher.students.build(name: "Bill", user_attributes: {email: "sa@gmail.com", password: "password"}, participant_attributes: {})
      @student2.save
      @team.register_member(@student2)
    end
    it "should successfully drop a student" do
      login_as(@student.user)
      visit "teams/#{@team.id}"
      expect(page).to have_content("Bill")

      click_button "Drop"
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content("Bill")
      expect(page).to have_content("Team #{@team.name}")
    end
  end
end
