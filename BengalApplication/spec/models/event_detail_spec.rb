require 'rails_helper'

RSpec.describe EventDetail, type: :model do
  context "validation tests" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "events")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
    end
    it "ensures capacity" do
      event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, date_started: @occasion.start_date).save
      expect(event_detail).to eq(false)
    end
    it "ensures start time" do
      event_detail = @event.event_details.build(end_time: Time.now, date_started: @occasion.start_date, capacity: 23).save
      expect(event_detail).to eq(false)
    end
    it "ensures end time" do
      event_detail = @event.event_details.build(start_time: Time.now, date_started: Time.now, capacity: 23).save
      expect(event_detail).to eq(false)
    end
    it "ensures date started" do
      event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 23).save
      expect(event_detail).to eq(false)
    end
    it "should be created successfully" do
      event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, date_started: @occasion.start_date, capacity: 23).save
      expect(event_detail).to eq(true)
    end
  end

  context "association tests" do
    before do
      @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
      @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
      @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Events")
      @occasion.save
      @location = @occasion.locations.build(name: "Gym")
      @location.save
      @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
      @time_slot.save
      @event = @sponsor.events.build(name: "Robotics", description: "great")
      @event.location = @location
      @event.occasion = @occasion
      @event.save
      @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, date_started: @occasion.start_date, capacity: 23)
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
  context 'method tests' do
    context 'register_participant test' do
      before do
        @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
        @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
        @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Events")
        @occasion.save
        @location = @occasion.locations.build(name: "Gym")
        @location.save
        @event = @sponsor.events.build(name: "Robotics", description: "great")
        @event.location = @location
        @event.occasion = @occasion
        @event.save
        @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, date_started: @occasion.start_date, capacity: 2)
        @event_detail.save
        @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
        @student = @teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes:{})
        @student.save
        @team = Team.create(name: "Tigers", lead: @student.id, participant_attributes: {})
        @team.register_member(@student)
      end
      it 'should add student' do
        @event_detail.register_participant(@student.participant)
        expect(@student.participant.event_details.first).to eq(@event_detail)
      end
      it 'should add teacher' do
        @event_detail.register_participant(@teacher.participant)
        expect(@teacher.participant.event_details.first).to eq(@event_detail)
      end
      it 'should add team' do
        @event_detail.register_participant(@team.participant)
        expect(@team.participant.event_details.first).to eq(@event_detail)
      end
      it "should not register student if they are already registered for event" do
        register = @event_detail.register_participant(@student.participant)
        expect(register).to eq(true)
        re_register = @event_detail.register_participant(@student.participant)
        expect(re_register).to eq(false)
      end
      it "should not register teacher if they are already registered for event" do
        register = @event_detail.register_participant(@teacher.participant)
        expect(register).to eq(true)
        re_register = @event_detail.register_participant(@teacher.participant)
        expect(re_register).to eq(false)
      end
      it "should not register team if they are already registered for event" do
        register = @event_detail.register_participant(@team.participant)
        expect(register).to eq(true)
        re_register = @event_detail.register_participant(@team.participant)
        expect(re_register).to eq(false)
      end
      it "should not register student if capacity is full" do
        expect(@event_detail.capacity_remaining).to eq(2)
        @event_detail.register_participant(@teacher.participant)

        expect(@event_detail.capacity_remaining).to eq(1)
        @event_detail.register_participant(@team.participant)

       # expect(@event_detail.participants.count).to eq(2)
        register = @event_detail.register_participant(@student.participant)

        expect(register).to eq(false)
      end
      it "should not register teacher if capacity is full" do
        @event_detail.register_participant(@student.participant)
        @event_detail.register_participant(@team.participant)
        register = @event_detail.register_participant(@teacher.participant)
        expect(register).to eq(false)
      end
      it "should not register team if capacity is full" do
        @event_detail.register_participant(@teacher.participant)
        @event_detail.register_participant(@student.participant)
        register = @event_detail.register_participant(@team.participant)
        expect(register).to eq(false)
      end
    end
    context "capacity_remaining" do
      before do
        @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
        @coordinator = Coordinator.create(name:"coord", user_attributes: {email: "coordinaotr@gmail.com", password: "password"})
        @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "events")
        @occasion.save
        @location = @occasion.locations.build(name: "Gym")
        @location.save
        @time_slot = @location.time_slots.build(start_time: Time.now, end_time: Time.now, interval: 60)
        @time_slot.save
        @event = @sponsor.events.build(name: "Robotics", description: "great")
        @event.location = @location
        @event.occasion = @occasion
        @event.save
        @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, date_started: @occasion.start_date, capacity: 10)
        @event_detail.save
        @teacher = Teacher.create(name: "Kelly", school: "Valley", student_count: 23, chaperone_count: 2, user_attributes: {email: "tech@gmail.com", password: "password"}, participant_attributes: {})
        @student = @teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes:{})
        @student.save
        @student2 = @teacher.students.build(name: "Billy", user_attributes: {email: "stu@gmail.com", password: "password"}, participant_attributes:{})
        @student2.save
        @team = Team.create(name: "Tigers", lead: @student.id, participant_attributes: {})
        @team.register_member(@student2)
        @team.register_member(@student)
      end
      it "should return capacity remaining after one student registers" do
        @event_detail.register_participant(@student.participant)
        expect(@event_detail.capacity_remaining).to eq(9)
      end
      it "should return capacity remaining after one teacher registers" do
        @event_detail.register_participant(@teacher.participant)
        expect(@event_detail.capacity_remaining).to eq(9)
      end
      it "should return capacity remaining after a team of 2, registers" do
        @event_detail.register_participant(@team.participant)
        expect(@event_detail.capacity_remaining).to eq(8)
      end
    end
  end
  context "method tests" do
    context "start_time_before_end_time method" do
      before do
        @coordinator = Coordinator.create(name: "coord", user_attributes: {email: "coord@gmail.com", password: "password"})
        @occasion = @coordinator.occasions.build(name: "BengalEvents", start_date: Time.now, end_date: Time.now, description: "Events")
        @occasion.save
        @sponsor = Sponsor.create(name: "sponsor", user_attributes: {email: "sponsor@gmail.com", password: "password"})
        @event = @sponsor.events.build(name: "Robotics", description: "great")
        @event.location = @location
        @event.occasion = @occasion
        @event.save
      end
      it "should fail to create occasion wrong time position" do
        @event_detail = @event.event_details.build(end_time: Time.now, start_time: Time.now, capacity: 10, date_started: Time.now).save
        expect(@event_detail).to eq(false)
      end
      it "should successfully create occasion with right time position" do
        @event_detail = @event.event_details.build(start_time: Time.now, end_time: Time.now, capacity: 10, date_started: Time.now).save
        expect(@event_detail).to eq(true)
      end
    end
  end

end
