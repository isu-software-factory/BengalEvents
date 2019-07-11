require 'rails_helper'

RSpec.describe Student, type: :model do

    context "association tests" do
      it "should have a teacher" do
        teacher = Teacher.new(student_count: 23, school: "Valley", chaperone_count: 2)
        teacher.save
        student = Student.new
        student.save
        teacher.student = student

        expect(Student.first.teacher.chaperone_count).to eq(2)
      end

      it "should have a user" do
        pending
      end

      it "can have an event_detail" do
        occasion = Occasion.create(name: "BenagelEvent", start_date: 2/23/2019, end_date: 3/23/2019)
        event = Event.create(name: "robotics", location: "SUB", description: "For people interesting in Robotics.", isMakeAhead: true)
        event.occasion = occasion
        event_detail = EventDetail.create(capacity: 23, start_time: 2/23/2019, end_time: 2/32/2019)
        event_detail.event = event

        student = Student.new
        student.save
        student.event_details << event_detail
        expect(student.event_details.first).to eq(event_detail)
      end

      it "can have a team" do
        pending
      end

  end
end
