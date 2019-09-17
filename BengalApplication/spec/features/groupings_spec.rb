require 'rails_helper'

RSpec.feature "Groupings", type: :feature do
  fixtures :students, :teachers, :teams, :groupings, :participants

  context "Add student to a team" do
    before do
      @teacher = teachers(:teacher_emily)
      @team = Team.create(name: "Lions", lead: 1, participant_attributes: {})
      # register leader
      @student5 = students(:student_1)
      @team.register_member(@student5)

      @student = students(:student_2)
      @student2 = students(:student_3)
      @student3 = students(:student_4)
      @student4 = students(:student_5)
    end

    it "successfully adds student to team" do
      visit "groupings/add/#{@student.id}/#{@team.id}"
      expect(@team.students.count).to eq(2)
      expect(page).to have_content("You have been added to the team!")
    end

    it "should fail due to max capacity reach" do
      @team.register_member(@student)
      @team.register_member(@student2)
      @team.register_member(@student3)
      visit "groupings/add/#{@student4.id}/#{@team.id}"
      expect(@team.students.count).to eq(4)
      expect(page).to have_content("Member limit of 4 reached. No more room for new member")
    end
  end

  context "drop a member" do
    before do
      @teacher = teachers(:teacher_emily)
      @student = students(:student_1)
      @team = teams(:team_1)
      @student2 = students(:student_2)
    end
    it "should successfully drop a student" do
      login_as(@student.user)
      visit "teams/#{@team.id}"

      expect(page).to have_content("Robert")
      expect(page).to have_content("Tim")
      click_button "Drop"
      page.driver.browser.switch_to.alert.accept
      #expect(Team.first.students.count).to eq(1)
      expect(page).to have_content("Dropped #{@student2.name} from team")
    end
  end
end
