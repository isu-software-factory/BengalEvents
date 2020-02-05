class StudentsController < ApplicationController
  before_action :authenticate_user!, except: :new
  def new

    add_breadcrumb "Home", root_path
    add_breadcrumb "Adding Students", new_student_path
  end

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



  def update_new_students
    names = student_names
    emails = student_emails
    redirect = false

    count = 0

    # check to see if student is already in the database
    for email in emails do
      unless User.exists?(:email => email)
        redirect = create_students(names[count], email);
      end
      count += 1
    end

    # check to see if a student was removed
    remove_students(names)


    if redirect
      redirect_to current_user.meta
    else
      flash[:errors] = @student.errors.full_messages
      flash[:errors] = @student.user.errors.full_messages
      redirect_back(fallback_location: current_user)
    end
  end

  def show
    @student = User.find(params[:id])
    authorize @student, policy_class: StudentPolicy
    # add breadcrumbs
    add_breadcrumb 'Home', root_path
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

  private

  def remove_students(names)
    students = Student.all

    for student in students
      # remove student
      unless names.include?(student.name)
        student.delete
      end
    end
  end


  def prepare_teacher
    @teacher = Teacher.find(current_user.meta.id)
  end

  # returns all the names from params into an array
  def student_names
    names = []
    # add each name into names array

    params.each do |key, value|
      if key.start_with?("name")
        names << value
      end
    end
    names
  end

  # returns emails of all students as an array
  def student_emails
    emails = []
    # adds every email from params to emails array
    params.each do |key, value|
      if key.start_with?("email")
        emails << value
      end
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
      #UserMailer.login_email(@student, @student.user, random_password).deliver_now
      true
    else
      false
    end
  end

end
