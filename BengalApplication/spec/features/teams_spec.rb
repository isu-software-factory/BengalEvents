require 'rails_helper'

RSpec.feature "Teams", type: :feature do
  fixtures :students, :teachers, :users, :participants, :teams, :groupings
  context "create team" do
    before do
      @student = students(:student_1)

      login_as(@student.user)
      visit new_team_path
    end

    it "student successfully creates a team" do
      within("form") do
        fill_in "team[name]", with: "Tigers"
      end
      click_button "Create"
      expect(page).to have_content("Team Tigers")
    end

    it "fails to create a team" do
      within("form") do
        fill_in "team[name]", with: ""
      end
      click_button "Create"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "invite members" do
    before do
      @student = students(:student_1)
      @team = teams(:team_1)
      @student2 = students(:student_2)

      login_as(@student.user)
    end

    it "successfully invites students" do
      visit "teams/#{@team.id}/invite"
      within("form") do
        fill_in "email1", with: @student2.user.email
      end
      click_button "Invite"
      expect(page).to have_content("Invited members to team")
    end

    it "fail to invite students" do
      visit "teams/#{@team.id}/invite"
      within("form") do
        fill_in "email1", with: "random@gmail.com"
      end
      click_button "Invite"
      expect(page).to have_content("no such student exits, random@gmail.com")
    end
  end
end
