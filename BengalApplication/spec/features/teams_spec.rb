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

    it "should fail due to max capacity reach" do
      @teacher = User.first
      @team = Team.create(team_name: "Lions", lead: 2)
      # register leader
      @student5 = User.find(2)
      @team.register_member(@student5)

      @student = User.find(3)
      @student2 = User.find(4)
      @student3 = User.find(5)
      @student4 = User.find(6)

      @team.register_member(@student)
      @team.register_member(@student2)
      @team.register_member(@student3)
      visit "groupings/add/#{@student4.id}/#{@team.id}"
      expect(Team.find(4).users.count).to eq(4)
      expect(page).to have_content("Member limit of 4 reached. No more room for new member")
    end
  end

  context "drop a member" do
    before do
      @student = User.find(4)
      @team = Team.find(3)
      @student2 = User.find(5)
      login_as(@student)
      visit "teams/#{@team.id}"
    end

    it "should successfully drop a student" do
      expect(page).to have_content("Chuck Norris")
      expect(page).to have_content("Javier Floris")
      click_button "Drop"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content("Dropped #{@student2.first_name} #{@student2.last_name} from team.")
      expect(Team.find(3).users.count).to eq(1)
    end
  end
end
