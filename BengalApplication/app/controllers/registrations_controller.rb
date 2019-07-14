class RegistrationsController < ApplicationController
  def index
    @registration = Registration.all
  end

  def new
    # get student teacher
    @student = Student.find(current_user.meta.id)
    @teacher = Teacher.find(@student.teacher.id)
    @occasion = Occasion.find(@teacher.occasion.id)
  end

  def show
    @registration = Registration.find(params[:id])

  end
end
