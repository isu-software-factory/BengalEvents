class StudentsController < ApplicationController
  before_action :prepare_teacher
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

    #random_password = ('0'..'z').to_a.shuffle.first(8).join
    random_password = "password"
    @student.user.password = random_password
    @student.user.password_confirmation = random_password

    if @student.save
      redirect_to root_path
    else
      render new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    if @student.update_attributes(user_params)
      redirect_to @student
    else
      render 'edit'
    end
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
