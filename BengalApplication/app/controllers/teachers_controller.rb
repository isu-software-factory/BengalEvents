class TeachersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def new
    @teacher = Teacher.new
    @teacher.build_user
  end

  def create
    @teacher = Teacher.new(teacher_params)
    Participant.create(member: @teacher)
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
    authorize @teacher
  end

  def update
    @teacher = Teacher.find(params[:id])
    authorize @teacher
    if @teacher.update_attributes(user_params)
      redirect_to @teacher
    else
      render 'edit'
    end

  end

  def destroy
    @teacher = Teacher.find(params[:id])
    authorize @teacher
    @teacher.destroy
    redirect_to teachers_path
  end

  private

  def teacher_params
    params.require(:teacher).permit(:school, :name, :student_count, :chaperone_count, user_attributes: [:id, :email, :password, :password_confirmation])
  end


end
