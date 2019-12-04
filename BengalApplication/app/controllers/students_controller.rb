class StudentsController < ApplicationController
  before_action :prepare_teacher, only: %i[new create student_emails student_names]
  before_action :authenticate_user!, except: :new

  def index
    @students = Student.where('teacher_id = ?', params[:teacher_id])
  end

  # shows printing page for schedule
  def print_schedule
    @student = Student.find(params[:id])
  end

  # shows the schedule of a student
  def schedule
    @student = Student.find(params[:id])
    # print path
    @print_path =
        # add breadcrumbs
        add_breadcrumb 'Home', current_user.meta
    add_breadcrumb "#{@student.name}'s Schedule", controller: 'students', action: 'schedule', id: @student.id
  end

  # shows student main page
  def show
    @student = Student.find(params[:id])
    authorize @student
    # add breadcrumbs
    add_breadcrumb 'Home', @student
    # get the number of teams per row
    # for the student page
    @teams = 1
    @count = 0
    @increase = 1
    for i in 1..@student.teams.count
      if @increase == 4
        @teams += 1
        @increase = 0
      end
      @increase += 1
    end

    # list of card styles
    @random_card = %w[rorange growling-gray bg-dark orange]
  end

  # shows the student new page
  def new
    @student = Student.new
    @student.build_user

    add_breadcrumb "Home", current_user.meta
    add_breadcrumb "Adding Students", new_student_path
    authorize @student
  end

  # creates a new student
  def create
    names = student_names
    emails = student_emails
    authorize Student

    # for each student in array, create a student
    for each in 0..(names.count - 1) do
      success = create_students(names[each], emails[each])
    end
    redirect_to teacher_path(@teacher.id)
  end

  private

  def prepare_teacher
    @teacher = Teacher.find(current_user.meta.id)
  end

  # returns all the names from params into an array
  def student_names
    names = []
    # add each name into names array
    for num in 1..@teacher.student_count do
      names << params['name' + num.to_s]
    end
    names
  end

  # returns emails of all students as an array
  def student_emails
    emails = []
    # adds every email from params to emails array
    for num in 1..@teacher.student_count do
      emails << params['email' + num.to_s]
    end
    emails
  end

  # creates a student
  def create_students(name1, email1)
    @student = Student.new(name: name1, user_attributes: { email: email1 }, participant_attributes: {})
    @teacher.students << @student

    # create password
    random_password = rand(36**8).to_s(36)
    @student.user.password = random_password
    @student.user.password_confirmation = random_password

    # send an email to student if student saves
    if @student.save
      UserMailer.login_email(@student, @student.user, random_password).deliver_now
      true
    else
      false
    end
  end
end
