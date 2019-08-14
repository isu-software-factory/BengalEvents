class StudentsController < ApplicationController
  before_action :prepare_teacher, only: [:new, :create]
  before_action :authenticate_user!, except: :new

  # def index
  #   @students = Student.where("teacher_id = ?", params[:teacher_id])
  # end

  def show
    @student = Student.find(params[:id])
    authorize @student
  end

  def new
    @student = Student.new
    @student.build_user
    authorize @student
  end

  def create
    @student = Student.new(student_params)
    authorize @student
    @teacher.students << @student
    random_password = ('0'..'z').to_a.shuffle.first(8).join
    @student.user.password = random_password
    @student.user.password_confirmation = random_password
    Participant.create(member: @student)
    if @student.save
      UserMailer.login_email(@student, @student.user, random_password).deliver_now
      render 'new'
    else
      redirect_to root_path
    end
  end

  private

  def prepare_teacher
    @teacher = Teacher.find(current_user.meta.id)
  end

  def student_params
    params.require(:student).permit(:name, user_attributes: [:email])
  end

end
