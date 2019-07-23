require 'rails_helper'

RSpec.describe OccasionsController, type: :controller do
  context "GET #index" do
    it "returns a success response" do
      #coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "c@gmail.com", password: "password"})
      sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "s@gmail.com", password: "password"})
      sign_in sponsor.user
      get :index
      expect(response).to be_successful
    end
  end

  context "GET #show" do
    it "returns a success response" do
      coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "c@gmail.com", password: "password"})
      occasion = coordinator.occasions.build(name: "BengalEvent", end_date: Time.now, start_date: Time.now)
      occasion.save
      sign_in coordinator.user
      get :show, params: {id: occasion.id }
      expect(response).to render_template("show")
    end
  end
end
