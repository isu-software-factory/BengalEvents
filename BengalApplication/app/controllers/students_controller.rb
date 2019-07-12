class StudentsController < ApplicationController
  before_action :prepare_teacher, only: [:new, :create]
  before_action :authenticate_user!, except: :new

  def index
    @students = Student.where("teacher_id = ?", params[:teacher_id])
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
    @student.build_user
  end

  def create
    @student = Student.new(student_params)
    @teacher.students << @student

    random_password = ('0'..'z').to_a.shuffle.first(8).join

    @student.user.password = random_password
    @student.user.password_confirmation = random_password

    if @student.save
      #UserMailer.login_email(@student.user, "localhost:3000/", random_password)
      render 'new'
    else
      redirect_to root_path
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
  end

  def destroy
    Student.find(params[:id]).destroy
    redirect_to students_path
  end


  private

  def prepare_teacher
    @teacher = Teacher.find(current_user.meta.id)
  end

  def student_params
    params.require(:student).permit(:name, user_attributes: [:email])
  end
end
