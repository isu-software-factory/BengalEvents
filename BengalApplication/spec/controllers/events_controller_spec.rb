require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  context "GET #show" do
    it "should be successful" do
      sponsor = Sponsor.create!(name: "Sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      # sign in to page
      sign_in sponsor.user
      # create event
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      event = sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
      event.occasion = @occasion
      event.save
      # go to event show page
      get :show, params: {occasion_id: @occasion.id, id: event.id}

      expect(response).to render_template("show")

    end
  end
end
