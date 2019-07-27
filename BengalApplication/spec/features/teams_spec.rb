require 'rails_helper'

RSpec.feature "Teams", type: :feature do
  context "create team" do
    before do
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
      @student = @teacher.students.build(name: "student", user_attributes: {email: "e@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
    end
    it "student successfully creates a team" do
      login_as(@student.user)
      visit new_team_path
      within("form") do
        fill_in "team[name]", with: "Tigers"
      end
      click_button "Create"
      expect(@student.teams.count).to eq(1)
      expect(page).to have_content("Team")
    end
    it "fails to create a team" do
      login_as(@student.user)
      visit new_team_path
      within("form") do
        fill_in "team[name]", with: ""
      end
      click_button "Create"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "invite members" do
    before do
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"}, participant_attributes: {})
      @student = @teacher.students.build(name: "student", user_attributes: {email: "e@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      @student2 = @teacher.students.build(name: "Billy", user_attributes:{email: "andecord@gmail.com", password: "password"}, participant_attributes: {})
      @student2.save
      @team = Team.create(name: "Tigers", participant_attributes: {})
      @team.students << @student
    end
    it "successfully invites students" do
      login_as(@student.user)
      visit "teams/register"
      within("form") do
        fill_in "email1", with: @student2.user.email
      end
      click_button "Invite"
      expect(page).to have_content("Welcome, #{@student.name}")
    end
    it "fail to invite students" do
      login_as(@student.user)
      visit "teams/register"
      within("form") do
        fill_in "email1", with: "random@gmail.com"
      end
      click_button "Invite"
      expect(page).to have_content("no such student exits, random@gmail.com")
    end
  end
end
