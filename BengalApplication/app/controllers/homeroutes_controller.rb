class HomeroutesController < ApplicationController
  def home
    # user signed in then redirect them to their page
    if user_signed_in?
      redirect_to profile_path(current_user.id)
      #redirect_to controller: "homeroutes", action: "user", id: current_user.id
    end
    # if user isn't signed in then show activities for current occasion
    unless Event.first.nil?
      @event = Event.first
      @activities = @event.activities
    end
  end

   def user
     role = current_user.roles.first.role_name
     @user = User.find(params[:id])
     @admin = false
     if role == "Teacher" || role == "Admin" || role == "Coordinator"
       @admin = true
     end

     @show = check_user

     add_breadcrumb "Home", root_path

     if check_user
       add_breadcrumb @user.first_name, root_path(@user.id)
     end

   end

  def new
    @controller = params[:name]
    @user = User.new
  end

  def create
    @user = params[:role]

    if @user == "Teacher"
      create_teacher
    elsif @user == "Student"
      create_student
    else
      create_sponsor
    end
  end

  private

  def check_user
    if (params[:id].to_i != current_user.id)
      true
    else
      false
    end
  end

  def create_teacher
    # create teacher and role
    @user = User.new(user_params)
    @user.roles << Role.find_by(role_name: "Teacher")
    @user.roles << Role.find_by(role_name: "Participant")

    if @user.save
      # sign in teacher and redirect to students new page
      sign_in @user
      @students = Arra.new
      redirect_to controller: "homeroutes", action: "new", name: "Student"
    else
      render :new
    end
  end

  def create_student
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


  def remove_students(names)
    students = Student.all

    for student in students
      # remove student
      unless names.include?(student.name)
        student.delete
      end
    end
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

  def create_sponsor
    # create sponsor and role
    @user = User.new(user_params)
    @user.roles << Role.find_by(role_name: "Sponsor")

    if @user.save
      # sign in sponsor and redirect to students new page
      sign_in @user

      redirect_to controller: "events", action: "show"
    else
      render :new
    end
  end

  def user_params
    params.permit(:user_name, :email, :password, :password_confirmation, :first_name, :last_name)
  end

end
