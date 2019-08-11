require 'rails_helper'

RSpec.describe EventDetail, type: :model do
  context "validation tests" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @location = @occasion.locations.build(name: "Gym", start_time: Time.now, end_time: Time.now)
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
    end
    it "ensures capacity" do
      event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, date_started: @occasion.start_date).save
      expect(event_detail).to eq(false)
    end
    it "ensures start time" do
      event_detail = @event.event_details.build(end_time: @time_slot.end_time, date_started: @occasion.start_date, capacity: 23).save
      expect(event_detail).to eq(false)
    end
    it "ensures end time" do
      event_detail = @event.event_details.build(start_time: @time_slot.start_time, date_started: @occasion.start_date, capacity: 23).save
      expect(event_detail).to eq(false)
    end
    it "ensures date started" do
      event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, capacity: 23).save
      expect(event_detail).to eq(false)
    end
    it "should be created successfully" do
      event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, date_started: @occasion.start_date, capacity: 23).save
      expect(event_detail).to eq(true)
    end
  end

  context "association tests" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now)
      @occasion.save
      @location = @occasion.locations.build(name: "Gym", start_time: Time.now, end_time: Time.now)
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
      @event_detail = @event.event_details.build(start_time: @time_slot.start_time, end_time: @time_slot.end_time, date_started: @occasion.start_date, capacity: 23)
      @event_detail.save
      @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
    end
    it "should have an event" do
      expect(@event_detail.event.id).to eq(@event.id)
    end
    it "can have a student participant" do
      student = @teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes: {})
      student.save
      @event_detail.register_participant(student.participant)
      expect(student.participant.event_details.count).to eq(1)
    end
    it "can have a teacher participant" do
      @event_detail.register_participant(@teacher.participant)
      expect(@teacher.participant.event_details.count).to eq(1)
    end
    it "can have a team participant" do
      student = @teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes:{})
      student.save
      team = student.teams.build(name: "Tigers", lead: student.id, participant_attributes: {})
      team.save
      @event_detail.register_participant(team.participant)
      expect(team.participant.event_details.count).to eq(1)
    end
  end

end
