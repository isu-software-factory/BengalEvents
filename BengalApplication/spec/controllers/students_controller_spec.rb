require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  context 'GET #show' do
    it 'returns a success response' do
      student = Student.create!(chaperone_count: 3, student_count: 23, school: "Valley")
      get :show, params: {id: student.to_param}
      expect(response).to be_success
    end
  end
  context 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end
  end
end
