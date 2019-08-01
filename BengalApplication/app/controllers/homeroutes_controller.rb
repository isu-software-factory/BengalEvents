class HomeroutesController < ApplicationController

  def routes
    if user_signed_in?
      if current_user.meta_type == "Teacher"
        redirect_to teacher_path(current_user.meta.id)
      elsif current_user.meta_type == "Student"
        redirect_to student_path(current_user.meta.id)
      elsif current_user.meta_type == "Coordinator"
        redirect_to coordinator_path(current_user.meta.id)
      elsif current_user.meta_type == "Sponsor"
        redirect_to sponsor_path(current_user.meta.id)
      end
    end
    unless Occasion.first == nil
      @occasion = Occasion.first
      @events = @occasion.events
    end

  end
end
