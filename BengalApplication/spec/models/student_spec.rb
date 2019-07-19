require 'rails_helper'

RSpec.describe Student, type: :model do

    context "association tests" do
      before do
        @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
        @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
        @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
        @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
        @event.occasion = @occasion
        @event.save
        @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23)
        @event_detail.save
        @teacher = Teacher.create(name: "Kelly", user_attributes: {email: "tech@gmail.com", password: "password"})
        @student = @teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"})
        @student.save
      end
      it "should have a teacher" do
        expect(@student.teacher.id).to eq(@teacher.id)
      end

      it "should have a user" do
        expect(@student.user.id).not_to eq(nil)
      end

      it "can have an event_detail" do
        @event_detail.students << @student
        expect(@student.event_details.count).to eq(1)
      end

      it "can have a team" do
        pending
      end

  end
end
