require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  context 'GET #show' do
    it 'returns a success response' do
      teacher = Teacher.create!(name: "Dan", chaperone_count: 3, student_count: 23, school: "Valley", user_attributes: {email: "can@gmail.com", password: "password", password_confirmation: "password"})
      student = Student.create!(name: "Dan", user_attributes: {email: "jon@gmail.com", password: "password", password_confirmation: "password"})
      teacher.students << student
      sign_in student.user
      get :show, params: {id: student.to_param}
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
