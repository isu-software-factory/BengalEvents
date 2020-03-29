require 'rails_helper'

RSpec.feature "Teams", type: :feature do

  context "create team" do
    before do
      @student = User.find(2)
      login_as(@student)
      visit new_team_path
    end

    it "student successfully creates a team" do
      within("form") do
        fill_in "team[team_name]", with: "Tigers"
      end
      click_button "Create"
      expect(page).to have_content("Team Tigers")
    end

    it "fails to create a team without name" do
      within("form") do
        fill_in "team[team_name]", with: ""
      end
      click_button "Create"
      expect(page).to have_content("Team name can't be blank")
    end
  end

  context "invite members" do
    before do
      @student = User.find(3)
      @team = Team.first
      @student2 = User.find(4)
      login_as(@student)
    end

    it "successfully invites students" do
      visit "teams/#{@team.id}/invite"
      within("form") do
        fill_in "email1", with: @student2.user_name
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
