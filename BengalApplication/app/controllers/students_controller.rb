class StudentsController < ApplicationController
  def index
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @teacher
    else
      render :new
    end
  end

  def student_params
    params.require(:user).permit(:name, :email)
  end
end
