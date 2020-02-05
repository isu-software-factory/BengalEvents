class HomeroutesController < ApplicationController
  def home
    # user signed in then redirect them to their page
    if user_signed_in?
      role = current_user.roles.first.role_name
      if role == "Teacher"
        redirect_to teacher_path(current_user.id)
      elsif role == "Student"
        redirect_to student_path(current_user.id)
      end
    end
    # if user isn't signed in then show activities for current occasion
    unless Event.first.nil?
      @event = Event.first
      @activities = @event.activities
    end
  end

  def user
    role = current_user.roles.first.role_name
    @admin = false
    if role == "Teacher" || role == "Admin" || role == "Coordinator"
      @admin = true
    end
  end


end
