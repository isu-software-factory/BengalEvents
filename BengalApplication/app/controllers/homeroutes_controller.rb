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
      create_students
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
# asdfa
    if @user.save
      # sign in teacher and redirect to students new page
      sign_in @user
      @students = Arra.new
      redirect_to controller: "homeroutes", action: "new", name: "Student"
    else
       asd
      render :new
    end
  end

  def create_student

  end

  def create_sponsor

  end

  def user_params
    params.permit(:user_name, :email, :password, :password_confirmation, :first_name, :last_name)
  end

end
