class TeachersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    authorize @teacher
    if @teacher.save
      redirect_to @teacher
    else
      render :new
    end
  end

  def teacher_params
    params.require(:teacher).permit(:school, :chaperone_count, :student_count)
  end

  def user_params
    params.require(:user).permit(:name, :password_digest, :email)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
