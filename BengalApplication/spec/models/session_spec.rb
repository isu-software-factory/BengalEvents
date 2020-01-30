require 'rails_helper'

RSpec.describe EventDetail, type: :model do
  fixtures :sponsors, :supervisors, :teachers, :students,
           :occasions, :coordinators, :locations, :time_slots,
           :events, :event_details, :teams, :participants,
           :groupings, :waitlists

  context "validation tests" do
    before do
      @sponsor = sponsors(:sponsor_carlos)
      @coordinator = coordinators(:coordinator_rebeca)
      @occasion = occasions(:one)
      @location = locations(:one)
      @time_slot = time_slots(:one)
      @event = events(:one)
      @start_time = Time.new(2018,01,03, 02,22,22)
      @end_time = Time.new(2018,01,03, 04,22,22)
    end

    it "ensures capacity" do
      event_detail = @event.event_details.build(start_time: @start_time, end_time: @end_time, date_started: @occasion.start_date).save
      expect(event_detail).to eq(false)
    end

    it "ensures start time" do
      event_detail = @event.event_details.build(end_time: @end_time, date_started: @occasion.start_date, capacity: 23).save
      expect(event_detail).to eq(false)
    end

    it "ensures end time" do
      event_detail = @event.event_details.build(start_time: @start_time, date_started: @occasion.start_date, capacity: 23).save
      expect(event_detail).to eq(false)
    end

    it "ensures date started" do
      event_detail = @event.event_details.build(start_time: @start_time, end_time: @end_time, capacity: 23).save
      expect(event_detail).to eq(false)
    end

    it "should be created successfully" do
      event_detail = @event.event_details.build(start_time: @start_time, end_time: @end_time, date_started: @occasion.start_date, capacity: 23).save
      expect(event_detail).to eq(true)
    end
  end


  context "association tests" do
    before do
      @sponsor = sponsors(:sponsor_carlos)
      @coordinator = coordinators(:coordinator_rebeca)
      @occasion = occasions(:one)
      @location = locations(:one)
      @time_slot = time_slots(:one)
      @event = events(:one)
      @event_detail = event_details(:one)
      @student = students(:student_1)
      @teacher = teachers(:teacher_emily)
      @team = teams(:team_1)
    end

    it "should have an event" do
      expect(@event_detail.event).not_to eq(nil)
    end

    it "can have a student participant" do
      @event_detail.register_participant(@student.participant)
      expect(@event_detail.participants.first.member).to eq(@student)
    end

    it "can have a teacher participant" do
      @event_detail.register_participant(@teacher.participant)
      expect(@event_detail.participants.first.member).to eq(@teacher)
    end

    it "can have a team participant" do
      @event_detail.register_participant(@team.participant)
      expect(@event_detail.participants.first.member).to eq(@team)
    end
  end


  context 'method tests' do

    context 'register_participant test' do
      before do
        @event_detail = event_details(:one)
        @student = students(:student_1)
        @teacher = teachers(:teacher_emily)
        @team = teams(:team_1)
      end


      it 'register_participant should add a student to event detail' do
        @event_detail.register_participant(@student.participant)
        expect(@event_detail.participants.first.member).to eq(@student)
      end

      it 'register_participant should add a teacher to event detail' do
        @event_detail.register_participant(@teacher.participant)
        expect(@event_detail.participants.first.member).to eq(@teacher)
      end

      it 'register_participant should add a team to event detail' do
        @event_detail.register_participant(@team.participant)
        expect(@event_detail.participants.first.member).to eq(@team)
      end

      it "should not register student if they are already registered for event" do
        # first register
        register = @event_detail.register_participant(@student.participant)
        expect(register).to eq(true)
        # second register
        re_register = @event_detail.register_participant(@student.participant)
        expect(re_register).to eq(false)
      end

      it "should not register teacher if they are already registered for event" do
        # first register
        register = @event_detail.register_participant(@teacher.participant)
        expect(register).to eq(true)
        # second register
        re_register = @event_detail.register_participant(@teacher.participant)
        expect(re_register).to eq(false)
      end

      it "should not register team if they are already registered for event" do
        # first register
        register = @event_detail.register_participant(@team.participant)
        expect(register).to eq(true)
        # second register
        re_register = @event_detail.register_participant(@team.participant)
        expect(re_register).to eq(false)
      end

      it "should not register student if capacity is full" do
        # teacher register
        @event_detail.register_participant(@teacher.participant)
        expect(@event_detail.capacity_remaining).to eq(0)
        # student register
        register = @event_detail.register_participant(@student.participant)
        expect(register).to eq(false)
      end

      it "should not register teacher if capacity is full" do
        # student register
        @event_detail.register_participant(@student.participant)
        # teacher register
        register = @event_detail.register_participant(@teacher.participant)
        expect(register).to eq(false)
      end

      it "should not register team if capacity is full" do
        # teacher register
        @event_detail.register_participant(@teacher.participant)
        # team register
        register = @event_detail.register_participant(@team.participant)
        expect(register).to eq(false)
      end
    end

    context "capacity_remaining test" do
      before do
        @sponsor = sponsors(:sponsor_carlos)
        @coordinator = coordinators(:coordinator_rebeca)
        @occasion = occasions(:one)
        @location = locations(:one)
        @time_slot = time_slots(:one)
        @event = events(:one)
        @event_detail = event_details(:three)
        @student = students(:student_1)
        @teacher = teachers(:teacher_emily)
        @team = teams(:team_1)
      end


      it "capacity_remaining should return capacity remaining after one student registers" do
        @event_detail.register_participant(@student.participant)
        expect(@event_detail.capacity_remaining).to eq(2)
      end

      it "capacity_remaining should return capacity remaining after one teacher registers" do
        @event_detail.register_participant(@teacher.participant)
        expect(@event_detail.capacity_remaining).to eq(2)
      end

      it "capacity_remaining should return capacity remaining after a team of 2, registers" do
        @event_detail.register_participant(@team.participant)
        expect(@event_detail.capacity_remaining).to eq(1)
      end
    end

    context "start_time_before_end_time method" do
      before do
        @sponsor = sponsors(:sponsor_carlos)
        @coordinator = coordinators(:coordinator_rebeca)
        @occasion = occasions(:one)
        @location = locations(:one)
        @time_slot = time_slots(:one)
        @event = events(:one)
        @start_time = Time.new(2018,01,03, 02,22,22)
        @end_time = Time.new(2018,01,03, 04,22,22)
      end

      it "should fail to create occasion wrong time position" do
        @event_detail = @event.event_details.build(end_time: @start_time, start_time: @end_time, capacity: 10, date_started: @start_time).save
        expect(@event_detail).to eq(false)
      end

      it "should successfully create occasion with right time position" do
        @event_detail = @event.event_details.build(start_time: @start_time, end_time: @end_time, capacity: 10, date_started: @start_time).save
        expect(@event_detail).to eq(true)
      end
    end

    context "Wait List" do
      before do
        @event = events(:one)
        @event_detail = event_details(:three)
        @student = students(:student_1)
        @teacher = teachers(:teacher_emily)
      end

      it "add participant to event detail automatically and drop from waitlist" do
        @event_detail.waitlist.participants << @student.participant
        @event_detail.wait_list_check
        expect(@event_detail.waitlist.participants.count).to eq(0)
      end
    end

    context "Email" do
      before do
        @event_detail = event_details(:six)
        @student = students(:student_1)
      end

      it "should send an email if event is MakeAhead" do
        @event_detail.register_participant(@student.participant)
        expect(@event_detail.participants.count).to eq(1)
      end
    end
  end
end
