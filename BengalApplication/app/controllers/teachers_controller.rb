class TeachersController < ApplicationController
  before_action :authenticate_user!

  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def create

    @teacher = Teacher.create(teacher_params)
    @teacher.user = current_user

    if @teacher.save
      redirect_to @teacher
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
    params.require(:teacher).permit(:school, :chaperone_count, :student_count)
  end
end
