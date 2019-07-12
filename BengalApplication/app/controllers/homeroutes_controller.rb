class HomeroutesController < ApplicationController

  def routes
    if user_signed_in?
      if current_user.meta_type == "Teacher"
        redirect_to teacher_path(current_user.meta.id)
      elsif current_user.meta_type == "Student"
        redirect_to student_path(current_user.meta.id)
      elsif current_user.meta_type == "Coordinator"
        redirect_to occasion_path(current_user.meta.id)
      elsif current_user.meta_type == "Sponsor"
        redirect_to occasion_path(current_user.meta.id)
      else
        redirect_to teacher_path(current_user.meta.id)
      end

    end
  end
end
