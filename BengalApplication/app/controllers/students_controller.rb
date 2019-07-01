class StudentsController < ApplicationController
  before_action :prepare_teacher
  def index
    @students = Student.where("teacher_id = ?", params[:teacher_id])
  end

  def new
    @student = Student.new
  end

  def create
    @user = User.create(user_params)
    @student = @teacher.students.create(student_params)
    if @student.save
      redirect_to @teacher
    else
      render :new
    end
  end

  private

  def prepare_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
