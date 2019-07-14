class RegistrationsController < ApplicationController
  def new
    # get student teacher
    @student = Student.find(current_user.meta.id)
    @teacher = Teacher.find(@student.teacher.id)
    @occasion = Occasion.find(@teacher.occasion.id)
  end
end
