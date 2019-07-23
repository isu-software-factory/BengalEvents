require 'rails_helper'

RSpec.describe CoordinatorsController, type: :controller do
  context "GET #show" do
    it "returns a success response" do
      coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "c@gmail.com", password: "password"})
      sign_in coordinator.user
      get :show, params: {id: coordinator.id}
      expect(response).to render_template("show")
    end
  end

end
