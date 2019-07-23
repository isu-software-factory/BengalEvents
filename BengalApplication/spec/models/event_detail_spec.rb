require 'rails_helper'

RSpec.describe EventDetail, type: :model do
  context "validation tests" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @event = @sponsor.events.build(location: "Gym", name: "Robotics", description: "great")
      @event.occasion = @occasion
      @event.save
    end
    it "ensures capacity" do
      event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now).save
      expect(event_detail).to eq(false)
    end
    it "ensures start time" do
      event_detail = @event.event_details.build(capacity: 23, end_time: Time.now).save
      expect(event_detail).to eq(false)
    end
    it "ensures end time" do
      event_detail = @event.event_details.build(start_time: Time.now, capacity: 23).save
      expect(event_detail).to eq(false)
    end
    it "should be created successfully" do
      event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23).save
      expect(event_detail).to eq(true)
    end
  end

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
    end
    it "should have an event" do
      expect(@event_detail.event.id).to eq(@event.id)
    end
    it "can have a student" do
      teacher = Teacher.create(name: "Kelly", user_attributes: {email: "tech@gmail.com", password: "password"})
      student = teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"})
      student.save
      @event_detail.students << student
      s_event = student.event_details.count
      expect(s_event).to eq(1)
    end

  end

end
