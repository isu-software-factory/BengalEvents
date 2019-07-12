class StudentsController < ApplicationController
  before_action :prepare_teacher
  before_action :authenticate_user!, except: :new

  def index
    @students = Student.where("teacher_id = ?", params[:teacher_id])
  end

  def new
    @user = User.new
  end

  def create
    random_password = ('0'..'z').to_a.shuffle.first(8).join
    @user = User.new(user_params)
    @user.password = random_password
    @user.password_confirmation = random_password
    @student = Student.new
    @user.Identifiable = @student
    if @student.save
      @user.save
    end
    redirect_to @teacher
  end

  private

  def prepare_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
