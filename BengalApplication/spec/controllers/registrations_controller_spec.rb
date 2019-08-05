require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  context "Get #index" do
    it "returns a success response" do
      teacher = Teacher.create(name: "Teacher", school: "Valley", student_count: 23, chaperone_count: 232, user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {})
      sign_in teacher.user
      get :index, params: {part_id: teacher.participant.id}
      expect(response).to be_successful
    end
  end
  context "Get #events" do
    it "returns a success response" do
      teacher = Teacher.create(name: "Teacher", school: "Valley", student_count: 23, chaperone_count: 232, user_attributes: {email: "s@gmail.com", password: "password"}, participant_attributes: {})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      sign_in teacher.user
      get :events, params: {part_id: teacher.participant.id, id: @occasion.id}
      expect(response).to be_successful
    end
  end
end
