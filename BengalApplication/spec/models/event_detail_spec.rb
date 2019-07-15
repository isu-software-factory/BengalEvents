require 'rails_helper'

RSpec.describe EventDetail, type: :model do
  context "validation tests" do
    it "ensures capacity" do
      event_detail = EventDetail.new(start_time: 2/23/2019, end_time: 2/21/2019).save
      expect(event_detail).to eq(false)
    end
    it "ensures start time" do
      event_detail = EventDetail.new(capacity: 23, end_time: 2/21/2019).save
      expect(event_detail).to eq(false)
    end
    it "ensures end time" do
      event_detail = EventDetail.new(start_time: 2/23/2019, capacity: 23).save
      expect(event_detail).to eq(false)
    end
  end

  context "association tests" do
    let (:event_detail) {EventDetail.create(capacity: 23, start_time: 2/23/2019, end_time: 2/23/2019)}
    it "should have an event" do
      event = Event.new(name: "robotics", location: "SUB", description: "For people interesting in Robotics.", isMakeAhead: true)
      event.save
      event_detail.event = event
      expect(event_detail.event).not_to eq(event)
    end
    it "can have a student" do
      student = Student.new
      student.save
      #student.event_details << event_detail
      event_detail.students << student
    end

  end

end
