class HomeroutesController < ApplicationController

  def routes
    if user_signed_in?
      if current_user[:role] == "teacher"
        if current_user.teacher == nil
          redirect_to new_teacher_path
        else
          redirect_to teacher_path(current_user.teacher.id)
        end
      end
      if current_user[:role] == "sponsor"
        redirect_to occasions_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end
