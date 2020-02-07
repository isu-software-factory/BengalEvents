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

  # def user
  #   role = current_user.roles.first.role_name
  #   @user = User.find(params[:id])
  #   @admin = false
  #   if role == "Teacher" || role == "Admin" || role == "Coordinator"
  #     @admin = true
  #   end
  #
  #   @show = check_user
  # end


  private

  def check_user
    if (params[:id].to_i != current_user.id)
      true
    else
      false
    end
  end

end
