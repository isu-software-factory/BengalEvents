class StudentsController < ApplicationController
  before_action :prepare_teacher, only: [:new, :create, :student_emails, :student_names]
  before_action :authenticate_user!, except: :new

   def index
     @students = Student.where("teacher_id = ?", params[:teacher_id])
   end

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
    names = student_names
    emails = student_emails
    authorize Student

    for each in 1..names.count do
      # if an error occurs
      success = create_students(names[each], emails[each])
    end
    redirect_to teacher_path(@teacher.id)
  end

  private

  def prepare_teacher
    @teacher = Teacher.find(current_user.meta.id)
  end

  def student_names
    names = []
    for num in 1..@teacher.student_count do
      names << params["name" + num.to_s]
    end
    names
  end

  def student_emails
    emails = []
    for num in 1..@teacher.student_count do
      emails << params["email" + num.to_s]
    end
    emails
  end

  def create_students(name, email)
    @student = Student.new(name: name, user_attributes: {email: email}, participant_attributes: {})
    @teacher.students << @student
    # create password
    random_password = ('0'..'z').to_a.shuffle.first(8).join
    @student.user.password = random_password
    @student.user.password_confirmation = random_password

    if @student.save
      UserMailer.login_email(@student, @student.user, random_password).deliver_now
      true
    else
      false
    end

  end
end
