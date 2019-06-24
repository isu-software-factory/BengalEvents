class HomeroutesController < ApplicationController

  def routes
    if user_signed_in?
      if current_user.teacher?
        if current_user.teacher == nil
          redirect_to new_teacher_path
        else
          redirect_to teacher_path
        end
      end
    end
  end
end
