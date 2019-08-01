require 'rails_helper'

RSpec.describe GroupingsController, type: :controller do

  describe "GET #add" do
    before do
      @team = Team.create(name: "Vikings")
      @teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "t@gmail.com", password: "password"})
      @student = @teacher.students.build(name: "Billy", user_attributes: {email: "s@gmail.com", password: "password"})
      @student.save
    end
    it "returns http success" do
      get :add, params: {id: @student.id, team_id: @team.id}
      expect(response).to have_http_status(302)
    end
  end

end
