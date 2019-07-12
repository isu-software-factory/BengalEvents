require 'rails_helper'

RSpec.describe SponsorsController, type: :controller do
  context 'GET #show' do
    it 'returns a success response' do
      sponsor = Sponsor.create!(chaperone_count: 3, student_count: 23, school: "Valley")
      get :show, params: {id: sponsor.to_param}
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
