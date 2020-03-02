class HomeroutesController < ApplicationController
  def home
    # user signed in then redirect them to their page
    if user_signed_in?
      redirect_to controller: "events", action: "index", role: "User", id: current_user.id
    end
    # if user isn't signed in then show activities for current occasion
    unless Event.first.nil?
      @event = Event.first
      @activities = @event.activities
    end
  end

  def user
    @role = current_user.roles.first.role_name
    @user = User.find(params[:id])
    @admin = false
    @events = Event.all

    if @role == "Teacher"
      @admin = true
      @students = Teacher.find(current_user.id).users
    end

    if @role == "Student" || !@show
      @teams = 1
      @count = 0
      @increase = 1
      for i in 1..@user.teams.count
        if @increase == 4
          @teams += 1
          @increase = 0
        end
        @increase += 1
      end
      # list of card styles
      @random_card = %w[rorange growling-gray bg-dark orange]
    end

    @show = check_user
    add_breadcrumb "Home", root_path(role: "User", id: @user.id)

    if check_user
      add_breadcrumb @user.first_name + " Profile", profile_path(@user)
    end

  end

  def new
    @controller = params[:name]
    if @controller == "Student"
      @students = Teacher.find(current_user.id).users
    else
      @user = User.new
    end
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


  def reset_password
    @user = User.find(params[:id])
    random_password = rand(36 ** 8).to_s(36)
    @user.reset_password(random_password, random_password)
    #UserMailer.reset_email(current_user, @user, random_password).deliver_now
    render json: {data: {success: true}}
  end




  private

  def check_user
    if (params[:id].to_i != current_user.id)
      false
    else
      true
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
    first_names = student_names("first")
    last_names = student_names("last")
    emails = student_emails
    redirect = false

    count = 0

    # check to see if student is already in the database
    for email in emails do
      unless User.exists?(:email => email) || User.exists?(:user_name => email)
        redirect = create_students(first_names[count], last_names[count], email);
      end
      count += 1
    end

    # check to see if a student was removed
    remove_students(emails)


    if redirect[0]
      redirect_to root_path
    else
      flash[:errors] = redirect[1]
      redirect_back(fallback_location: root_path)
    end
  end


  def remove_students(email)
    students = User.all

    for student in students
      # remove student
      unless email.include?(student.email) || (student.id == current_user.id)
        student.delete
      end
    end
  end

  # returns all the names from params into an array
  def student_names(name)
    names = []
    # add each name into names array

    params.each do |key, value|
      if key.start_with?(name)
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
  def create_students(f_name, l_name, email1)
    @student = User.new(first_name: f_name, last_name: l_name)
    @teacher = Teacher.find(current_user.id)
    if email1.include?("@")
      @student.email = email1
      @student.user_name = create_user_name(f_name, l_name)
    else
      @student.user_name = email1
      @student.email = ""
    end
    @teacher.users << @student

    # create password
    random_password = rand(36 ** 8).to_s(36)
    @student.password = random_password
    @student.password_confirmation = random_password


    # send an email to student if student saves
    if @student.save
      #UserMailer.login_email(@student, @student.user, random_password).deliver_now
      errors = [true, @student.errors.full_messages]
      return errors
    else
      errors = [false, @student.errors.full_messages]
      return errors
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

  def create_user_name(f_name, l_name)
    user_name = l_name + f_name + rand(36 ** 2).to_s(36)
    user_name
  end

  def user_params
    params.permit(:user_name, :email, :password, :password_confirmation, :first_name, :last_name)
  end

end
