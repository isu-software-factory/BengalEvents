require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  context 'GET #show' do
    it 'returns a success response' do
      teacher = Teacher.create!(chaperone_count: 3, student_count: 23, school: "Valley")
      get :show, params: {id: teacher.to_param}
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
