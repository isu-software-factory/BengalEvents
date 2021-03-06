class TeachersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

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
      sign_in @teacher.user
      redirect_to @teacher
    else
      render :new
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    if @teacher.update_attributes(user_params)
      redirect_to @teacher
    else
      render 'edit'
    end

  end

  def destroy
    Teacher.find(params[:id]).destroy
    redirect_to teachers_path
  end

  private

  def teacher_params
    params.require(:teacher).permit(:school, :name, :student_count, :chaperone_count, user_attributes: [:id, :email, :password, :password_confirmation])
  end


end
