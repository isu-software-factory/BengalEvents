require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe TeachersController, type: :controller do
  context 'GET #show' do
    it 'returns a success response' do
      teacher = Teacher.create!(name: "Dan", chaperone_count: 3, student_count: 23, school: "Valley", user_attributes: {email: "can@gmail.com", password: "password", password_confirmation: "password"})
      #login_as(teacher.user, :scope => :user)
      sign_in teacher.user
      get :show, params: {id: teacher.to_param}
      expect(response).to render_template("show")
    end
  end
  #context 'GET #index' do
   # it 'returns a success response' do
    #  get :index
     # expect(response).to be_success
    #end
  #end
end
