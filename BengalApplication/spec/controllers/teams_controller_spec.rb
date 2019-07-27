require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  context "GET #show" do
    it "returns a success response" do
      team = Team.create(name: "eagles", participant_attributes: {})
      teacher = Teacher.create(name: "Teacher", school: "Valley", student_count: 23, chaperone_count: 232, user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {})
      sign_in teacher.user
      get :show, params: {id: team.id}
      expect(response).to be_successful
    end
  end
end
