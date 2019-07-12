class TeachersController < ApplicationController
  #before_action :authenticate_user!, :authenticate_teacher, except: [:new, :create]

  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
    @teacher.build_user
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def teacher_params
    params.require(:teacher).permit(:school, :student_count, :chaperone_count, user_attributes: [:id, :email, :password, :password_confirmation])
  end

  def authenticate_teacher
    redirect_to(new_user_session_path) unless current_user.meat_type == "Teacher"
  end
end
