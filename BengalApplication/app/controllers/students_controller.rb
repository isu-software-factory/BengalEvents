class StudentsController < ApplicationController
  before_action :prepare_teacher
  def index
    @students = Student.where("teacher_id = ?", params[:teacher_id])
  end

  def new
    @user = User.new
  end

  def create
    #random_password = ('0'..'z').to_a.shuffle.first(8).join
    @user = User.create(name: "Josemity", email: "myemail@email.com", password: "testPassword", password_confirmation: "testPassword", role: "student")
    if @user.save
      @user.student = @teacher.students.create()
      @student = Student.find(@user.student.id)
      if @student.save
        redirect_to @teacher
      else
        render :new
      end
    else
      redirect_to @teacher
    end
  end

  private

  def prepare_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end
end
