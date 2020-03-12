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
    @user = User.find(params[:id])
    @role = @user.roles.first.role_name
    @current_user_role = current_user.roles.first.role_name
    @admin = false
    @events = Event.all

    if @current_user_role == "Teacher"
      @admin = true
      @students = Teacher.find(current_user.id).users
    elsif @current_user_role == "Coordinator"
      if @role == "Teacher"
        @admin = true
        @students = Teacher.find(@user.id).users
      end
    end

    if @current_user_role == "Student" || !@show
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
      add_breadcrumb @user.first_name + "'s Profile", profile_path(@user)
    end

  end

  def new
    @controller = params[:name]
    if @controller == "Student"
      @students = Teacher.find_by(user_id: current_user.id).users
      add_breadcrumb "Home", root_path(role: "User", id: current_user.id)
      add_breadcrumb current_user.first_name + "'s Profile", profile_path(current_user)
      add_breadcrumb "Add New Students", new_user_path("Student")
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

  def delete
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    redirect_to all_users_path, notice: "User deleted."
  end

  def reset_password
    @user = User.find(params[:id])
    random_password = rand(36 ** 8).to_s(36)
    @user.reset_password(random_password, random_password)
    #UserMailer.reset_email(current_user, @user, random_password).deliver_now
    render json: {data: {success: true}}
  end

  def all_users
    @teachers = Role.find_by(role_name: "Teacher").users
    @students = Role.find_by(role_name: "Student").users
    @sponsors = Role.find_by(role_name: "Sponsor").users

    add_breadcrumb "Home", root_path(role: "User", id: current_user.id)
    add_breadcrumb current_user.first_name  + "'s Profile", profile_path(current_user)
    add_breadcrumb "All Users", all_users_path
  end

  private

  def check_user
    if (params[:id].to_i != current_user.id && current_user.roles.first.role_name != "Coordinator")
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
    @teacher = Teacher.new(teacher_params)

    result = join_teacher(@teacher, @user)

    if result[0]
      # sign in teacher and redirect to students new page
      sign_in @user
      @students = Array.new
      redirect_to controller: "homeroutes", action: "new", name: "Student"
    else
      flash[:errors] = result[1]
      redirect_back(fallback_location: {controller: "homeroutes", action: "new", name: "Teacher"})
    end
  end

  def join_teacher(teacher, user)
    results = [true,]
    errors = []
    @user = user.save
    if !@user
      results[0] = false
      errors += user.errors.full_messages
      teacher.save
      errors += teacher.errors.full_messages
      errors.pop
    else
      teacher.user_id = user.id
      unless teacher.save
        results[0] = false
        errors += teacher.errors.full_messages
      end
    end
    @user = user
    results[1] = errors
    results
  end

  def create_student
    first_names = student_names("first")
    last_names = student_names("last")
    emails = student_emails
    redirect = [true,]
    user_ids = student_ids
    count = 0

    # check to see if student is already in the database
    user_ids.each do |id|
      unless User.exists?(id: id)
        redirect = create_students(first_names[count], last_names[count], emails[count], id);
      end
      count += 1
    end

    # check to see if a student was removed
    remove_students(user_ids)

    # check for updates in students
    redirect = update_students(first_names, last_names, emails, user_ids)


    if redirect[0]
      flash[:notice] = "Students were updated successfully"
      redirect_to profile_path(current_user)
    else
      flash[:alert] = redirect[1]
      redirect_back(fallback_location: profile_path(current_user))
    end
  end

  # will update student details
  def update_students(f_names, l_names, emails, ids)
    count = 0
    errors = [true]
    ids.each do |id|
      if f_names[count] == ""
        errors = [false, "First name can't be blank"]
      elsif l_names[count] == ""
        errors = [false, "Last name can't be blank"]
      elsif emails[count] == ""
        errors = [false, "User name can't be blank"]
      else
        student = User.find(id)
        unless student.first_name == f_names[count]
          User.update(student.id, first_name: f_names[count])
        end
        unless student.last_name == l_names[count]
          User.update(student.id, last_name: l_names[count])
        end
        if emails[count].include?("@")
          unless student.email == emails[count]
            User.update(student.id, email: emails[count])
          else
            User.update(student.id, user_name: emails[count])
          end
        end
      end
      count += 1
    end
    errors
  end

  def remove_students(ids)
    students = User.all

    students.each do |student|
      # remove student
      unless ids.include?(student.id) || (student.id == current_user.id)
        student.delete
      end
    end

  end

  def student_ids
    ids = []

    params.each do |key, value|
      if key.start_with?("first")
        id = key.split("_")
        ids << id[1].to_i
      end
    end
    ids
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
  def create_students(f_name, l_name, email1, id)
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
      @student.roles << Role.find_by(role_name: "Student")
      id = @student.id
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

  def teacher_params
    params.permit(:school_name, :chaperone_count)
  end

end
