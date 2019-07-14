class RegistrationsController < ApplicationController

  def register
    event = EventDetail.find(params[:id])
    @student = Student.find(current_user.meta.id)
    event.students << @student
    redirect_to @student
  end
  def index
    @occasions = Occasion.all
  end

  def new
    # get student teacher
    @student = Student.find(current_user.meta.id)
    @occasions = Occasion.all

  end
  


  private
    def registration_params
      params.require(:registrations).permit!
    end
end
