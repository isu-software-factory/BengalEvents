class HomeroutesController < ApplicationController

  def routes
    if user_signed_in?
      if current_user.meta_type == "Teacher"
        redirect_to teacher_path(current_user.meta.id)
      elsif current_user.meta_type == "Student"
        redirect_to student_path(curent_user.meta.id)
      elsif current_user.meta_type == "Coordinator"
        redirect_to occasions_path
      elsif current_user.meta_type == "Sponsor"
        redirect_to occasions_path
        else
        redirect_to teacher_path(current_user.meta.id)
      end

    end
  end
end
